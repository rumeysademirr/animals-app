import List "mo:base/List";
import Option "mo:base/Option";
import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";

actor Animals {

  /**
   * Types
   */

  // Hayvan kimliği türü.
  public type AnimalId = Nat32;

  // Hayvan türü.
  public type Animal = {
    name : Text;
    species : Text;  // Tür (Köpek, Kedi, vb.)
    characteristics : List.List<Text>;  // Özellikler (örneğin, "sadık", "oyuncu")
  };

  /**
   * Application State
   */

  // Kullanılabilir bir sonraki hayvan kimliği.
  private stable var next : AnimalId = 0;

  // Hayvan veri deposu.
  private stable var animals : Trie.Trie<AnimalId, Animal> = Trie.empty();

  /**
   * High-Level API
   */

  // Yeni bir hayvan ekle.
  public func create(animal : Animal) : async AnimalId {
    let animalId = next;
    next += 1;
    animals := Trie.replace(
      animals,
      key(animalId),
      Nat32.equal,
      ?animal,
    ).0;
    return animalId;
  };

  // Bir hayvan bilgilerini oku.
  public query func read(animalId : AnimalId) : async ?Animal {
    let result = Trie.find(animals, key(animalId), Nat32.equal);
    return result;
  };

  // Bir hayvan bilgilerini güncelle.
  public func update(animalId : AnimalId, animal : Animal) : async Bool {
    let result = Trie.find(animals, key(animalId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      animals := Trie.replace(
        animals,
        key(animalId),
        Nat32.equal,
        ?animal,
      ).0;
    };
    return exists;
  };

  // Bir hayvanı sil.
  public func delete(animalId : AnimalId) : async Bool {
    let result = Trie.find(animals, key(animalId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      animals := Trie.replace(
        animals,
        key(animalId),
        Nat32.equal,
        null,
      ).0;
    };
    return exists;
  };

  /**
   * Utilities
   */

  // Hayvan kimliğinden bir trie anahtarı oluştur.
  private func key(x : AnimalId) : Trie.Key<AnimalId> {
    return { hash = x; key = x };
  };
}
