import day00


def largest_digit(number: str) -> tuple[int, int]:
    index, maximum = -1, 0
    for i, digit in enumerate(number):
        if int(digit) > maximum:
            index = i
            maximum = int(digit)
    return index, maximum


def get_joltage(line: str, num_digits: int = 2) -> int:
    digits: list[str] = []
    previous_index = -1
    for i in range(1, num_digits + 1):
        digits_remaining = (num_digits - i)
        search_line = line[(previous_index + 1):None if digits_remaining == 0 else -digits_remaining]
        substring_index, digit = largest_digit(search_line)
        previous_index = previous_index + 1 + substring_index
        digits.append(str(digit))
    return int("".join(digits))


def part01():
    lines = day00.get_lines(3)
    joltage = 0
    for line in lines:
        joltage += get_joltage(line)
    print(joltage)


def part02():
    lines = day00.get_lines(3)
    joltage = 0
    for line in lines:
        joltage += get_joltage(line, num_digits=12)
    print(joltage)


if __name__ == '__main__':
    part01()
    part02()
