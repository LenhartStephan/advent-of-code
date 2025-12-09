import math

import networkx as nx

import day00


def part01and02():
    lines = [tuple(map(int, line.split(","))) for line in day00.get_lines(8)]
    distances = {(b1, b2): math.dist(b1, b2) for b1 in lines for b2 in lines if b1 != b2}
    sorted_distances = sorted(distances.items(), key=lambda item: item[1])
    g = nx.Graph()
    g.add_nodes_from(lines)
    last, c = None, 0
    while not nx.is_connected(g):
        if c == 1000:
            m = [len(c) for c in sorted(nx.connected_components(g), key=len, reverse=True)]
            print(m[0] * m[1] * m[2])
        c += 1
        g.add_edges_from([sorted_distances.pop(0)[0]])
        last = sorted_distances.pop(0)
    print(last[0][0][0] * last[0][1][0])


if __name__ == '__main__':
    part01and02()
