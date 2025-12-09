import re

import day00


def part01():
    lines = [re.split(r'\s+', line.strip()) for line in day00.get_lines(6)]
    grand_total = 0
    for i in range(len(lines[0])):
        result, is_mult = None, False
        for line in reversed(lines):
            if line[i] == "*" or line[i] == "+":
                is_mult = (line[i] == "*")
                continue
            if result is None:
                result = int(line[i])
            else:
                result = result * int(line[i]) if is_mult else result + int(line[i])
        grand_total += result
    print(grand_total)


def part02():
    *lines, last = day00.get_lines(6)
    grand_total, local_result, is_mult = 0, None, False
    for col_index in range(len(lines[0])):
        if last[col_index] == "*" or last[col_index] == "+":
            is_mult = (last[col_index] == "*")
        num_str = ""
        for line in lines:
            num_str += line[col_index]
        if num_str.strip().isdigit():
            if local_result is None:
                local_result = int(num_str.strip())
            else:
                local_result = local_result * int(num_str.strip()) if is_mult else local_result + int(num_str.strip())
        else:
            grand_total += local_result
            local_result = None
    grand_total += local_result
    print(grand_total)


if __name__ == '__main__':
    part01()
    part02()
