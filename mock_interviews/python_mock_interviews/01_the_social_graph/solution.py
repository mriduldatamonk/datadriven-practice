def is_valid_record(group: list[str]) -> bool:
    """
    Validate each record before processing.
    Valid records contain either one or two distinct names.
    """

    if len(group) not in (1, 2):
        return False

    if len(group) == 2 and group[0] == group[1]:
        return False

    return True


def count_friends(groups: list[list[str]]) -> dict[str, int]:

    op = {}

    # PART 1: Initialize every unique person with count 0
    for i in range(len(groups)):

        if not is_valid_record(groups[i]):
            continue

        for j in range(len(groups[i])):
            name = groups[i][j]
            op[name] = 0

    # PART 2: Count friendships
    for i in range(len(groups)):

        if not is_valid_record(groups[i]):
            continue

        if len(groups[i]) == 2:
            op[groups[i][0]] += 1
            op[groups[i][1]] += 1

    return op


# Test input
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

result = count_friends(groups)

print(result)


# Expected output:
# {
#     'Ana': 2,
#     'Ben': 3,
#     'Cleo': 2,
#     'Dan': 1,
#     'Ray': 1,
#     'Mia': 1,
#     'Sam': 0,
#     'Pat': 0
# }


# Additional test: malformed records
malformed_groups = [
    ["Ana", "Ben"],
    [],
    ["Cleo", "Dan", "Sam"],
    ["Ray"],
    ["Mia", "Mia"],
    ["Ana", "Cleo"]
]

print(count_friends(malformed_groups))


# Additional test: duplicate friendships
duplicate_groups = [
    ["Ana", "Ben"],
    ["Ana", "Ben"],
    ["Ben", "Cleo"]
]

print(count_friends(duplicate_groups))

# Note:
# The current implementation counts duplicate records separately.
# Distinct-friend counting is a separate business requirement.