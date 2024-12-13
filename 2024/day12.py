import day00


def get_input() -> list[str]:
    return day00.get_lines(12)


def flood_fill(start: tuple[int, int], grid: list[str]) -> tuple[set[tuple[int, int]], int]:
    to_visit = [start]
    area, perimeter = set(), 0
    plant_id = grid[start[1]][start[0]]
    while len(to_visit) > 0:
        (px, py) = to_visit.pop()
        if (px, py) not in area:
            area.add((px, py))
            pot_perimeter = 4
            for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                x, y = px + dx, py + dy
                if 0 <= x < len(grid[0]) and 0 <= y < len(grid) and grid[y][x] == plant_id:
                    pot_perimeter -= 1
                    to_visit.append((x, y))
            perimeter += pot_perimeter

    return area, perimeter


def sides(area: set[tuple[int, int]]) -> int:
    outer_corners = 0
    inner_corners = 0
    for px, py in area:
        for dx, dy in [(-1, -1), (1, -1), (1, 1), (-1, 1)]:
            if (px + dx, py + dy) in area:
                if (px, py + dy) not in area:
                    inner_corners += 1
                if (px + dx, py) not in area:
                    inner_corners += 1
            else:
                if (px + dx, py) not in area and (px, py + dy) not in area:
                    outer_corners += 1
    return outer_corners + inner_corners // 2


def part01_part02():
    perimeter_price = 0
    side_price = 0
    grid = get_input()

    visited = []
    for x in range(len(grid)):
        for y in range(len(grid[x])):
            if (x, y) not in visited:
                area, perimeter = flood_fill((x, y), grid)
                visited += area
                perimeter_price += len(area) * perimeter
                side_price += len(area) * sides(area)
    print(f"[Part 1] {perimeter_price}")
    print(f"[Part 2] {side_price}")


if __name__ == '__main__':
    part01_part02()
