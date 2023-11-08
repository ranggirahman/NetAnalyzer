@echo off
rem run as admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
rem back to original batch directory
cd /d %~dp0

rem ----------------- test field -----------------


ping .12.3.231 
if %ERRORLEVEL% neq 0 echo error


rem ----------------- end field -----------------

pause