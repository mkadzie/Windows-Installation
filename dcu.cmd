@echo off
cls

Setlocal

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

set CLI=
set ARG=
set EXE1=C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe
set EXE2=C:\Program Files\Dell\CommandUpdate\dcu-cli.exe

:MAIN
	call :GET_ARG %1
	if not defined ARG goto :USAGE
	call :APP_EXIST
	if not defined CLI echo    DCU not installed & goto :EXIT 
	%DEBUG% ***** DCU is intalled at %CLI%
    	
	call :RUN_APP
endlocal & goto :EOF


:APP_EXIST
if exist "%EXE1%" set CLI=%EXE1%
if not defined CLI (
  %DEBUG%    DCU not installed in default location
  if exist "%EXE2%" set CLI=%EXE2%
  %DEBUG%    DCU installed in alternate location
)
exit /b

:GET_ARG
%DEBUG% Get Command Line arguments %1
if /i {%1}=={-apply} set ARG=/applyUpdates -silent -reboot=disable
if /i {%1}=={-scan}  set ARG=/scan -silent
if /i {%1}=={-ver}   set ARG=/version
rem -outputlog=c:\temp\dcu-out.txt
%DEBUG% ***** the argument is %ARG%
exit /b

:RUN_APP
echo.
%DEBUG% Running DCU with arguments "%ARG%"
%RUNAPP% "%CLI%" %ARG%
exit /b

:USAGE
rem cls
echo.
echo.
echo Usage %0 [arg] 
echo.
echo  -ver     : display DCU version
echo  -scan    : silently scan for updates
echo  -apply   : siletnly apply updates
echo. 
echo.
:EXIT
echo.
(endlocal) & (goto :EOF)