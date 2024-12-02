fun main() {
    val day = Day04()
    day.part1()
    day.part2()
}

class Day04 : Day(4) {

    private val passports = inputLines
        .reduce { a, b -> if (b == "") "$a\n" else "$a $b" }
        .split("\n")
        .map { line ->
            line
                .trim()
                .split(" ")
                .map { Pair(it.substringBefore(':'), it.substringAfter(':')) }
        }

    private val mandatoryFields = listOf<String>("byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid")

    private fun hasMandatoryFields(passport: List<Pair<String, String>>): Boolean {
        return mandatoryFields.all { field -> passport.find { (a, _) -> a == field } != null }
    }

    private fun hasValidFields(passport: List<Pair<String, String>>): Boolean {
        if (!hasMandatoryFields(passport)) return false
        for (pair in passport) {
            val (field, value) = pair

            if (!when (field) {
                    "byr" -> value.toInt() in 1920..2002
                    "iyr" -> value.toInt() in 2010..2020
                    "eyr" -> value.toInt() in 2020..2030
                    "hgt" -> {
                        val height = value.dropLast(2).toIntOrNull()
                        val isCm = value.endsWith("cm")
                        val isIn = value.endsWith("in")
                        (isCm && height in 150..193) || (isIn && height in 59..76)
                    }

                    "hcl" -> value.matches(Regex("#[0-9a-fA-F]{6}"))
                    "ecl" -> listOf("amb", "blu", "brn", "gry", "grn", "hzl", "oth").contains(value)
                    "pid" -> value.toIntOrNull() != null && value.length == 9
                    else -> true
                }
            ) return false
        }

        return true
    }

    fun part1() {
        val validPassports = passports.count { passport -> hasMandatoryFields(passport) }
        println("[Part 1] $validPassports")
    }

    fun part2() {
        val validPassports = passports.count { passport -> hasValidFields(passport) }
        println("[Part 2] $validPassports")
    }
}
