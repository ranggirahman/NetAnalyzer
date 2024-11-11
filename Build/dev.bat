@echo off
rem run as admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
rem back to original batch directory
cd /d %~dp0
set updlink=https://codeload.github.com/ranggirahman/Trace/tar.gz/master

rem ----------------- test field -----------------

  powershell -command "(new-object System.Net.WebClient).DownloadFile('%updlink%', '%~dp0update')"

rem ----------------- end field -----------------

pause