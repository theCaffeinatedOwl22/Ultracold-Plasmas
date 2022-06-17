:: User Controls
@ECHO OFF
echo.
setlocal enabledelayedexpansion
setlocal enableextensions
:: USER INPUT
set file_ind=1
set flag=-O3
:: LOGGED FILE NAMES
set files[0]=main
set files[1]=test
:: COMPILE ALL FILES
mingw32-make MAINFILE=!files[%file_ind%]! FLAG=!flag! SHELL=cmd