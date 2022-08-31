cls
@echo off
setlocal 

rem Wakeup PC by sending magic packet on port 40000 to vlan 1 on all core switches
rem WOL.EXE {MAC} {PORT} /d {SUBNET}

set exe= "C:\_SPL\bin\wol.exe"
set port= 40000
set macfile=%1

if {%macfile%}=={} goto :USAGE

if not exist %macfile% cls && echo MAC file ^"%macfile%^" does not exist && endlocal && GOTO:eof

rem: findstr has limited regex capabilities
for /f %%m in ('findstr /b /i "[0-9a-f][0-9a-f]:" %macfile%') do (
  echo sending magic packet to following MAC address: %%m
  for /l %%s in (20,1,23) do (
     %exe% %%m %port% /d 172.%%s.1.255 > nul
  )
)

endlocal && GOTO:eof

:USAGE
cls
echo.
echo      Wakeup all machines with MAC addresses in supplied "mac file"
echo.
echo.
echo USAGE:    %~f0 ^<macfile^>
echo.
echo.
endlocal && GOTO:eof

