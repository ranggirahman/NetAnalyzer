@echo off
rem run as admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
rem back to original batch directory
cd /d %~dp0

rem ----------------- test field -----------------

rem use w32tm to force synchronization with the specified ntp server
w32tm /query /peers
sc config w32time start= auto
w32tm /config /manualpeerlist:%NTPServer% /syncfromflags:manual /reliable:YES /update

rem restart service
net stop w32time
net start w32time
w32tm /resync /nowait


rem ----------------- end field -----------------

pause