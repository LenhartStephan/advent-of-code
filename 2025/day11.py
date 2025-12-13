import day00


def paths(start, destination, device_list):
    memo = {}

    def paths_r(a):
        if a == destination:
            return 1
        results = 0
        for d in device_list.get(a, []):
            memo_value = memo.get(d, None)
            if memo_value is None:
                memo[d] = paths_r(d)
            results += memo[d]
        return results

    return paths_r(start)


def part01():
    device_list = {l[0:3]: l[5:].split(" ") for l in day00.get_lines(11)}
    print(paths("you", "out", device_list))


def part02():
    d = {l[0:3]: l[5:].split(" ") for l in day00.get_lines(11)}
    fft_dac = paths("svr", "fft", d) * paths("fft", "dac", d) * paths("dac", "out", d)
    dac_fft = paths("svr", "dac", d) * paths("dac", "fft", d) * paths("fft", "out", d)
    print(fft_dac + dac_fft)


if __name__ == "__main__":
    part01()
    part02()
