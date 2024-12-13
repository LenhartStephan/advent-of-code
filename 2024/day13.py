import day00


def get_input() -> list[tuple[tuple[int, int], tuple[int, int], tuple[int, int]]]:
    def parse_line(line: str, separator="+"):
        _, s1, s2 = line.split(separator)
        return int(s1.replace(", Y", "")), int(s2)

    inp = day00.get_lines(13, split_lines=False).removesuffix("\n").split("\n\n")
    return [(parse_line(l1), parse_line(l2), parse_line(l3, separator="=")) for l1, l2, l3 in
            [section.split("\n") for section in inp]]


def solve(problem: tuple[tuple[int, int], tuple[int, int], tuple[int, int]], max_solution=None) -> tuple[int, int]:
    (ax, ay), (bx, by), (px, py) = problem
    b = (px * ay - py * ax) // (ay * bx - by * ax)
    a = (px * by - py * bx) // (by * ax - bx * ay)

    if (ax * a + bx * b == px and ay * a + by * b == py) and (
            max_solution is None or (a <= max_solution and b <= max_solution)):
        return a, b
    return 0, 0


def part01():
    tokens = 0

    for problem in get_input():
        a, b = solve(problem, 100)
        tokens += 3 * a + b

    print(f"[Part 1] {tokens}")


def part02():
    tokens = 0

    for button_a, button_b, (px, py) in get_input():
        a, b = solve((button_a, button_b, (px + 10000000000000, py + 10000000000000)))
        tokens += 3 * a + b

    print(f"[Part 2] {tokens}")


if __name__ == '__main__':
    part01()
    part02()
