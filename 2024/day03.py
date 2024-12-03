import day00
import re


def get_input():
    return "".join(day00.get_lines(3))


def mul(input_string):
    (first, second) = input_string.replace("mul(", "").replace(")", "").split(",")
    return int(first) * int(second)


def part01():
    counter = 0
    matches = re.findall(r"mul\(\d{1,3},\d{1,3}\)", get_input())
    for match in matches:
        counter += mul(match)
    print(f"[Part 1] {counter}")


def part02():
    counter = 0
    mul_active = True
    matches = re.findall(r"(mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\))", get_input())
    for match in matches:
        if match == "do()":
            mul_active = True
        elif match == "don't()":
            mul_active = False
        elif mul_active:
            counter += mul(match)
    print(f"[Part 2] {counter}")


if __name__ == '__main__':
    part01()
    part02()
