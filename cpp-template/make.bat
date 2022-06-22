:: User Controls
@ECHO OFF
echo.
setlocal enabledelayedexpansion
setlocal enableextensions
:: USER INPUT
set file_ind=all
set flag=-O3
set clean=false
:: COMMAND LINE INPUT
if [%1] == [main] set file_ind=0
if [%1] == [clean] set clean=true
if not [%2] == [] set flag=%2
:: LOGGED FILE NAMES
set files[0]=main
set file_num=0
:: COMPILE ALL FILES
if [%clean%] == [true] set file_ind=0
set start=%file_ind%
set finish=%file_ind%
if %file_ind%==all (
    set start=0
    set finish=!file_num!
)
for /l %%i in (%start%,1,%finish%) do (
    if %clean%==true mingw32-make clean SHELL=cmd
    if %clean%==false mingw32-make MAINFILE=!files[%%i]! FLAG=!flag! SHELL=cmd
)
