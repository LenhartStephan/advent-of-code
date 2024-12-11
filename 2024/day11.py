from collections import defaultdict

import day00


def get_input() -> list[int]:
    return list(map(int, day00.get_lines(11)[0].split(" ")))


def stones_after_blinks(stones: list[int], blinks: int = 25):
    d = defaultdict(int)
    for stone in stones:
        d[stone] += 1

    for _ in range(blinks):
        for (stone, num) in dict(d).items():
            d[stone] -= num
            if stone == 0:
                d[1] += num
            elif len(str(stone)) % 2 == 0:
                num_digits = len(str(stone))
                first = int(str(stone)[:num_digits // 2])
                last = int(str(stone)[num_digits // 2:])
                d[first] += num
                d[last] += num
            else:
                d[stone * 2024] += num

    return sum(d.values())


def part01():
    print(f"[Part 1] {stones_after_blinks(get_input())}")


def part02():
    print(f"[Part 2] {stones_after_blinks(get_input(), blinks=75)}")


if __name__ == '__main__':
    part01()
    part02()
