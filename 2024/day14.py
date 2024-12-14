import day00
import matplotlib.pyplot as plt

grid_width, grid_height = 101, 103


def get_input() -> list[tuple[tuple[int, int], tuple[int, int]]]:
    def parse_line(line: str):
        (p, v) = line.split(" ")
        px, py = map(int, p.replace("p=", "").split(","))
        vx, vy = map(int, v.replace("v=", "").split(","))
        return (px, py), (vx, vy)

    return [parse_line(line) for line in day00.get_lines(14)]


def safety_factor(bots: list[tuple[tuple[int, int], tuple[int, int]]]) -> int:
    tl, tr, bl, br = 0, 0, 0, 0
    for (px, py), _ in bots:
        if px < grid_width // 2:
            if py < grid_height // 2:
                tl += 1
            elif py > grid_height // 2:
                bl += 1
        elif px > grid_width // 2:
            if py < grid_height // 2:
                tr += 1
            elif py > grid_height // 2:
                br += 1
    return tl * tr * bl * br


def part01():
    bots = get_input()
    for _ in range(100):
        for i, ((px, py), (vx, vy)) in enumerate(bots):
            bots[i] = (((px + vx) % grid_width, (py + vy) % grid_height), (vx, vy))

    print(f"[Part 1] {safety_factor(bots)}")


def part02():
    bots = get_input()
    min_safety, min_safety_second, bot_vis = safety_factor(bots), 0, bots.copy()
    for second in range(1, 10000):
        for i, ((px, py), (vx, vy)) in enumerate(bots):
            bots[i] = (((px + vx) % grid_width, (py + vy) % grid_height), (vx, vy))
        safety = safety_factor(bots)
        if safety < min_safety:
            min_safety, min_safety_second, bot_vis = safety, second, bots.copy()

    # Visualization
    x_coords, y_coords = [px for ((px, _), _) in bot_vis], [py for ((_, py), _) in bot_vis]
    plot = plt.subplot()
    plot.plot(x_coords, y_coords, marker="o", linestyle='none')
    plot.invert_yaxis()
    plt.show()

    print(f"[Part 2] {min_safety_second}")


if __name__ == '__main__':
    part01()
    part02()
