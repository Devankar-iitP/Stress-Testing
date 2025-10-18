@echo off
REM --- This batch script compiles and runs a C++ program with file redirection ---

REM Set the name of your C++ source file and the desired executable name.
SET CPP_FILE=oa.cpp
SET EXE_FILE=oa.exe
SET INPUT_FILE=oa.txt
SET OUTPUT_FILE=output.txt

REM 1. Compile the C++ code using g++.
REM    Make sure g++ is installed and in your system's PATH.
echo Compiling %CPP_FILE%...
g++ %CPP_FILE% -o %EXE_FILE%

REM Check if compilation was successful.
if %errorlevel% neq 0 (
    echo Compilation failed!
    exit /b
)

echo Compilation successful.

REM 2. Run the compiled program.
REM    - The '<' symbol redirects the content of input.txt to the program's standard input.
REM    - The '>' symbol redirects the program's standard output to output.txt.
echo Running %EXE_FILE% with %INPUT_FILE%...
%EXE_FILE% < %INPUT_FILE% > %OUTPUT_FILE%

echo.
echo Done! Check the %OUTPUT_FILE% for the result.
del %EXE_FILE%