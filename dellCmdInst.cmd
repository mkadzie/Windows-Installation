@echo off
cls

setlocal

set DEBUG=echo

rem set DCCI=Dell-Command-Configure_95F54_WIN_4.7.0.433_A00.EXE
set DCCI=Dell-Command-Configure_HW2H3_WIN_4.8.0.494_A00.EXE
set DCCL=C:\Program Files (x86)\Dell\Command Configure\X86_64\cctk.exe

rem set DCUI=Dell-Command-Update-Windows-Universal-Application_601KT_WIN_4.5.0_A00_01.EXE
set DCUI=Dell-Command-Update-Windows-Universal-Application_DT6YC_WIN_4.6.0_A00.EXE
set DCUL=C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe

set APP=
set ARG= /s /l=C:\Temp
set LOG=

echo.
echo ======== Install and configure Dell Command Configure and Dell Command Update =========
echo.
echo.
:DCC_INST
echo Install Dell Command Configure (DCC)
if exist "%DCCL%" echo   DCC is already installed & goto :EXIT
if not exist "%DCCI%" echo   DCC installation file not found & goto :DCU_INST
%DEBUG% "%DCCI%" %ARG%\dcc_inst.log

echo.

:DCU_INST
echo Install Dell Command Update (DCU)
if exist "%DCUL%" echo    DCU is already installed & goto :EXIT
if not exist "%DCUI%" echo     DCU installation file not found & goto :EXIT
%DEBUG% "%DCUI%" %ARG%\dcu_inst.log

:DCU_CFG
echo Configure Dell Command Update 
set /p PWD="Enter BIOS password: "
set ARG=/configure -scheduleManual -biosPassword="%PWD%" 
%DEBUG% "%DCUL%" %ARG%


:EXIT
echo. & endlocal & goto :EOF


