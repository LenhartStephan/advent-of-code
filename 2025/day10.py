import day00
import gurobipy as gp
from gurobipy import GRB


def part01():
    light_list = [l.split(" ")[0][1:-1] for l in day00.get_lines(10)]
    button_list = [[list(map(int, b[1:-1].split(","))) for b in l.split(" ")[1:-1]] for l in day00.get_lines(10)]

    counter = 0
    for i, light in enumerate(light_list):
        button = button_list[i]
        matrix = [[0] * len(button) for _ in range(len(light))]
        for j in range(len(button)):
            for idx in button[j]:
                matrix[idx][j] = 1

        m = gp.Model()
        m.setParam(gp.GRB.Param.OutputFlag, 0)
        x = m.addVars(len(button), vtype=GRB.BINARY, name="button")
        h = m.addVars(len(light), vtype=GRB.INTEGER, lb=0, name="mod_helper")
        m.addConstrs(
            gp.quicksum(matrix[j][k] * x[k] for k in range(len(button))) - 2 * h[j] == (light[j] == "#")
            for j in range(len(light))
        )
        m.setObjective(x.sum(), GRB.MINIMIZE)
        m.optimize()
        counter += int(m.objVal)

    print(counter)


def part02():
    joltage_list = [list(map(int, l.split(" ")[-1][1:-1].split(","))) for l in day00.get_lines(10)]
    button_list = [[list(map(int, b[1:-1].split(","))) for b in l.split(" ")[1:-1]] for l in day00.get_lines(10)]

    counter = 0
    for i, joltages in enumerate(joltage_list):
        buttons = button_list[i]
        matrix = [[0] * len(buttons) for _ in range(len(joltages))]
        for j in range(len(buttons)):
            for idx in buttons[j]:
                matrix[idx][j] = 1
        m = gp.Model()
        m.setParam(gp.GRB.Param.OutputFlag, 0)
        x = m.addVars(len(buttons), vtype=GRB.INTEGER, name="button")
        m.addConstrs(
            gp.quicksum(matrix[j][k] * x[k] for k in range(len(buttons))) == joltage
            for j, joltage in enumerate(joltages)
        )
        m.setObjective(x.sum(), GRB.MINIMIZE)
        m.optimize()
        counter += int(m.objVal)
    print(counter)


if __name__ == "__main__":
    part01()
    part02()
