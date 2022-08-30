@echo off
cls

rem psexec -nobanner -s \\PC -c <command to execute remotely>
rem for /l %%i in (1,1,9) do @echo %%i
rem for /f %%i in (cc.txt) do @echo %%i

setlocal EnableDelayedExpansion ENABLEEXTENSIONS


rem //// DEBUG ////
rem debug variale: echo | rem
set DEBUG=rem
rem set DEBUG=echo
rem runapp variable: "blank" or echo
rem set to echo if you want to see the command being 
rem executed instead of actually running the command.
set RUNAPP=
rem set RUNAPP=echo
if /i {%DEBUG%}=={echo} (
	echo.
	echo ============= DEBUG MODE ON ==============
)
rem ///////////////

set EXE=psExec64.exe -nobanner -s
set PC=
set FILE=

:MAIN
	if {%1}=={} goto :USAGE
	if {%2}=={} goto :USAGE
	if {%1}=={-pc} ( set PC=%2 )
	if {%1}=={-txt} (
	   if not exist %2 echo text file "%2" does not exist & goto :USAGE
	   set FILE=%2
	)
	set /p RUN="Enter the command to run: "
	if defined PC ( %RUNAPP% %EXE% \\%PC% -c %RUN% )
	if defined FILE ( for /f %%i in (%FILE%) do %RUNAPP% %EXE% \\%%i -c %RUN% )

endlocal & goto :EOF


:USAGE
rem cls
echo.
echo.
echo Usage %~nx0 [args] 
echo.
echo  -pc "pc"          : run remote command on single "pc"
echo  -txt "file.txt"   : run remote command on list of PCs in "file.txt"
echo. 
echo.
:EXIT
echo.
(endlocal) & (exit /b 1)