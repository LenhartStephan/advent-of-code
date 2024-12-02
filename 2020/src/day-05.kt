import kotlin.math.max
import kotlin.math.pow

fun main() {
    val day = Day05()
    day.part1()
    day.part2()
}

class Day05 : Day(5) {

    private fun binarySearch(directions: CharArray): Int {
        var range = 0..<2.0.pow(directions.size).toInt()
        for(c in directions.indices){
            val half = range.count()/2
            range = when (directions[c]){
                'F', 'L' -> range.first..range.last-half
                else -> range.first+half..range.last
            }
        }
        return range.first
    }

    private fun seatId(boardingPass: String): Int{
        val rowDirections = boardingPass.substring(0..6).toCharArray()
        val colDirections = boardingPass.substring(7).toCharArray()

        val row = binarySearch(rowDirections)
        val col = binarySearch(colDirections)

        return row * 8 + col
    }

    fun part1() {
        var maxSeatId = 0
        for (pass in inputLines){
            maxSeatId = max(seatId(pass), maxSeatId)
        }
        println("[Part 1] $maxSeatId")
    }

    fun part2() {
        val mySeat = inputLines.map { seatId(it) }.sorted().reduce { a, b -> if (b == a + 1) b else a }
        println("[Part 2] ${mySeat + 1}")
    }
}

