:: Handle Input Arguments
@ECHO OFF
:: SYNTAS: launch <file> <array1> <array2>
:: USER INPUT
set array_min=0
set array_max=0
:: User Controls
if [%1] == [main] (
    set file=main
    set run_flag=
)
if [%1] == [test] (
    set file=test
    set run_flag=
)
if not [%2] == [] (
    set array_min=%2
    set array_max=%2
)
if not [%3] == [] (
    set array_max=%3
)
:: Function
call make %file% -O3
for /l %%x in (%array_min%,1,%array_max%) do (
    echo -------
    echo Running: %%x/%array_max% ...
    echo objects\run %run_flag%%%x
    call objects\run %run_flag%%%x
)
