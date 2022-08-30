@echo off
cls

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: bioscheck.cmd
::
::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

setlocal

if /i {%1}=={} goto :USAGE
if /i {%1}=={/?} goto :USAGE

rem set path to Dell Command Configure
set EXE=C:\Program Files (x86)\Dell\Command Configure\X86_64\CCTK.exe

if {%1}=={-audio} (
	rem verify Audio settings
	set ARG=--IntegratedAudio --Microphone --InternalSpeaker
) else if /i {%1}=={-asset} (
	set ARG=--asset --PropOwnTag
) else if /i {%1}=={-wol} (
	set ARG=--DeepSleepCtrl --BlockSleep --WakeOnLan
) else if /i {%1}=={-all} (
	set ARG=--asset --PropOwnTag --DeepSleepCtrl --BlockSleep --WakeOnLan --IntegratedAudio --Microphone --InternalSpeaker --AcPwrRcvry --SmartErrors
) else goto :USAGE

echo.
echo Running CCTK utility with following arguements: %ARG%
echo Please wait ...
echo. 
"%EXE%" %ARG%
(endlocal) && (goto :EOF)

:://///////////////////////////// FUNCTIONS ///////////////////////////////////

:USAGE
cls
echo.
echo.
echo Usage %0 [arg] 
echo.
echo  -all
echo  -asset
echo  -audio
echo  -wol
echo. 
echo.
(endlocal) & (goto :EOF)
