#!/bin/bash

year=2023
force=false
noInput=false

while getopts ":y:fn" opt; do
  case $opt in
    y) year="$OPTARG"
    ;;
    f) force=true
    ;;
    n) noInput=true
    ;;
    \?) echo "Invalid option: -$OPTARG" >&2
    ;;
  esac
done

shift $((OPTIND-1))
day=$1

if [ -z "$day" ]; then
    echo "Error: Day is a required argument."
    echo -e "\nUsage: $0 <day>"
    echo -e "\nOptional:\n-y <year> = Year\n-n = Create no Input file\n-f = Force override of input file"
    exit 1
fi

if [ ! -d "./day$day" ]; then
    dart create "./day$day"
    cd "./day$day" || exit

    echo "
import 'dart:io';
import 'package:day$day/day$day.dart' as day$day;

void main(List<String> arguments) async {
  File inputFile = File(\"input.txt\");
  String input = inputFile.readAsStringSync().trim();

  print(\"Part 1: TODO\");
  print(\"Part 2: TODO\");
}
" > "./bin/day$day.dart"

    mkdir -p ".vscode"
    echo "
{
  \"version\": \"0.2.0\",
  \"configurations\": [
      {
          \"name\": \"day$day\",
          \"request\": \"launch\",
          \"type\": \"dart\",
          \"program\": \"bin/day$day.dart\"
      }
  ]
}
" > "./.vscode/launch.json"

    rm ./*.md
    dart format ./
    echo ""
    echo "Successfully created Advent-Of-Code day$day" 
    cd ..
fi

if [ ! "$noInput" = true ]; then
    if [ -e "./session.cookie" ]; then
        if [ ! -e "./day$day/input.txt" ] || [ "$force" = true ]; then
            session=$(cat "./session.cookie")
            req=$(curl -s -b "session=$session" "https://adventofcode.com/$year/day/$day/input")
            if [ "$?" -eq 0 ]; then
                echo "$req" > "./day$day/input.txt"
                echo "Successfully created input file for day $day"
            else
                echo "An error occurred during the download of the input data for day$day. Please check your session file and try again." >&2
            fi
        else
            echo "Input file for day$day already present."
        fi
    else
        echo "session.cookie is missing. Could not download the input. Create the session file and try again." >&2
    fi
fi