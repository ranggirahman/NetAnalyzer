@echo off
rem run as admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
rem back to original batch directory
cd /d %~dp0

echo checking internet connection
ping 8.8.8.8 -n 1 -w 1000

if errorlevel 1 (set internet=Not connected to internet) else (set internet=Connected to internet)

echo %internet%

  bin\adwcleaner.exe /eula /clean /noreboot /path %~dp0\bin\adwcleaner


pause