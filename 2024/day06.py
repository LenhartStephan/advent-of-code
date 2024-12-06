import multiprocessing

import day00


def get_input() -> list[str]:
    return day00.get_lines(6)


def get_start(grid: list[str]) -> tuple[int, int]:
    return [(ix, iy) for iy, row in enumerate(grid) for ix, elm in enumerate(row) if elm == "^"][0]


def turn_right(direction: tuple[int, int]) -> tuple[int, int]:
    if direction == (0, -1):
        return 1, 0
    elif direction == (1, 0):
        return 0, 1
    elif direction == (0, 1):
        return -1, 0
    else:
        return 0, -1


def simulate(grid: list[str], start: tuple[int, int]) -> tuple[set[tuple[int, int]], bool]:
    (px, py) = start
    (dx, dy) = (0, -1)
    visited = {((px, py), (dx, dy))}
    (grid_width, grid_height) = (len(grid[0]), len(grid))

    while 0 <= px + dx < grid_width and 0 <= py + dy < grid_height:
        next_elm = grid[py + dy][px + dx]
        if next_elm in ["#", "O"]:
            (dx, dy) = turn_right((dx, dy))
        else:
            (px, py) = (px + dx, py + dy)
        if ((px, py), (dx, dy)) in visited:
            return {position for (position, _) in visited}, True
        visited.add(((px, py), (dx, dy)))

    return {position for (position, _) in visited}, False


def part01():
    grid = get_input()
    start = get_start(grid)
    (visited, _) = simulate(grid, start)
    print(f"[Part 1] {len(visited)}")


def loop_for_obstruction(grid: list[str], start: tuple[int, int], obstruction: tuple[int, int]):
    (px, py) = obstruction
    temp_grid = grid.copy()
    temp_grid[py] = temp_grid[py][:px] + "O" + temp_grid[py][px + 1:]
    (_, is_loop) = simulate(temp_grid, start)
    return 1 if is_loop else 0


def part02():
    grid = get_input()
    start = get_start(grid)
    (visited, _) = simulate(grid, start)

    with multiprocessing.Pool() as pool:
        args = [(grid, start, pos) for pos in visited]
        loops = sum(pool.starmap(loop_for_obstruction, args))

    print(f"[Part 2] {loops}")


if __name__ == '__main__':
    part01()
    part02()
