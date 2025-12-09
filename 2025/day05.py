import day00


def get_data():
    ranges, ingredients = day00.get_lines(5, split_lines=False).split("\n\n")
    ingredients = [int(i) for i in ingredients.split("\n") if i != ""]
    ranges = [tuple(r.split("-")) for r in ranges.split("\n")]
    ranges = [range(int(str1), int(str2) + 1) for str1, str2 in ranges]
    return ranges, ingredients


def part01():
    ranges, ingredients = get_data()
    counter = 0
    for ing in ingredients:
        for r in ranges:
            if ing in r:
                counter += 1
                break
    print(counter)


def part02():
    ranges, _ = get_data()
    for i, r1 in enumerate(ranges):
        for j, r2 in enumerate(ranges):
            if i != j and (r2.start in r1 or r2.stop in r1):
                ranges[i] = range(min(r1.start, r2.start), max(r1.stop, r2.stop))
                r1 = ranges[i]
                ranges[j] = range(0, 0)
    print(sum([len(r) for r in ranges]))


if __name__ == '__main__':
    part01()
    part02()
