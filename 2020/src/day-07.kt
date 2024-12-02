fun main() {
    val day = Day07()
    day.part1()
    day.part2()
}

class Day07 : Day(7) {

    private val rules: Map<String, List<Pair<Int, String>>> = createRules()

    private fun createRules(): Map<String, List<Pair<Int, String>>> {
        val rules = mutableMapOf<String, List<Pair<Int, String>>>()
        inputLines.forEach { line ->
            val splits = line.split("bags contain")
            val ruleSplits: List<Pair<Int, String>> = splits.last().split(", ").filter { it.isNotEmpty() && !it.contains("no other bags") }.map { split ->
                val s = split.split(" ").filter { it.isNotEmpty() }
                val num = s.first().trim().toInt()
                val bagName = s
                    .drop(1)
                    .joinToString(" ")
                    .replace("bags", "")
                    .replace("bag", "")
                    .replace(".", "")
                    .trim()
                Pair(num, bagName)
            }
            rules[splits.first().trim()] = ruleSplits
        }
        return rules.toMap()
    }

    fun part1() {
        val queue = mutableListOf("shiny gold")
        val visited = mutableSetOf<String>()
        var elements = 0

        while (queue.isNotEmpty()) {
            val currentBag: String = queue.removeFirst()
            if(currentBag != "shiny gold") elements += 1
            visited.add(currentBag)
            val bagsContainingCurrent: Iterable<String> = rules.filter { it.value.any { pair -> pair.second == currentBag } }.keys
            queue.addAll(bagsContainingCurrent)
            queue.removeIf{ visited.contains(it) }
        }


        println("[Part 1] $elements")
    }

    private fun containedBags(bag: String): Int {
        val containedBags: List<Pair<Int, String>> = (rules[bag] ?: listOf())
        var numOfBags = 0

        for (innerBag in containedBags) {
            numOfBags += innerBag.first + innerBag.first * containedBags(innerBag.second)
        }

        return numOfBags
    }

    fun part2() {
        val contained = containedBags("shiny gold")

        println("[Part 2] $contained")
    }
}
