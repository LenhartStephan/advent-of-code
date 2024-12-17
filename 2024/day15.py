from copy import deepcopy

import day00


def get_input() -> tuple[list[list[str]], str]:
    grid, moves = day00.get_lines(15, split_lines=False).split("\n\n")
    return list([list(s) for s in grid.split("\n")]), moves.replace("\n", "")


def get_starting_pos(grid: list[list[str]]) -> tuple[int, int]:
    return next((x, y) for y, row in enumerate(grid) for x, char in enumerate(row) if char == "@")


def box_score(grid: list[list[str]]) -> int:
    return sum(100 * y + x for y, row in enumerate(grid) for x, char in enumerate(row) if char in ["O", "["])


def convert_grid(grid: list[list[str]]) -> list[list[str]]:
    new_grid = []
    converter = {"#": ["#", "#"], "O": ["[", "]"], ".": [".", "."], "@": ["@", "."]}
    for y, row in enumerate(grid):
        new_row = []
        for x, char in enumerate(row):
            new_row += converter[char]
        new_grid.append(new_row)
    return new_grid


def make_move(grid: list[list[str]], position: tuple[int, int], move: str) -> tuple[list[list[str]], tuple[int, int]]:
    move_list = {">": (1, 0), "<": (-1, 0), "^": (0, -1), "v": (0, 1)}
    (px, py), (dx, dy) = position, move_list[move]
    element1, next_element1 = grid[py][px], grid[py + dy][px + dx]
    element2, next_element2, other_box_x = None, None, 0

    if (move == "^" or move == "v") and (element1 == "[" or element1 == "]"):
        other_box_x = 1 if element1 == "[" else -1
        element2, next_element2 = grid[py][px + other_box_x], grid[py + dy][px + dx + other_box_x]
    if element1 == "." or next_element1 == "#" or next_element2 == "#":
        return grid, position
    if next_element1 != "." or (next_element2 is not None and next_element2 != "."):

        if next_element2 is None or (next_element1 == element1 and next_element2 == element2):
            grid, _ = make_move(grid, (px + dx, py + dy), move)
            next_element1, next_element2 = grid[py + dy][px + dx], grid[py + dy][
                px + dx + other_box_x] if next_element2 is not None else None
        else:
            rollback = deepcopy(grid)
            grid, _ = make_move(grid, (px + dx, py + dy), move)
            grid, _ = make_move(grid, (px + dx + other_box_x, py + dy), move)
            next_element1, next_element2 = grid[py + dy][px + dx], grid[py + dy][px + dx + other_box_x]
            if next_element1 != "." or next_element2 != ".":
                grid = rollback

    if next_element1 == "." and (next_element2 is None or next_element2 == "."):
        grid[py + dy][px + dx] = element1
        grid[py][px] = "."
        if next_element2 is not None:
            grid[py + dy][px + dx + other_box_x] = element2
            grid[py][px + other_box_x] = "."
        px, py = px + dx, py + dy

    return grid, (px, py)


def part01():
    grid, moves = get_input()
    pos = get_starting_pos(grid)
    for move in moves:
        grid, pos = make_move(grid, pos, move)

    print(f"[Part 1] {box_score(grid)}")


def part02():
    grid, moves = get_input()
    grid = convert_grid(grid)
    pos = get_starting_pos(grid)

    for (step, move) in enumerate(moves):
        grid, pos = make_move(grid, pos, move)

    print(f"[Part 2] {box_score(grid)}")


if __name__ == '__main__':
    part01()
    part02()
