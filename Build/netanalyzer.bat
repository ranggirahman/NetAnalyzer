@echo off
:: run as admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
:: back to original batch directory
cd /d %~dp0

setlocal enableextensions

:: initial variable
set ver=1.5.0
set header=Net Analyzer %ver% - https://github.com/ranggirahman
set hws=-
set ips=-
set wss=-
set hfs=-
set acs=-
set cos=-
set run=finit
title "Net Analyzer %ver%"

:main (
  :: main display
  cls
  echo.
  echo    _   _        _                             _                        
  echo   ^| \ ^| ^|      ^| ^|       /\                  ^| ^|                       
  echo   ^|  \^| ^|  ___ ^| ^|_     /  \    _ __    __ _ ^| ^| _   _  ____ ___  _ __ 
  echo   ^| . ` ^| / _ \^| __^|   / /\ \  ^| '_ \  / _` ^|^| ^|^| ^| ^| ^|^|_  // _ \^| '__^|
  echo   ^| ^|\  ^|^|  __/^| ^|_   / ____ \ ^| ^| ^| ^|^| ^|_^| ^|^| ^|^| ^|_^| ^| / /^|  __/^| ^|   
  echo   ^|_^| \_^| \___^| \__^| /_/    \_\^|_^| ^|_^| \__,_^|^|_^| \__, ^|/___^|\___^|^|_^|   
  echo                                                   __/ ^|                
  echo                                                  ^|___/   
  echo ________________________________________________________________________________
  echo.
  echo   %header%
  echo ________________________________________________________________________________
  echo.
  echo   Hardware              [%hws%]  
  echo   Hosts                 [%hfs%]
  echo   Internet Protocol     [%ips%]
  echo   Windows Shockets API  [%wss%]
  echo   Adware Cleaner        [%acs%]
  echo   Connection            [%cos%]                 
  echo.
  echo ________________________________________________________________________________
  echo.
  if %run% == finit (
    echo   Press "Enter" to Start
    pause >nul
  )
  echo.

  goto %run%  
)

:finit (
  :: if exist delete old temp log first
  if exist results\log del /F results\log
  
  :: create log file
  ( 
    echo %header% 
    echo Started : %date:/=-% %time::=-%
  ) > results\log

  :: check connection
  ping 8.8.8.8 -n 1 -w 1000
  if errorlevel 1 (
    set internet=0
  ) else (
    set internet=1
  )  

  set hws=Collect
  set run=fhws
  goto main
)

:fhws (
  :: update log file
  ( 
    echo ________________________________________________________________________________
    echo Hardware :
  ) > results\log  

  :: collect hardware information
  systeminfo >> results\log

  set hws=Done
  set hfs=Backup
  set run=fhfback
  goto main
)

:fhfback (
  :: update log file
  ( 
    echo ________________________________________________________________________________
    echo Host File :
    echo.
  ) >> results\log

  :: execution search
  for /f "tokens=*" %%A in ('dir "%~dp0\backup\*" /B /S /O:D') do (set "newestback=%%A")

  :: compare newest backup with system
  fc "%newestback%" %SystemRoot%\System32\Drivers\etc\hosts >nul
  :: backup file is different from system
  if errorlevel 1 (
    copy %SystemRoot%\System32\Drivers\etc\hosts %~dp0\backup\"hosts %date:/=-% %time::=-%"
    echo Existing system Hosts files backup to 'hosts %date:/=-% %time::=-%' >> results\log
  ) else (
    echo Not backup because system Host file same as last backup >> results\log
  )
  set hfs=Update
  set run=fhfud
  goto main
)

:fhfud (
  :: if connected
  if %internet% == 1 (
    :: get hosts file and overwrite system hosts file
    powershell -command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts.sfw', '%~dp0\bin\hosts\hosts-bebasid')"

    :: delete some ip detected as danger
    findstr /v "52.215.192.131 www.status.streamable.com status.streamable.com" %~dp0\bin\hosts\hosts-bebasid > %SystemRoot%\System32\Drivers\etc\hosts

    :: update log file
    echo Updated Successfully from BebasID >> results\log
  :: if disconnected
  ) else (
    :: get hosts file and overwrite system hosts file
    copy %~dp0\bin\hosts\hosts-patch %SystemRoot%\System32\Drivers\etc\hosts

    :: update log file
    echo Updated Successfully >> results\log
  )

  set hfs=Done
  set ips=Flush DNS
  set run=fipsfls
  goto main
)

:fipsfls (
  :: update log file
  ( 
    echo ________________________________________________________________________________
    echo Internet Protocol :
  ) >> results\log 
  
  :: flush domain name server
  ipconfig /flushdns >> results\log

  set ips=Register DNS
  set run=fipsreg
  goto main
)

:fipsreg (
  :: register new domain name server
  ipconfig /registerdns >> results\log

  set ips=Release IP
  set run=fipsrel
  goto main
)

:fipsrel (
  :: release internet protocol
  ipconfig /release >> results\log

  set ips=Renew IP
  set run=fipsnew
  goto main
)

:fipsnew (
  :: renew internet protocol
  ipconfig /renew >> results\log

  set ips=Done
  set wss=Reset
  set run=fwss
  goto main
)

:fwss (
  :: update log file
  ( 
    echo ________________________________________________________________________________
    echo Windows Shockets API :
  ) >> results\log 
  :: run windows shocket reset
  netsh winsock reset >> results\log

  set wss=Done
  set acs=Scan
  set run=facs
  goto main
)

:facs (
  :: update log file
  ( 
    echo ________________________________________________________________________________
    echo Adware Cleaner :
  ) >> results\log 

  :: run adware cleaner with auto clean and dont reboot
  bin\adwcleaner.exe /eula /clean /noreboot /path %~dp0\results

  :: execution search
  for /f "tokens=*" %%A in ('dir "%~dp0\results\AdwCleaner\Logs\*.txt" /B /S /O:D') do (SET "newestadwl=%%A")

  :: copy to log
  type "%newestadwl%" >> results\log

  set acs=Done
  set cos=Test
  set run=fcosspe
  goto main
)

:fcosspe (
  ( 
    echo ________________________________________________________________________________
    echo Speedtest :
  ) >> results\log 

  :: clean run speedtest and accept license
  bin\speedtest.exe --accept-license >> results\log

  set cos=Done
  set run=fend
  goto main
)

:fend (
  set tcom=%date:/=-% %time::=-%

  :: update log file (end)
  ( 
    echo ________________________________________________________________________________
    echo Completed : %tcom%
  ) >> results\log 
  
  ren results\log "log %tcom%.txt"
  
  cscript //nologo //e:vbscript "bin\msg"
  set "exitCode=%errorlevel%"
  :: if No do view report
  if errorlevel 7 (
    results\"log %tcom%.txt"
  :: if Yes do restart
  ) else if errorlevel 6 (
    shutdown -t 0 -r -f
  )

  exit
)