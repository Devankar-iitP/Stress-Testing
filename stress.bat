@echo off

if [%1]==[] (set /A cnt = 100) else (set /A cnt = %1)
if [%2]==[] (set /A chk = 0) else (set /A chk = 1)

REM 1) fast running time
REM     g++ -O2 -std=c++17 -Wno-unused-result -Wshadow -Wall -o a a.cpp

REM 2) check for mistakes
REM     g++ -std=c++17 -Wshadow -Wall -o a a.cpp
REM         -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG -g

g++ -std=c++17 gen.cpp -o gen
g++ -std=c++17 solution.cpp -o solution

if %chk% == 1 (
    g++ -std=c++17 checker.cpp -o checker
) else (
    g++ -std=c++17 brute.cpp -o brute
)

echo Done compiling...
set diff_found=

REM chk = 1 means multiple solutions exist
if %chk% == 1 (
    echo 1 > output3.out
    for /l %%x in (1, 1, %cnt%) do (
        echo %%x
        gen > input.in
        solution < input.in > output.out
        checker < output.out > output2.out

        fc /w output2.out output3.out > diff
        if errorlevel == 1 (
            set "diff_found=1"
            goto :level1
        )
    )
) else (
    for /l %%x in (1, 1, %cnt%) do (
        echo %%x
        gen > input.in
        solution < input.in > output.out 
        brute < input.in > output2.out
        
        fc /w output.out output2.out > diff
        if errorlevel == 1 (
            set "diff_found=1"
            goto :level2
        )
    )
    goto :level2
)

:level1
if defined diff_found (
    echo Found wrong answer for below input :
    type input.in
    echo.

    echo Your output does not satisy the condition :
    type output.out
    echo.
) else (
    echo All testcases passed :^)
)
del checker.exe
del output3.out
goto :end

:level2
if defined diff_found (
    echo Input: 
    type input.in
    echo.

    echo Output:
    type output.out
    echo.

    echo Expected:
    type output2.out
) else (
    echo All testcases passed :^)
)
REM Comment below to see I/O files - to debug
del brute.exe

:end
del diff
del output2.out
del input.in
del output.out
del gen.exe
del solution.exe