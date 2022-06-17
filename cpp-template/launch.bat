:: Handle Input Arguments
@ECHO OFF
:: User Controls
set array_min=0
set array_max=1
:: Function
set compile=make
call %compile%
for /l %%x in (%array_min%,1,%array_max%) do (
    echo -------
    echo Running: %%x/%array_max% ...
    objects\run
)
echo -------
echo Complete.