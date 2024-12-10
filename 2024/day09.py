import day00


def get_input() -> list[int]:
    return list(map(int, day00.get_lines(9)[0]))


def disk_from_mapping(mapping: list[int]) -> list[int | str]:
    disk = []
    for (i, mapping) in enumerate(mapping):
        is_free_space = i % 2 != 0
        disk += [int(i / 2) if not is_free_space else "." for _ in range(mapping)]
    return disk


def last_non_empty(array: list[int | str]) -> int | None:
    for _ in range(len(array)):
        elm = array.pop()
        if elm != '.':
            return elm
    return None


def filesystem_checksum(disk: list[int | str]) -> int:
    return sum([i * item for (i, item) in enumerate(disk) if type(item) == int])


def part01():
    disk = disk_from_mapping(get_input())

    for (i, current) in enumerate(disk):
        if current == ".":
            disk[i] = last_non_empty(disk)

    print(f"[Part 1] {filesystem_checksum(disk)}")


def find_free_space(disk: list[int | str], min_size: int, search_range: range) -> int | None:
    size = None
    for i in search_range:
        item = disk[i]
        if item == ".":
            size = 1 if size is None else size + 1
            if size >= min_size:
                return i - (size - 1)
        else:
            size = None
    return None


def part02():
    disk = disk_from_mapping(get_input())
    (current_item, start_index) = (None, None)

    cache = {}
    for (rev_i, item) in enumerate(reversed(disk)):
        i = len(disk) - rev_i
        if type(item) == str or item != current_item:
            if start_index is not None:
                block = disk[i:start_index]
                cached_search_start = cache[len(block)] if len(block) in cache else 0
                free_space_index = find_free_space(disk, len(block), range(cached_search_start, i))
                cache[len(block)] = free_space_index if free_space_index is not None else i

                if free_space_index is not None:
                    disk[free_space_index:free_space_index + len(block)] = block
                    disk[i:start_index] = len(block) * "."

            (current_item, start_index) = (None, None) if (type(item) == str) else (item, i)

    print(f"[Part 2] {filesystem_checksum(disk)}")


if __name__ == '__main__':
    part01()
    part02()
