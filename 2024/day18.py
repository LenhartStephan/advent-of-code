import day00
from heapq import heappop, heappush


def get_input() -> list[tuple[int, int]]:
    return [(int(a), int(b)) for a, b in [line.split(",") for line in day00.get_lines(18)]]


def manhattan_distance(a: tuple[int, int], b: tuple[int, int]) -> int:
    return abs(a[0] - b[0]) + abs(a[1] - b[1])


def path_length(blocked: list[tuple[int, int]], start: tuple[int, int], goal: tuple[int, int],
                grid_size: int = 71) -> int | None:
    open_set = []
    closed_set = set(blocked)
    heappush(open_set, (manhattan_distance(start, goal), 0, start))

    while open_set:
        (_, cost, (px, py)) = heappop(open_set)
        closed_set.add((px, py))

        if (px, py) == goal:
            return cost

        for (dx, dy) in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
            (nx, ny) = px + dx, py + dy

            if (nx, ny) in closed_set or not (0 <= nx < grid_size and 0 <= ny < grid_size):
                continue

            next_cost = cost + 1
            next_node = (manhattan_distance((nx, ny), goal) + next_cost, next_cost, (nx, ny))
            node_in_open_set = next(((h, c, p) for (h, c, p) in open_set if p == (nx, ny)), None)

            if node_in_open_set is None:
                heappush(open_set, next_node)
            elif next_cost < node_in_open_set[1]:
                open_set.remove(node_in_open_set[0])
                heappush(open_set, next_node)
    return None


def search_blocked(byte_list: list[tuple[int, int]], start: tuple[int, int], goal: tuple[int, int]):
    lower_bound = 0
    upper_bound = len(byte_list) - 1
    current = -1
    while lower_bound <= upper_bound:
        current = (lower_bound + upper_bound) // 2
        if path_length(byte_list[:current], start, goal) is not None:
            lower_bound = current + 1
        else:
            upper_bound = current - 1
    return current


def part01():
    byte_list = get_input()
    print(f"[Part 1] {path_length(byte_list[:1024], (0, 0), (70, 70))}")


def part02():
    byte_list = get_input()
    search_result = search_blocked(byte_list, (0, 0), (70, 70))
    print(f"[Part 2] {byte_list[search_result]}")


if __name__ == '__main__':
    part01()
    part02()
