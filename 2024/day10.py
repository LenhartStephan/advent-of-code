import day00


def get_input() -> list[list[int]]:
    return [[int(item) for item in line] for line in day00.get_lines(10)]


def get_starts(grid: list[list[int]]) -> list[tuple[int, int]]:
    return [(iy, ix) for iy, row in enumerate(grid) for ix, elm in enumerate(row) if elm == 0]


def get_paths(grid: list[list[int]], position: tuple[int, int], current_trail: list[tuple[int, int]] = None) -> list[
    list[tuple[int, int]]]:
    sx, sy = position
    elm = grid[sx][sy]
    if elm == 9:
        return [current_trail + [position]]

    current_trail = [position] if current_trail is None else current_trail + [position]
    trails = []

    directions = [(1, 0), (0, 1), (-1, 0), (0, -1)]
    for (dx, dy) in directions:
        if 0 <= sx + dx < len(grid) and 0 <= sy + dy < len(grid[0]):
            next_elm = grid[sx + dx][sy + dy]
            if next_elm == elm + 1:
                trails += get_paths(grid, (sx + dx, sy + dy), current_trail)

    return trails


def part01():
    counter = 0
    grid = get_input()
    for start in get_starts(grid):
        counter += len(set([path[-1] for path in get_paths(grid, start)]))
    print(f"[Part 1] {counter}")


def part02():
    counter = 0
    grid = get_input()
    for start in get_starts(grid):
        counter += len(get_paths(grid, start))
    print(f"[Part 2] {counter}")


if __name__ == '__main__':
    part01()
    part02()
