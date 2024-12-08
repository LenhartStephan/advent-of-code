import day00


def get_input() -> list[str]:
    return day00.get_lines(8)


def get_frequency_locations(grid: list[str]) -> dict[str, list[tuple[int, int]]]:
    frequency_locations: dict[str, list[tuple[int, int]]] = {}
    for y in range(len(grid)):
        for x in range(len(grid[0])):
            char = grid[y][x]
            if char == ".":
                continue
            if char not in frequency_locations:
                frequency_locations[char] = [(x, y)]
            else:
                frequency_locations[char].append((x, y))
    return frequency_locations


def get_anti_locations(resonant_harmonics: bool = False) -> set[tuple[int, int]]:
    anti_locations = set()
    grid = get_input()
    frequency_locations = get_frequency_locations(grid)
    for (frequency, locations) in frequency_locations.items():
        for (loc1_x, loc1_y) in locations:
            for (loc2_x, loc2_y) in locations:
                if (loc1_x, loc1_y) == (loc2_x, loc2_y):
                    continue
                (dx, dy) = (loc1_x - loc2_x, loc1_y - loc2_y)
                a1, a2 = (loc1_x + dx, loc1_y + dy)

                if not resonant_harmonics:
                    if 0 <= a1 < len(grid) and 0 <= a2 < len(grid[0]):
                        anti_locations.add((a1, a2))
                    continue

                anti_locations.add((loc1_x, loc1_y))
                while 0 <= a1 < len(grid) and 0 <= a2 < len(grid[0]):
                    anti_locations.add((a1, a2))
                    a1, a2 = (a1 + dx, a2 + dy)
    return anti_locations


def part01():
    print(f"[Part 1] {len(get_anti_locations())}")


def part02():
    print(f"[Part 2] {len(get_anti_locations(True))}")


if __name__ == '__main__':
    part01()
    part02()
