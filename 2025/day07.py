import day00


def part01():
    first, *lines = day00.get_lines(7)
    beams, split_counter = {first.index("S")}, 0
    for line in lines:
        for beam in beams.copy():
            if line[beam] == "^":
                split_counter += 1
                beams.remove(beam)
                beams.add(beam - 1)
                beams.add(beam + 1)
    print(split_counter)


def part02():
    cache_map = {}

    def split(lines, position: tuple[int, int]) -> int:
        x, y = position
        if y == len(lines): return 0
        if position in cache_map:
            return cache_map.get(position)
        else:
            if lines[y][x] == "^":
                timeline = 1 + split(lines, (x - 1, y + 1)) + split(lines, (x + 1, y + 1))
            else:
                timeline = split(lines, (x, y + 1))
            cache_map[position] = timeline
            return timeline

    first, *l = day00.get_lines(7)
    print(split(l, (first.index("S"), 1)) + 1)


if __name__ == '__main__':
    part01()
    part02()
