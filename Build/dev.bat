@echo off
rem run as admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
rem back to original batch directory
cd /d %~dp0

rem ----------------- test field -----------------

for /f "eol=: tokens=4 delims= " %%a in ('find "Version" %~dp0/info.txt') do (
   set x=%%a
)

echo %x%

rem ----------------- end field -----------------

pause