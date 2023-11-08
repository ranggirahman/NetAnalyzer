@echo off
rem run as admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
rem back to original batch directory
cd /d %~dp0

rem app properties
rem if new version updated please edit Build/assets/verser too
set ver=1.5.0
title "Net Analyzer %ver%"
set header=Net Analyzer %ver% - https://github.com/ranggirahman
set verlink=https://raw.githubusercontent.com/ranggirahman/NetAnalyzer/main/assets/verser
set downloadlink=https://github.com/ranggirahman/NetAnalyzer/releases

rem initial variable
set hws=-
set ips=-
set wss=-
set hfs=-
set acs=-
set cos=-
set run=fupdate

rem hosts file update
set hostsprovider=BebasID
set hostslink=https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts.sfw

:main (
  rem main display
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

  goto %run%  
)

:fupdate (
  rem check app update
  
  rem if exist delete old dump first
  if exist bin\verdmp del /F bin\verdmp

  rem get latest version
  powershell -command "(new-object System.Net.WebClient).DownloadFile('%verlink%', '%~dp0\bin\verdmp')"
  set /p latestver=<"%~dp0\bin\verdmp"

  if %ver% == %latestver% (
    echo   No updates found
    echo   Press "Enter" to Start
    pause >nul

    set run=finit
    goto main
  ) else (
    echo   New version found %latestver%
    cscript //nologo //e:vbscript "bin\msgver"
    rem if No do continue process
    if errorlevel 7 (
      echo   Press "Enter" to Start
      pause >nul

      set run=finit
      goto main
    rem if Yes do update
    ) else if errorlevel 6 (
      start "" %downloadlink%"
      exit
    )  
  )
)

:finit (
  rem if exist delete old temp log first
  if exist results\log del /F results\log
  
  rem create log file
  ( 
    echo %header% 
    echo Started : %date:/=-% %time::=-%
  ) > results\log

  rem check connection
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
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Hardware :
  ) > results\log  

  rem collect hardware information
  systeminfo >> results\log

  set hws=Done
  set hfs=Backup
  set run=fhfback
  goto main
)

:fhfback (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Host File :
    echo.
  ) >> results\log

  rem execution search
  for /f "tokens=*" %%A in ('dir "%~dp0\backup\*" /B /S /O:D') do (set "newestback=%%A")

  rem compare newest backup with system
  fc "%newestback%" %SystemRoot%\System32\Drivers\etc\hosts >nul
  rem backup file is different from system
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
  rem if connected
  if %internet% == 1 (
    rem get hosts file and overwrite system hosts file
    powershell -command "(new-object System.Net.WebClient).DownloadFile('%hostslink%', '%~dp0\bin\hosts\hosts-download')"

    rem delete some ip detected as danger
    findstr /v "52.215.192.131 www.status.streamable.com status.streamable.com" %~dp0\bin\hosts\hosts-download > %SystemRoot%\System32\Drivers\etc\hosts

    rem update log file
    echo Update Success from %hostsprovider% >> results\log
  rem if disconnected
  ) else (
    rem get hosts file and overwrite system hosts file
    copy %~dp0\bin\hosts\hosts-patch %SystemRoot%\System32\Drivers\etc\hosts

    rem update log file
    echo Update Success >> results\log
  )

  set hfs=Done
  set ips=Flush DNS
  set run=fipsfls
  goto main
)

:fipsfls (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Internet Protocol :
  ) >> results\log 
  
  rem flush domain name server
  ipconfig /flushdns >> results\log

  set ips=Register DNS
  set run=fipsreg
  goto main
)

:fipsreg (
  rem register new domain name server
  ipconfig /registerdns >> results\log

  set ips=Release IP
  set run=fipsrel
  goto main
)

:fipsrel (
  rem release internet protocol
  ipconfig /release >> results\log

  set ips=Renew IP
  set run=fipsnew
  goto main
)

:fipsnew (
  rem renew internet protocol
  ipconfig /renew >> results\log

  set ips=Done
  set wss=Reset
  set run=fwss
  goto main
)

:fwss (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Windows Shockets API :
  ) >> results\log 
  rem run windows shocket reset
  netsh winsock reset >> results\log

  set wss=Done
  set acs=Scan
  set run=facs
  goto main
)

:facs (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Adware Cleaner :
  ) >> results\log 

  rem run adware cleaner with auto clean and dont reboot
  bin\adwcleaner.exe /eula /clean /noreboot /path %~dp0\results

  rem execution search
  for /f "tokens=*" %%A in ('dir "%~dp0\results\AdwCleaner\Logs\*.txt" /B /S /O:D') do (SET "newestadwl=%%A")

  rem copy to log
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

  rem clean run speedtest and accept license
  bin\speedtest.exe --accept-license >> results\log

  set cos=Done
  set run=fend
  goto main
)

:fend (
  set tcom=%date:/=-% %time::=-%

  rem update log file (end)
  ( 
    echo ________________________________________________________________________________
    echo Completed : %tcom%
  ) >> results\log 
  
  ren results\log "log %tcom%.txt"
  
  rem show popup dialog
  cscript //nologo //e:vbscript "bin\msgend"
  rem if No do view report
  if errorlevel 7 (
    results\"log %tcom%.txt"
  rem if Yes do restart
  ) else if errorlevel 6 (
    shutdown -t 0 -r -f
  )

  exit
)