@echo off
rem run as admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
rem back to original batch directory
cd /d %~dp0

rem ----------------- test field -----------------


set local=1.0
set localtwo=%local%

if exist bin\version.bat del /F bin\version.bat
powershell -command "(new-object System.Net.WebClient).DownloadFile('https://pastebin.com/raw/DZgrPSGh', '%~dp0\bin\version.bat')"
call bin\version.bat

if %local% == %localtwo (
    echo No updates found
) else (
    echo Update found version : %local%
)


rem ----------------- end field -----------------

pause