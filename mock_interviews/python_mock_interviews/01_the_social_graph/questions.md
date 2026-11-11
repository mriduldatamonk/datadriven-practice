# Python Interview Practice – Question 01

## The Social Graph

- **Platform:** [DataDriven.io](https://datadriven.io/interview/the_social_graph)
- **Difficulty:** Easy
- **Topic:** Python Collections, Dictionaries, Nested Loops
- **Status:** Completed

### Main Problem

You're given a social graph export where each record contains either:

- Two names representing mutual friendship.
- One name representing a person with no connections.

Return a dictionary mapping every person to their number of friends.

### Input

```python
groups = [
    ["Ana", "Ben"],
    ["Ana", "Cleo"],
    ["Ben", "Dan"],
    ["Ben", "Cleo"],
    ["Ray", "Mia"],
    ["Sam"],
    ["Pat"],
    ["Ana"]
]
```

### Expected Output

```python
{
    "Ana": 2,
    "Ben": 3,
    "Cleo": 2,
    "Dan": 1,
    "Ray": 1,
    "Mia": 1,
    "Sam": 0,
    "Pat": 0
}
```

---

## Follow-up Questions

### Follow-up 1: Data Validation

How would you handle malformed records such as:
- Empty lists.
- Records containing three names.
- Pairs containing the same person twice.

Choose whether to skip invalid records or set them aside.

### Follow-up 2: Duplicate Friendships

If the same pair appears twice, should both records increase the friend count?

How would you implement distinct friend counting?

### Follow-up 3: Scalability

Suppose the export contains 500 million records and cannot fit into memory.

- How would you read the input?
- What still needs to stay in memory?
- What is the time complexity of the current approach?

---

## Concepts Tested

- Lists and nested lists
- Dictionary creation and updates
- Nested loops and indexing
- Conditional statements
- Functions and return values
- Data validation
- Sets and duplicate detection
- Time and space complexity
- Generators and streaming
- Memory management

## Related Files

- Implementation: `solution.py`
- Reasoning and learnings: `approach.md`