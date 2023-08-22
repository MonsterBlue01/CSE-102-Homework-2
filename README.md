# 2-4 Cuckoo Hash Table Implementation

This code provides an implementation of a 2-4 Cuckoo Hash Table, a variant of Cuckoo Hashing where each bucket can hold up to 4 items.

## Features
1. **Two Hash Functions**: Uses two hash functions to determine the positions of keys in two separate tables.
2. **Collision Handling**: In case of collisions, it uses the cuckoo hashing approach to relocate items.
3. **Load Factor Calculation**: Can determine the load factor, indicating the fraction of the hash table's capacity that's currently occupied.

## How to Use

### Prerequisites
- Ensure you have Python installed on your machine.
- The `mmh3` module is required. You can install it using pip:
  ```
  pip install mmh3
  ```

### Running the Code

1. **Inserting Keys**: The code is designed to insert a specific number of randomly generated keys into the hash table. The number of keys to be inserted should be provided as a command-line argument.

   Example:
   ```bash
   python cuckoo_hash.py 100
   ```
   This command will insert 100 random keys into the hash table.

2. **Results**: After inserting the keys, the code calculates the average number of relocations required during insertions and the current load factor of the hash table. The results are appended to a file named `result.txt`.

   The format of the results is:
   ```
   Number of Keys: [Number of Keys], Average Relocations: [Average Relocations], Load Factor: [Load Factor]
   ```

## Code Structure

- **`random_key(length=8)`**: Generates a random string of lowercase English letters. The default length is 8, but it can be changed by providing a different length as an argument.
- **`CuckooHashTable` Class**: Represents the 2-4 Cuckoo Hash Table.
  - **`insert(key, value)`**: Inserts a key-value pair into the hash table.
  - **`get(key)`**: Retrieves the value associated with the provided key.
  - **`delete(key)`**: Deletes the key-value pair associated with the provided key.
  - **`load_factor()`**: Calculates and returns the load factor of the hash table.

---

This README provides an overview of the functionality, guides users on prerequisites and usage, and offers a brief on the main components of the code. It should help users understand and use the code effectively.