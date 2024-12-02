import day00

def get_input():
    file = day00.get_lines(1)
    numbers1 = []
    numbers2 = []
    for line in file:
        num1, num2 = map(int, line.split())
        numbers1.append(num1)
        numbers2.append(num2)

    return numbers1, numbers2

def part01():
    list1, list2 = get_input()
    list1.sort()
    list2.sort()

    distances = 0
    while len(list1) > 0 and len(list2) > 0:
        left, right = (list1.pop(), list2.pop())
        distances += abs(left - right)
    print(f"[Part 1] {distances}")

def part02():
    list1, list2 = get_input()

    similarity = 0
    for value in list1:
        count = list2.count(value)
        similarity += value * count
    print(f"[Part 2] {similarity}")

if __name__ == '__main__':
    part01()
    part02()
