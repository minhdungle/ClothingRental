@echo off
setlocal
cd /d "%~dp0" || exit /b 1
where java >nul 2>nul
if errorlevel 1 (
  echo Install JDK 17 or later, add Java to PATH, then open this file again.
  pause
  exit /b 1
)
set "deskJar=ClothingRentalUI.jar"
if exist "target\ClothingRentalUI.jar" set "deskJar=target\ClothingRentalUI.jar"
java -jar "%deskJar%"
if errorlevel 1 (
  echo Check that Java is version 17 or later and that the project ZIP has been extracted.
  pause
  exit /b 1
)
