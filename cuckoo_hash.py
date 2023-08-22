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
        # Each table has 'size' buckets, and each bucket can store up to 4 items
        self.table1 = [None] * size
        self.table2 = [None] * size
        for i in range(size):
            self.table1[i] = [None] * 4
            self.table2[i] = [None] * 4
        self.MAX_RELOCATIONS = 32 # Reduced for quick observation

    def _hashes(self, key):
        h1 = mmh3.hash(key, 1) % self.size
        h2 = mmh3.hash(key, 2) % self.size
        return h1, h2

    def insert(self, key, value):
        relocations = 0
        for _ in range(self.MAX_RELOCATIONS):
            relocations += 1
            
            h1, h2 = self._hashes(key)
            # Try inserting in table1
            for slot in range(4):
                if self.table1[h1][slot] is None:
                    self.table1[h1][slot] = (key, value)
                    return True, relocations

            # Try inserting in table2
            for slot in range(4):
                if self.table2[h2][slot] is None:
                    self.table2[h2][slot] = (key, value)
                    return True, relocations

            # Displace a random item from table1
            slot = random.choice(range(4))
            key, value, self.table1[h1][slot] = self.table1[h1][slot][0], self.table1[h1][slot][1], (key, value)

        print("Failed to insert after maximum relocations. Consider resizing or rehashing.")
        return False, relocations

    def get(self, key):
        h1, h2 = self._hashes(key)
        
        # Check table1
        for slot in self.table1[h1]:
            if slot and slot[0] == key:
                return slot[1]
        
        # Check table2
        for slot in self.table2[h2]:
            if slot and slot[0] == key:
                return slot[1]

        return None

    def delete(self, key):
        h1, h2 = self._hashes(key)
        
        # Check table1
        for i in range(4):
            if self.table1[h1][i] and self.table1[h1][i][0] == key:
                self.table1[h1][i] = None
                return True
        
        # Check table2
        for i in range(4):
            if self.table2[h2][i] and self.table2[h2][i][0] == key:
                self.table2[h2][i] = None
                return True

        return False
    
    def load_factor(self):
        filled_slots = sum(1 for bucket in self.table1 for slot in bucket if slot is not None)
        filled_slots += sum(1 for bucket in self.table2 for slot in bucket if slot is not None)
        return filled_slots / (self.size * 4 * 2)

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
