import mmh3
import string
import random

def random_key(length=8):
    """Generate a random string of fixed length."""
    letters = string.ascii_lowercase
    return ''.join(random.choice(letters) for _ in range(length))

def hashes(key, size):
    """Compute the two hash values for a given key."""
    h1 = mmh3.hash(key, 1) % size
    h2 = mmh3.hash(key, 2) % size
    return h1, h2

def find_looping_elements_continuous(size=1024, num_elements=8, batch_size=100000, max_batches=10):
    """Continuously search for a set of elements that have the same two hash values."""
    hashed_keys = {}
    
    # Limit the number of batches to prevent infinite loop
    for batch in range(max_batches):
        # Generate a batch of keys
        for _ in range(batch_size):
            key = random_key()
            h1, h2 = hashes(key, size)
        
            # Check if there are other keys with the same hash values
            if (h1, h2) in hashed_keys:
                hashed_keys[(h1, h2)].append(key)
            else:
                hashed_keys[(h1, h2)] = [key]
        
        # Check if we found enough keys that collide
        for keys in hashed_keys.values():
            if len(keys) >= num_elements:
                return keys[:num_elements]
    
    return None

def validate_elements(elements, size):
    """Validate that the given elements have the same hash values."""
    if not elements:
        return False
    
    h1_values = [hashes(key, size)[0] for key in elements]
    h2_values = [hashes(key, size)[1] for key in elements]
    
    # Check if all h1 values are the same
    if len(set(h1_values)) != 1:
        return False
    
    # Check if all h2 values are the same
    if len(set(h2_values)) != 1:
        return False
    
    return True

# Test the function
looping_elements = find_looping_elements_continuous()
print(looping_elements)

# Check if the code is valid
valid = validate_elements(looping_elements, 128)
if valid:
    print("The found elements are valid!")
else:
    print("The found elements are not valid.")

