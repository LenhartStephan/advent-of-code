import day00


def part01():
    lines = day00.get_lines(1)
    dial_pos, counter = 50, 0

    for line in lines:
        direction, rotation = line[0], int(line[1:])
        if direction == "R":
            dial_pos = (dial_pos + rotation) % 100
        else:
            dial_pos = (dial_pos - rotation) % 100
        if dial_pos == 0:
            counter += 1
    print(counter)


def part02():
    lines = day00.get_lines(1)
    dial_pos, counter = 50, 0

    for line in lines:
        direction, rotation = line[0], int(line[1:])
        while rotation > 0:
            dial_pos = (dial_pos + (1 if direction == "R" else -1)) % 100
            rotation -= 1
            if dial_pos == 0:
                counter += 1
    print(counter)


if __name__ == '__main__':
    part01()
    part02()
