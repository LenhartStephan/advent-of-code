fun main() {
    val day = Day10()
    day.part1()
    day.part2()
}

class Day10 : Day(10) {

    private val inputNumbers = inputLines.map { it.toInt() }

    fun part1() {
        var ones = 0
        var threes = 1

        val inputNumbers = inputNumbers.sorted()
        for (i in inputNumbers.indices) {
            val last = if (i == 0) 0 else inputNumbers[i - 1]
            val current = inputNumbers[i]
            when (val diff = current - last) {
                1 -> ones++
                3 -> threes++
                else -> println("ERROR: $diff")
            }
        }

        println("[Part 1] ${ones * threes}")
    }

    fun part2() {

        println("[Part 2] ")
    }
}
