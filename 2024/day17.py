import day00


def get_input() -> tuple[int, int, int, list[int]]:
    (a, b, c, _, p) = day00.get_lines(17)
    (a, b, c) = int((a.split(": ")[1])), int(b.split(": ")[1]), int(c.split(": ")[1])
    return a, b, c, list(map(int, p.replace("Program: ", "").split(",")))


def run_program(a: int, b: int, c: int, program: list[int]) -> list[int]:
    combo = lambda op: {0: 0, 1: 1, 2: 2, 3: 3, 4: a, 5: b, 6: c}.get(op)
    out: list[int] = []

    pointer = 0
    while pointer < len(program) - 1:
        opcode, operand = program[pointer], program[pointer + 1]
        match opcode:
            case 0:
                a = a // (2 ** combo(operand))
            case 1:
                b = b ^ operand
            case 2:
                b = combo(operand) % 8
            case 3:
                if a != 0:
                    pointer = operand
                    continue
            case 4:
                b = b ^ c
            case 5:
                out += [combo(operand) % 8]
            case 6:
                b = a // (2 ** combo(operand))
            case 7:
                c = a // (2 ** combo(operand))
        pointer += 2
    return out


def find_program(program: list[int]) -> int:
    a, i = 0, 1
    while True:
        trail = program[len(program) - i:]
        current_trail = run_program(a, 0, 0, program)
        if trail == current_trail:
            if i == len(program):
                return a
            a *= 8
            i += 1
        else:
            a += 1


def part01():
    a, b, c, p = get_input()
    print(f"[Part 1] {",".join(map(str, run_program(a, b, c, p)))}")


def part02():
    _, _, _, p = get_input()
    print(f"[Part 1] {find_program(p)}")


if __name__ == '__main__':
    part01()
    part02()
