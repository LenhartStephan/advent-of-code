fun main() {
    val day = Day08()
    day.part1()
    day.part2()
}

class Day08 : Day(8) {

    private val operations: List<Pair<String, Int>> =
        inputLines.map { Pair(it.substringBefore(' '), it.substringAfter(' ').toInt()) }

    private fun checkSolution(opList: List<Pair<String, Int>>): Pair<Int, Boolean> {
        var index: Int = 0
        var accumulator: Int = 0
        val visitedIndexes: MutableList<Int> = mutableListOf()

        while (true) {
            if (visitedIndexes.contains(index)) return Pair(accumulator, false)
            if (index >= opList.size) return Pair(accumulator, true)
            visitedIndexes.add(index)
            val op = opList[index]
            when (op.first) {
                "acc" -> {
                    accumulator += op.second
                    index += 1
                }

                "jmp" -> index += op.second
                "nop" -> index += 1
            }
        }
    }

    fun part1() {
        val (accumulator, _) = checkSolution(operations)

        println("[Part 1] $accumulator")
    }

    private fun fixError(): Int? {
        operations.forEachIndexed { ind, (op, _) ->
            if (op != "acc") {
                val list = operations.toMutableList()
                val invertedOp = if (op == "nop") "jmp" else "nop"
                list[ind] = list[ind].copy(invertedOp)
                val (accumulator, valid) = checkSolution(list)
                if (valid) return accumulator
            }
        }
        return null
    }

    fun part2() {
        val accumulator = fixError()

        println("[Part 1] $accumulator")
    }
}
