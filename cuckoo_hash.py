import mmh3
import string
import random

def random_key(length=8):
    """
    Generate a random string of fixed length.
    """
    letters = string.ascii_lowercase
    return ''.join(random.choice(letters) for _ in range(length))

class CuckooHashTable:
    def __init__(self, size=128):
        self.size = size
        self.table = [None] * (size * 4)  # Create a table with size * 4 slots
        self.MAX_RELOCATIONS = 32  # Reduced for quick observation

    def _hashes(self, key):
        h1 = mmh3.hash(key, 1) % self.size
        h2 = mmh3.hash(key, 2) % self.size
        return [h1, h1 + self.size, h2, h2 + self.size]  # Each hash points to two buckets

    def insert(self, key, value):
        relocations = 0
        for _ in range(self.MAX_RELOCATIONS):
            relocations += 1
            for index in self._hashes(key):
                if self.table[index] is None:
                    self.table[index] = (key, value)
                    return True, relocations  # Return number of relocations
                key, value, self.table[index] = self.table[index][0], self.table[index][1], (key, value)
        
        print("Failed to insert after maximum relocations. Consider resizing or rehashing.")
        return False, relocations

    def get(self, key):
        for index in self._hashes(key):
            if self.table[index] and self.table[index][0] == key:
                return self.table[index][1]
        return None

    def delete(self, key):
        for index in self._hashes(key):
            if self.table[index] and self.table[index][0] == key:
                self.table[index] = None
                return True
        return False
    
    def load_factor(self):
        filled_slots = sum(1 for slot in self.table if slot is not None)
        return filled_slots / (self.size * 4)

if __name__ == "__main__":
    import sys
    
    n_keys = int(sys.argv[1])  # Accept the number of keys from the command-line argument
    cuckoo = CuckooHashTable()

    relocation_counts = []
    for _ in range(n_keys):
        key = random_key()
        success, relocations = cuckoo.insert(key, f'value_of_{key}')
        relocation_counts.append(relocations)

    avg_relocations = sum(relocation_counts) / len(relocation_counts)
    load_factor = cuckoo.load_factor()

    # Append the results to result.txt
    with open("result.txt", "a") as f:
        f.write(f"Number of Keys: {n_keys}, Average Relocations: {avg_relocations}, Load Factor: {load_factor}\n")
