import day00


def manhattan_area(a, b):
    return (abs(a[0] - b[0]) + 1) * (abs(a[1] - b[1]) + 1)


def in_polygon(point, polygon):
    x, y = point
    intersections = 0
    p2 = polygon[-1]
    for p1 in polygon:
        x1, y1 = p1
        x2, y2 = p2
        p2 = p1

        if (y == y1) and (y == y2) and (min(x1, x2) <= x <= max(x1, x2)):
            return True

        if (y1 <= y < y2) or (y2 <= y < y1):
            x_intersection = (x2 - x1) * (y - y1) / (y2 - y1) + x1
            if x_intersection > x:
                intersections += 1
    return intersections % 2 == 1


def part01():
    lines = [tuple(map(int, line.split(","))) for line in day00.get_lines(9)]
    maximum = 0
    for a in lines:
        for b in lines:
            if a == b:
                continue
            area = manhattan_area(a, b)
            if area > maximum:
                maximum = area
    print(maximum)


def part02():
    points = [tuple(map(int, line.split(","))) for line in day00.get_lines(9)]
    lines = []
    areas = []
    last_point = points[-1]
    for a in points:
        lines.append((last_point, a))
        last_point = a
        for b in points:
            if not a == b:
                areas.append((a, b, manhattan_area(a, b)))
    areas = sorted(areas, key=lambda x: x[2], reverse=True)

    x_compress = {p[0]: i for i, p in enumerate(sorted(points, key=lambda x: x[0]))}
    y_compress = {p[1]: i for i, p in enumerate(sorted(points, key=lambda x: x[1]))}
    c_points = []
    for px, py in points:
        c_points.append((x_compress[px], y_compress[py]))

    for p1, p2, area in areas:
        x1, y1 = x_compress[p1[0]], y_compress[p1[1]]
        x2, y2 = x_compress[p2[0]], y_compress[p2[1]]
        min_x, max_x = min(x1, x2), max(x1, x2)
        min_y, max_y = min(y1, y2), max(y1, y2)
        a, b, c, d = (min_x, min_y), (max_x, min_y), (min_x, max_y), (max_x, max_y)

        if not in_polygon(a, c_points) or not in_polygon(b, c_points) \
                or not in_polygon(c, c_points) or not in_polygon(d, c_points):
            continue

        failed = False
        for x in range(min_x, max_x + 1):
            point1 = (x, min_y)
            point2 = (x, max_y)
            if not in_polygon(point1, c_points) or not in_polygon(point2, c_points):
                failed = True
                break
        if failed:
            continue
        for y in range(min_y, max_y + 1):
            point1 = (min_x, y)
            point2 = (max_x, y)
            if not in_polygon(point1, c_points) or not in_polygon(point2, c_points):
                failed = True
                break
        if not failed:
            print(area)
            break


if __name__ == "__main__":
    part01()
    part02()
