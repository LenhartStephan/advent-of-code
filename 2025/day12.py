import day00


def part01():
    *shapes, grids = day00.get_lines(12, split_lines=False).split("\n\n")
    grids = [(tuple(map(int, g.split(": ")[0].split("x"))), list(map(int, g.split(": ")[1].split(" "))))
             for g in grids.splitlines()]

    counter = 0
    for (s1, s2), quantities in grids:
        if s1 * s2 >= sum(quantities) * 9:
            counter += 1
    print(counter)


if __name__ == "__main__":
    part01()
