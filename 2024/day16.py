from collections import defaultdict, deque
from math import inf

import day00


def get_input() -> list[str]:
    return day00.get_lines(16)


def pos(grid: list[str], of: str) -> tuple[int, int]:
    return next((ix, iy) for iy, row in enumerate(grid) for ix, elm in enumerate(row) if elm == of)


def path_info(grid: list[str], start: tuple[int, int]):
    visited = defaultdict(lambda: inf)
    path: set[tuple[int, int]] = {start}
    dq: deque[tuple[tuple[int, int], tuple[int, int], int, set[tuple[int, int]]]] = deque()
    dq.append((start, (1, 0), 0, path))

    path_cost = inf
    path_tiles = set()
    while dq:
        (pos_x, pos_y), (dx, dy), cost, path = dq.popleft()

        if cost > visited[(pos_x, pos_y), (dx, dy)] or cost > path_cost:
            continue
        visited[((pos_x, pos_y), (dx, dy))] = cost

        if grid[pos_y][pos_x] == "E":
            if cost < path_cost:
                path_cost = cost
                path_tiles = path
            elif cost == path_cost:
                path_tiles.update(path)
            continue

        next_x, next_y = (pos_x + dx, pos_y + dy)

        if grid[next_y][next_x] != "#":
            new_path = path.copy()
            new_path.add((next_x, next_y))
            dq.append(((next_x, next_y), (dx, dy), cost + 1, new_path))

        dq.append(((pos_x, pos_y), (dy, dx), cost + 1000, path.copy()))
        dq.append(((pos_x, pos_y), (-dy, -dx), cost + 1000, path))

    return path_cost, len(path_tiles)


def part01_part02():
    grid = get_input()
    (cost, path_length) = path_info(grid, pos(grid, "S"))
    print(f"[Part 1] {cost}")
    print(f"[Part 2] {path_length}")


if __name__ == '__main__':
    part01_part02()
