param (
  [string]$year = 2023, 
  [switch]$force = $false,
  [switch]$noInput = $false,
  [Parameter(Mandatory=$true)][Int16]$day
)

if(-not (Test-Path -Path "./day$day")){
    dart create ./day$day
    Set-Location ./day$day/

     @"
import 'dart:io';
import 'package:day$day/day$day.dart' as day$day;

void main(List<String> arguments) async {
  File inputFile = File("input.txt");
  String input = inputFile.readAsStringSync().trim();

  print("Part 1: TODO");
  print("Part 2: TODO");
}
"@ | Out-File -FilePath "./bin/day$day.dart"

    mkdir -Path ".vscode";
    @"
{
  // Use IntelliSense to learn about possible attributes.
  // Hover to view descriptions of existing attributes.
  // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
  "version": "0.2.0",
  "configurations": [
      {
          "name": "day$day",
          "request": "launch",
          "type": "dart",
          "program": "bin/day$day.dart"
      }
  ]
}
"@ | Out-File -FilePath "./.vscode/launch.json";
    Remove-Item "./*.md"
    dart format ./
    Write-Host ""
    Write-Host "Successfuly created Advent-Of-Code day$day" -ForegroundColor Green
    Set-Location ./../
}

if(-not $noInput){
    if(Test-Path -path .\session.cookie){
        if(-not (Test-Path -path ./day$day/input.txt) -or $force){
            $session = Get-Content .\session.cookie
            $req = Invoke-WebRequest https://adventofcode.com/2023/day/$day/input -Headers @{'cookie' = $session}
            if($req.StatusCode -eq 200){  
                $req.Content | Out-File -FilePath "./day$day/input.txt"
                Write-Host "Successfuly created input file for day $day" -ForegroundColor Green
            }else{
                Write-Host "An Error occured during download of the input data for day$day. Please check your session file and try again." -ForegroundColor Red
            }
        }else{
            Write-Host "Input file for day$day already present." -ForegroundColor DarkGray
        }
    }else{
        Write-Host "session.cookie is missing. Could not download the input. Create the session file and try again." -ForegroundColor Yellow
    }
}