import day00

def get_input():
    lines = day00.get_lines(2)
    int_list = []
    for string in lines:
        int_list.append([int(num) for num in string.split()])
    return int_list

def is_safe(nums):
    is_increasing = True
    is_decreasing = True
    differences_valid = True
    for i in range(1, len(nums)):
        if nums[i - 1] < nums[i]:
            is_decreasing = False
        elif nums[i - 1] > nums[i]:
            is_increasing = False
        if not 1 <= abs(nums[i - 1] - nums[i]) <= 3:
            differences_valid = False
    return (is_increasing or is_decreasing) and differences_valid

def part01():
    safe = 0
    for nums in get_input():
        if is_safe(nums):
            safe += 1
    print(f"[Part 1] {safe}")

def part02():
    safe = 0
    for nums in get_input():
        for i in range(len(nums)):
            if is_safe(nums[:i] + nums[i + 1:]):
                safe += 1
                break
    print(f"[Part 2] {safe}")

if __name__ == '__main__':
    part01()
    part02()
