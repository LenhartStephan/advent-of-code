from functools import cache

import day00


def get_input() -> tuple[list[str], list[str]]:
    towels, _, *designs = day00.get_lines(19)
    return towels.split(", "), designs


@cache
def find_combinations(design: str, towels: tuple[str]) -> int | None:
    if len(design) == 0:
        return 1
    possible_towels = [towel for towel in towels if design.startswith(towel)]
    possible_combinations = 0
    for towel in possible_towels:
        combination = find_combinations(design.removeprefix(towel), towels)
        if combination is not None:
            possible_combinations += combination
    return possible_combinations


def part01():
    (towels, designs) = get_input()
    counter = 0
    for design in designs:
        if find_combinations(design, tuple(towels)) > 0:
            counter += 1
    print(f"[Part 1] {counter}")


def part02():
    (towels, designs) = get_input()
    counter = 0
    for design in designs:
        counter += find_combinations(design, tuple(towels))
    print(f"[Part 2] {counter}")


if __name__ == '__main__':
    part01()
    part02()
