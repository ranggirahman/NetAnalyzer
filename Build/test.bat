@echo off
rem run as admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
rem back to original batch directory
cd /d %~dp0

rem ----------------- test field -----------------


set ver=1.0

if exist bin\dmpver del /F bin\dmpver
powershell -command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/ranggirahman/NetAnalyzer/main/version2', '%~dp0\bin\dmpver')"
set /p latestver=<"%~dp0\bin\dmpver"

if %ver% == %latestver% (
  echo No updates found
) else (
  cscript //nologo //e:vbscript "bin\msgver"
  rem if No do continue process
  if errorlevel 7 (
    goto
  rem if Yes do update
  ) else if errorlevel 6 (
    start "" "%updatelink%"
  )  
)


rem ----------------- end field -----------------

pause