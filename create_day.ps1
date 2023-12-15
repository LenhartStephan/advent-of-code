param (
  [string]$year = 2023, 
  [switch]$force = $false,
  [switch]$noInput = $false,
  [Parameter(Mandatory=$true)][Int16]$day
)

if($day -lt 10){
    $foldername = "day0$day";
}else{
    $foldername = "day$day";
}

if(-not (Test-Path -Path "./$foldername")){
    dart create ./day$day
    Start-Sleep -Milliseconds 500
    if(-not ("day$day" -eq $foldername)){
        Rename-Item -Path ./day$day -NewName $foldername
    }
    Set-Location $foldername

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
    dart format ./ -l 120
    Write-Host ""
    Write-Host "Successfuly created Advent-Of-Code day$day" -ForegroundColor Green
    Set-Location ./../
}

if(-not $noInput){
    if(Test-Path -path .\session.cookie){
        if(-not (Test-Path -path ./$foldername/input.txt) -or $force){
            $session = Get-Content .\session.cookie
            $req = Invoke-WebRequest https://adventofcode.com/2023/day/$day/input -Headers @{'cookie' = $session}
            if($req.StatusCode -eq 200){  
                $req.Content | Out-File -FilePath "./$foldername/input.txt"
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