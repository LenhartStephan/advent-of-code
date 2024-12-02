fun main() {
    val day = Day01()
    day.part1()
    day.part2()
}

class Day01 : Day(1){
    fun part1() {
        val inputLines  = inputLines.map { it.toInt() }

        for (num1 in inputLines) {
            for (num2 in inputLines) {
                if (num1 + num2 == 2020) {
                    println("[Part 1] $num1 * $num2 = ${num1 * num2}")
                    return
                }
            }
        }
    }

    fun part2() {
        val inputLines  = inputLines.map { it.toInt() }
        for (num1 in inputLines) {
            for (num2 in inputLines) {
                for (num3 in inputLines) {
                    if (num1 + num2 == 2020) {
                        println("[Part 2] $num1 * $num2 * $num3 = ${num1 * num2 * num3}")
                        return
                    }
                }
            }
        }
    }
}

