fun main() {
    val day = Day03()
    day.part1()
    day.part2()
}

class Day03 : Day(3) {
    // map[y][x]
    private val map = inputLines.map { it.toCharArray() }

    private fun traverseMap(right: Int, down: Int = 1): Int {
        var trees = 0
        var x = 0
        for (y in map.indices step down) {
            if (map[y][x] == '#') trees++
            x = (x + right) % map[y].size
        }
        return trees
    }

    fun part1() {
        println("[Part 1] ${traverseMap(3)}")
    }

    fun part2() {
        var trees: Long = traverseMap(1).toLong()
        trees *= traverseMap(3).toLong()
        trees *= traverseMap(5).toLong()
        trees *= traverseMap(7).toLong()
        trees *= traverseMap(1, 2).toLong()
        println("[Part 2] $trees")
    }
}
