fun main() {
    val day = Day02()
    day.part1()
    day.part2()
}

class Day02 : Day(2) {
    fun part1() {
        var validPasswords = 0
        for (line in inputLines) {
            val parts = line.split(": ", " ", "-")
            val min = parts[0].toInt()
            val max = parts[1].toInt()
            val char = parts[2].first()
            val password = parts[3]
            val numChars = password.count { it == char }
            if (numChars in min..max) {
                validPasswords++
            }
        }

        println("[Part 1] $validPasswords")
    }

    fun part2() {
        var validPasswords = 0
        for (line in inputLines) {
            val parts = line.split(": ", " ", "-")
            val password = parts[3]
            val char = parts[2].first()
            val index1 = parts[0].toInt()
            val index2 = parts[1].toInt()

            val chatAt1 = password[index1 - 1] == char
            val chatAt2 = password[index2 - 1] == char

            if ((chatAt1 || chatAt2) && (chatAt1 != chatAt2)) {
                validPasswords++
            }
        }
        println("[Part 2] $validPasswords")
    }
}