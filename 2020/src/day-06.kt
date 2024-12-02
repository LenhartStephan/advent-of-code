fun main() {
    val day = Day06()
    day.part1()
    day.part2()
}

class Day06 : Day(6) {

    private val groups = inputText.trim()
        .split("\n\n")
        .map { group -> group.split("\n").map { a -> a.toCharArray().toSet() } }

    fun part1() {
        val sum = groups.fold(0) { sum, group ->
            sum + group.reduce { a, b -> a + b }.count()
        }
        println("[Part 1] $sum")
    }

    fun part2() {
        val sum = groups.fold(0) { sum, group ->
            sum + group.reduce { a, b -> a.intersect(b) }.count()
        }
        println("[Part 2] $sum")
    }
}
