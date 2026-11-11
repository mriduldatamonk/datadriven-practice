# The Social Graph – Approach & Reasoning

## 1. Understanding the Problem

The input is a nested list.

Each inner list represents one record.

- Two names = mutual friendship.
- One name = standalone person.
- A person can appear in multiple records.
- Every unique person must appear in the output dictionary.

The objective is to calculate the number of friends for each person.

## 2. Approach 1 – Dictionary Initialization

Start with an empty dictionary:

```python
op = {}
```

Traverse the nested list using indexed iteration:

```python
for i in range(len(groups)):
    for j in range(len(groups[i])):
        name = groups[i][j]
        op[name] = 0
```

### Why use a dictionary?

A dictionary stores key-value pairs.

Here:
- Key = Person's name.
- Value = Friend count.

Dictionary keys are unique.

If Ana appears multiple times, assigning:

```python
op["Ana"] = 0
```

does not create duplicate keys. It updates the existing key.

### Important learning

- Lists allow duplicate elements.
- Sets store unique elements.
- Dictionaries maintain unique keys, but values can be duplicated.

## 3. Approach 2 – Friendship Counting

After initialization, traverse the records again.

```python
for i in range(len(groups)):
    if len(groups[i]) == 2:
        op[groups[i][0]] += 1
        op[groups[i][1]] += 1
```

### Why two passes?

The first pass ensures every person exists in the dictionary.

The second pass performs the actual counting.

This separation avoids accidentally resetting an existing count to zero.

### Example

First record:

```python
["Ana", "Ben"]
```

Dictionary:

```python
{"Ana": 1, "Ben": 1}
```

Second record:

```python
["Ana", "Cleo"]
```

Dictionary:

```python
{"Ana": 2, "Ben": 1, "Cleo": 1}
```

Ana's count increases because she has another friend.

## 4. Debugging Journey

### Mistake 1: Incorrect indexing

Initial attempt:

```python
op[i] = groups[i][i]
```

Problem:

The outer list index and inner list index are different.

Using the same index for both can cause IndexError.

Correction:

```python
name = groups[i][j]
op[name] = 0
```

### Mistake 2: Missing return statement

A function without an explicit return statement returns None.

Correction:

```python
return op
```

### Mistake 3: Duplicate dictionary keys

Initially, it appeared that Ana should be inserted twice.

However, dictionary keys are unique. Reassigning an existing key updates its value.

### Mistake 4: Resetting friend counts

If initialization and counting are mixed carelessly, an existing count can be reset to zero.

Correction: Separate initialization and counting into two passes.

### Mistake 5: IndexError in friendship counting

Accessing:

```python
groups[i][1]
```

without checking the record length causes an error for single-name records.

Correction:

```python
if len(groups[i]) == 2:
```

### Mistake 6: Indentation

Python uses indentation to define blocks.

`continue` must be indented inside its corresponding if statement.

## 5. Data Validation

Real-world data can contain malformed records.

Examples:

```python
[]
["Ana", "Ben", "Cleo"]
["Ana", "Ana"]
```

Business decision: Skip malformed records.

Validation rules:

1. Accept one-name records.
2. Accept two-name records.
3. Reject empty records.
4. Reject records with more than two names.
5. Reject self-friendships.

We extracted validation into a reusable function:

```python
def is_valid_record(group):
    if len(group) not in (1, 2):
        return False

    if len(group) == 2 and group[0] == group[1]:
        return False

    return True
```

### Why validate in both passes?

Both initialization and counting must use the same validation rules.

Otherwise, an invalid record could introduce an unwanted person into the dictionary or corrupt the final count.

## 6. Duplicate Friendship Handling

Consider:

```python
["Ana", "Ben"]
["Ana", "Ben"]
```

Two possible interpretations:

**Record-based counting**

Both records count separately.

Result: Ana = 2, Ben = 2.

**Distinct-friend counting**

Ana and Ben count as friends only once.

For this requirement, use a set:

```python
seen = set()

pair = tuple(sorted(["Ana", "Ben"]))

if pair not in seen:
    seen.add(pair)
```

Sorting normalizes the pair.

Therefore:

```python
("Ana", "Ben")
("Ben", "Ana")
```

are treated as the same friendship.

Important: The business requirement determines which approach is correct.

## 7. Time and Space Complexity

Let:

- N = Total number of records.
- U = Number of unique people.

| Operation | Complexity |
|---|---|
| Dictionary initialization | O(N) |
| Friendship counting | O(N) |
| Overall time complexity | O(N) |
| Auxiliary space complexity | O(U) |

Python dictionary operations have average-case O(1) insertion and lookup.

Therefore:

**Time Complexity: O(N)**

**Space Complexity: O(U)**

## 8. Scaling to 500 Million Records

A list containing 500 million records may not fit into memory.

### Solution: Streaming

Instead of loading the entire file:

```python
groups = [...]
```

Read records incrementally using a generator:

```python
def read_records(file_path):
    with open(file_path) as file:
        for line in file:
            yield line
```

Only one record needs to be read at a time.

### What still occupies memory?

The output dictionary still needs to store the count for every unique person.

Its space complexity remains O(U).

If the dictionary itself cannot fit into memory, consider:

- External databases.
- Disk-based aggregation.
- Partitioning.
- Distributed processing with Apache Spark.

### Important distinction

Streaming reduces input memory consumption.

Distributed processing distributes computation across multiple machines.

They solve different problems.

## 9. Key Learnings

1. Understand nested data structures before coding.
2. Use dictionaries for key-based counting.
3. Separate initialization and aggregation.
4. Understand how dictionary keys behave.
5. Validate data before processing.
6. Clarify duplicate-handling requirements.
7. Understand time and space complexity.
8. Consider streaming for large input files.
9. Distinguish streaming from distributed processing.

## 10. Future Improvements

- Implement distinct-friend counting.
- Refactor the two-pass solution into reusable components.
- Implement a single-pass approach.
- Process records from CSV or JSON files.
- Explore Spark-based distributed aggregation.

---

**Learning objective:** Understand not only how to solve the problem, but also why each implementation decision is made and how the solution behaves with real-world data.