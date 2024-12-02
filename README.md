# animals-app

This project defines an `Animals` actor in Motoko to manage animals. It supports creating, reading, updating, and deleting animal data, with each animal having a unique ID. Data is stored in a Trie for efficient access.

## Features

- **Create Animal**: Add a new animal.
- **Read Animal**: Get details of an animal by ID.
- **Update Animal**: Modify an existing animal.
- **Delete Animal**: Remove an animal by ID.

## API

### Types

- **AnimalId**: Unique identifier for an animal (`Nat32`).
- **Animal**: Contains `name`, `species`, and `characteristics` (List of strings).

### Functions

- `create(animal: Animal) -> async AnimalId`: Adds a new animal and returns its ID.
- `read(animalId: AnimalId) -> async ?Animal`: Retrieves an animal's details.
- `update(animalId: AnimalId, animal: Animal) -> async Bool`: Updates an animal’s data.
- `delete(animalId: AnimalId) -> async Bool`: Deletes an animal.

## Usage

1. Deploy the `Animals` actor to the Internet Computer (IC).
2. Use the provided functions to manage animals.

## License

MIT License - see [LICENSE](LICENSE).
