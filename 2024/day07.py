import multiprocessing

import day00


def get_input() -> list[tuple[int, list[int]]]:
    return [
        (int(p1), list(map(int, p2.split(" ")))) for (p1, p2) in (line.split(": ") for line in day00.get_lines(7))
    ]


def concat(i1: int, i2: int) -> int:
    return int(str(i1) + str(i2))


def search_assignment(target: int, num: list[int], use_concat: bool, value: int = None) -> int:
    if len(num) == 0:
        return target if value == target else 0

    v = num.pop(0)
    if value is None:
        return search_assignment(target, num, use_concat, v)

    if value > target:
        return 0

    return max(
        search_assignment(target, num.copy(), use_concat, value + v),
        search_assignment(target, num.copy(), use_concat, value * v),
        search_assignment(target, num.copy(), use_concat, concat(value, v)) if use_concat else 0,
    )


def part01():
    counter = 0
    lines = get_input()

    for (val, numbers) in lines:
        counter += search_assignment(val, numbers, False)

    print(f"[Part 1] {counter}")


def part02():
    lines = get_input()

    with multiprocessing.Pool() as pool:
        args = [(val, numbers, True) for (val, numbers) in lines]
        values = pool.starmap(search_assignment, args)

    print(f"[Part 2] {sum(values)}")


if __name__ == '__main__':
    part01()
    part02()
