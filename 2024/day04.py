import day00


def get_input():
    return day00.get_lines(4)


def part01():
    counter = 0
    grid = get_input()
    directions = [(-1, 0), (1, 0), (0, -1), (0, 1), (1, 1), (1, -1), (-1, -1), (-1, 1)]
    col_size = len(grid)
    row_size = len(grid[0])

    for xi in range(row_size):
        for yi in range(col_size):
            for (dx, dy) in directions:
                if 0 <= yi + 3 * dy < col_size and 0 <= xi + 3 * dx < row_size:
                    if (grid[xi][yi] == "X" and
                            grid[xi + 1 * dx][yi + 1 * dy] == "M" and
                            grid[xi + 2 * dx][yi + 2 * dy] == "A" and
                            grid[xi + 3 * dx][yi + 3 * dy] == "S"):
                        counter += 1
    print(f"[Part 1] {counter}")


def part02():
    counter = 0
    grid = get_input()
    col_size = len(grid)
    row_size = len(grid[0])

    for xi in range(1, row_size - 1):
        for yi in range(1, col_size - 1):
            lt = grid[xi - 1][yi - 1]
            rt = grid[xi + 1][yi - 1]
            lb = grid[xi - 1][yi + 1]
            rb = grid[xi + 1][yi + 1]

            if (grid[xi][yi] == "A" and
                    [lt, rt, lb, rb].count("M") == 2 and
                    [lt, rt, lb, rb].count("S") == 2 and
                    lt != rb):
                counter += 1
    print(f"[Part 2] {counter}")


if __name__ == '__main__':
    part01()
    part02()
