import java.io.File

abstract class Day(dayNumber: Int) {
    val inputLines: List<String> = File("day-${dayNumber.toString().padStart(2, '0')}.input").readLines()
    val inputText: String = File("day-${dayNumber.toString().padStart(2, '0')}.input").readText()
}