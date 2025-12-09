import day00


def is_accessible(grid, x, y):
    surrounding = 0
    for dx, dy in [(1, 0), (0, 1), (1, 1), (-1, 0), (0, -1), (-1, -1), (1, -1), (-1, 1)]:
        nx, ny = x + dx, y + dy
        if nx < 0 or nx >= len(grid[0]) or ny < 0 or ny >= len(grid):
            continue
        if grid[nx][ny] != ".":
            surrounding += 1
    return True if surrounding < 4 else False


def part01():
    grid = day00.get_lines(4)
    accessible = 0
    for x, line in enumerate(grid):
        for y, pos in enumerate(line):
            if pos == ".":
                continue
            if is_accessible(grid, x, y):
                accessible += 1
    print(accessible)


def part02():
    grid = [list(line) for line in day00.get_lines(4)]
    removed = 0
    changed = True
    while changed:
        changed = False
        for x, line in enumerate(grid):
            for y, pos in enumerate(line):
                if pos == ".":
                    continue
                if is_accessible(grid, x, y):
                    grid[x][y] = "."
                    removed += 1
                    changed = True
    print(removed)


if __name__ == "__main__":
    part01()
    part02()
