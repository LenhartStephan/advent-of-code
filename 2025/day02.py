import day00


def is_invalid(line: str, pattern_twice: bool):
    for i in range(len(line) // 2):
        pattern = line[:(i + 1)]
        if pattern_twice:
            if pattern * 2 == line:
                return True
        else:
            for j in range(1, len(line) + 1):
                if pattern * j == line:
                    return True
    return False


def part01():
    lines = day00.get_lines(2, split_lines=False).split(',')
    sum_counter = 0
    for line in lines:
        start, end = line.split("-")
        for i in range(int(start), int(end) + 1):
            valid = is_invalid(str(i), True)
            if valid:
                sum_counter += i
    print(sum_counter)


def part02():
    lines = day00.get_lines(2, split_lines=False).split(',')
    sum_counter = 0
    for line in lines:
        start, end = line.split("-")
        for i in range(int(start), int(end) + 1):
            valid = is_invalid(str(i), False)
            if valid:
                sum_counter += i
    print(sum_counter)


if __name__ == '__main__':
    part01()
    part02()
