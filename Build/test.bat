@echo off
rem run as admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
rem back to original batch directory
cd /d %~dp0

rem ----------------- test field -----------------


set local=1.0
set localtwo=%local%

if exist bin\version.bat del /F bin\version.bat
powershell -command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/ranggirahman/NetAnalyzer/main/version1', '%~dp0\bin\version')"

set /p Build=<version.txt
echo %Build%

if %local% == %localtwo% (
    echo No updates found
) else (
    echo Update found version : %local%
)


rem ----------------- end field -----------------

pause