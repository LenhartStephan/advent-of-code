fun main() {
    val day = Day09()
    day.part1()
    day.part2()
}

class Day09 : Day(9) {

    private val inputNumbers = inputLines.map { it.toLong() }

    private fun findInvalidNumber(preambleLength: Int = 25): Long? {
        for (i in preambleLength..inputNumbers.lastIndex) {
            val preamble = inputNumbers.drop(i - preambleLength).take(preambleLength)
            val currentNumber = inputNumbers[i]
            var isValid = false
            for (preambleItem in preamble) {
                if (preamble.contains(currentNumber - preambleItem)) {
                    isValid = true
                    break
                }
            }
            if (!isValid) {
                return currentNumber
            }
        }
        return null
    }

    private fun findSumRange() : Pair<Long, Long>{
        val target = findInvalidNumber()!!

        for (rangeStartIndex in inputNumbers.indices) {
            var rangeEndIndex = rangeStartIndex
            val sumRange = mutableListOf<Long>()
            while (sumRange.sum() < target) {
                sumRange.add(inputNumbers[rangeEndIndex])
                if(sumRange.sum() == target) {
                    return Pair(sumRange.minOrNull()!!, sumRange.maxOrNull()!!)
                }
                rangeEndIndex++
            }
        }

        return Pair(0,0)
    }

    fun part1() {
        val invalidNumber = findInvalidNumber()

        println("[Part 1] $invalidNumber")
    }

    fun part2() {
        val sumRange = findSumRange()

        println("[Part 2] ${sumRange.first + sumRange.second}")
    }
}
