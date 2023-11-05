@echo off
rem run as admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
rem back to original batch directory
cd /d %~dp0

rem initial variable
set header=Net Analyzer 1.5 - https://github.com/ranggirahman
set hws=-
set ips=-
set wss=-
set hfs=-
set acs=-
set cos=-
set run=0
title %header%
set server=8.8.8.8

rem check connection
ping %server% -n 1 -w 1000
if errorlevel 1 (
  set internet=0
) else (
  set internet=1
)

:main (
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

  if %run% == 0 (
    echo   Press "Enter" to Start
    pause >nul
    set hws=Collect
    set run=1
    goto main
  ) else if %run% == 1 (
    goto fhws
  ) else if %run% == 2 (
    goto fhfs
  ) else if %run% == 3 (
    goto fipsfls
  ) else if %run% == 4 (
    goto fipsreg
  ) else if %run% == 5 (
    goto fipsrel
  ) else if %run% == 6 (
    goto fipsnew
  ) else if %run% == 7 (
    goto fwss
  ) else if %run% == 8 (
    goto facs
  ) else if %run% == 9 (
    goto fcosspe
  ) else if %run% == 10 (
    goto fdone
  ) else (
    rem error
    echo   Error Code 11
    pause
    exit
  )                       
)

:fhws (
  rem if log exsist delete first
  del log.txt 

  rem create log file
  ( 
    echo %header% 
    echo Started : %time:~,5%, %date%
    echo ________________________________________________________________________________
    echo Hardware :
  ) > log.txt  

  rem collect hardware information
  systeminfo >> log.txt

  set hws=Done
  set hfs=Update
  set run=2
  goto main
)

:fhfs (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Host File :
    echo.
  ) >> log.txt

  rem backup host file
  copy %SystemRoot%\System32\Drivers\etc\hosts %~dp0\backup\"host %date:/=-% %time::=-%"
  
  rem if connected
  if %internet% == 1 (
    rem get hosts file and overwrite system hosts file
    powershell -command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts.sfw', '%SystemRoot%\System32\Drivers\etc\hosts')" >> log.txt

    rem update log file
    echo Updated Successfully from BebasID >> log.txt
  rem if disconnected
  ) else (
    rem get hosts file and overwrite system hosts file
    copy %~dp0\bin\host\host-patch %SystemRoot%\System32\Drivers\etc\hosts

    rem update log file
    echo Updated Successfully >> log.txt
  )

  set hfs=Done
  set ips=Flush DNS
  set run=3
  goto main
)

:fipsfls (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Internet Protocol :
  ) >> log.txt 
  
  rem flush domain name server
  ipconfig /flushdns >> log.txt

  set ips=Register DNS
  set run=4
  goto main
)

:fipsreg (
  rem register new domain name server
  ipconfig /registerdns >> log.txt

  set ips=Release IP
  set run=5
  goto main
)

:fipsrel (
  rem release internet protocol
  ipconfig /release >> log.txt

  set ips=Renew IP
  set run=6
  goto main
)

:fipsnew (
  rem renew internet protocol
  ipconfig /renew >> log.txt

  set ips=Done
  set wss=Reset
  set run=7
  goto main
)

:fwss (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Windows Shockets API :
  ) >> log.txt 
  rem run windows shocket reset
  netsh winsock reset >> log.txt

  set wss=Done
  set acs=Scan
  set run=8
  goto main
)

:facs (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Adware Cleaner :
  ) >> log.txt 

  rem run adware cleaner with auto clean and dont reboot
  bin\adwcleaner.exe /eula /clean /noreboot /path %~dp0\bin 

  rem configuration for search newest log
  Set "MainDirectory=%~dp0\bin\AdwCleaner\Logs"
  Set "FileExtension=*.txt"
  Set "CopyDestination=%~dp0"

  rem execution search
  for /f "tokens=*" %%A in ('DIR "%MainDirectory%\%FileExtension%" /B /S /O:D') do (SET "NewestFile=%%A")

  rem copy log
  type "%NewestFile%" >> log.txt

  set acs=Done
  set cos=Speed Test
  set run=9
  goto main
)

:fcosspe (
  ( 
    echo ________________________________________________________________________________
    echo Speedtest :
  ) >> log.txt 

  rem clean run speedtest and accept license
  bin\speedtest.exe --accept-license >> log.txt

  set cos=Done
  set run=10
  goto main
)

:fdone (
  rem update log file (end)
  ( 
    echo ________________________________________________________________________________
    echo Completed : %time:~,5%, %date%
  ) >> log.txt 

  rem show complete dialog
  bin\msg.vbs

  echo   Report Generated in "log.txt"
  echo   Please Restart Your PC
  echo   Press "Enter" to Exit

  pause >nul 
  exit
)