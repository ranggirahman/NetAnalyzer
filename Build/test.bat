@echo off
rem run as admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
rem back to original batch directory
cd /d %~dp0

rem ----------------- test field -----------------



ping 8.8.8.8 -n 1 -w 1000 > nul

if errorlevel 1 (
  echo Not Connected
) else (
  echo Connected
)

powershell -command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts.sfw', '%~dp0\bin\host\host-download')
fc bin\host\host-download %SystemRoot%\System32\Drivers\etc\hosts > nul
if errorlevel 1 (
  echo Not Same
) else (
  echo Same
)



rem ----------------- end field -----------------

pause