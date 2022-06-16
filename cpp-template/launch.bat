@echo off
setlocal enabledelayedexpansion
setlocal enableextensions

:: inputs
set file=%1
set start=%2
set finish=%3

:: exec execs\gengrids
set gengrids_cmd=execs\gengrids --path E:\Grant-Gorman\data-mhd\06.12.22 -s ucnp.settings -c ucnp.config --overwrite 0 --array 0
:: exec main
set main_cmd=main -m input -o E:\Grant-Gorman\data-mhd\06.12.22\set_
:: exec test



if %start%.==. set start=0
if %finish%.==. set finish=%start%
if %file%==gengrids (
    echo %tab% Executing: %gengrids_cmd%
    %gengrids_cmd%
)
if %file%==main (
    for /l %%x in (%start%,1,%finish%) do (
        set command=%main_cmd%%%x
        echo Executing: !command!
        !command!
    )
    echo Complete.    
)

