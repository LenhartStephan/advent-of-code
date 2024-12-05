import day00


def get_input() -> (list[tuple[int, int]], list[int]):
    text = day00.get_lines(5, split_lines=False).removesuffix("\n")
    (rules, page_updates) = text.split("\n\n")
    rules = [tuple(int(part) for part in rule.split("|")) for rule in rules.split("\n")]
    page_updates = [[int(part) for part in pages.split(",")] for pages in page_updates.split("\n")]
    return rules, page_updates


def update_correct(update: list[int], rules: list[tuple[int, int]]) -> bool:
    for (page_index, page) in enumerate(update):
        head = update[:page_index]
        for (before, after) in rules:
            if before == page and after in head:
                return False
    return True


def part01():
    counter = 0

    rules, page_updates = get_input()
    for update in page_updates:
        if update_correct(update, rules):
            counter += update[len(update) // 2]

    print(f"[Part 1] {counter}")


def insert_in_update(element: int, update: list[int], rules: list[tuple[int, int]]) -> list[int]:
    min_index = 0
    for (before, after) in rules:
        if before in update and after == element:
            min_index = max(min_index, update.index(before) + 1)

    return update[:min_index] + [element] + update[min_index:]


def part02():
    counter = 0

    rules, page_updates = get_input()
    for update in page_updates:
        if not update_correct(update, rules):
            fixed = []
            for elm in update:
                fixed = insert_in_update(elm, fixed, rules)
            counter += fixed[len(fixed) // 2]

    print(f"[Part 2] {counter}")


if __name__ == '__main__':
    part01()
    part02()
