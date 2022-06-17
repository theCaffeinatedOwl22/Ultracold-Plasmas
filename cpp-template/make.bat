:: User Controls
@ECHO OFF
echo.
setlocal enabledelayedexpansion
setlocal enableextensions
:: USER INPUT
set file_ind=0
set flag=-O3
:: LOGGED FILE NAMES
set files[0]=main
set file_num=0
:: COMPILE ALL FILES
set start=%file_ind%
set finish=%file_ind%
if %file_ind%==all (
    set start=0
    set finish=!file_num!
)
for /l %%i in (%start%,1,%finish%) do (
    mingw32-make MAINFILE=!files[%%i]! FLAG=!flag! SHELL=cmd
)
echo -------