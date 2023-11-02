@echo off
rem run as admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
rem back to original batch directory
cd /d %~dp0

setlocal ENABLEDELAYEDEXPANSION

rem initial variable
set header=Net Analyzer 1.5 - https://github.com/ranggirahman
set hws=-
set ips=-
set wss=-
set hfs=-
set acs=-
set cos=-
set active=Press "Enter" to Start
set run=0
title %header%
set server=8.8.8.8

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
  echo   Internet Protocol     [%ips%]
  echo   Windows Shockets API  [%wss%]
  echo   Hosts File            [%hfs%]
  echo   Adware Cleaner        [%acs%]
  echo   Connection            [%cos%]                 
  echo.
  echo ________________________________________________________________________________
  echo.
  echo   %active%
  echo %run%
  if %run% == 0 (
    pause >nul
    set hws=Collect
    set run=1
    goto main
  ) else if %run% == 1 (
    goto fhws
  ) else if %run% == 2 (
    goto fipsfls
  ) else if %run% == 3 (
    goto fipsreg
  ) else if %run% == 4 (
    goto fipsrel
  ) else if %run% == 5 (
    goto fipsnew
  ) else if %run% == 6 (
    goto fwss
  ) else if %run% == 7 (
    goto fhfs
  ) else if %run% == 8 (
    goto facs
  ) else if %run% == 9 (
    goto fcospin
  ) else if %run% == 10 (
    goto fcosspe
  ) else if %run% == 11 (
    goto fdone
  ) else (
    pause
  )                       
)

:fhws (
  rem if log exsist delete first
  del log.txt 

  rem create log file
  ( 
    echo %header% 
    echo Time : %time:~,5%, %date%
    echo ________________________________________________________________________________
    echo Hardware :
  ) > log.txt  

  rem collect hardware information
  systeminfo >> log.txt

  set hws=Done
  set ips=Flush DNS
  set run=2
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
  set run=3
  goto main
)

:fipsreg (
  rem register new domain name server
  ipconfig /registerdns >> log.txt

  set ips=Release IP
  set run=4
  goto main
)

:fipsrel (
  rem release internet protocol
  ipconfig /release >> log.txt

  set ips=Renew IP
  set run=5
  goto main
)

:fipsnew (
  rem renew internet protocol
  ipconfig /renew >> log.txt

  set ips=Done
  set wss=Reset
  set run=6
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
  set hfs=Update
  set run=7
  goto main
)

:fhfs (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Host File Issue :
  ) >> log.txt 

  rem get hosts file and overwrite system hosts file
  powershell -command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts.sfw', '%SystemRoot%\System32\Drivers\etc\hosts')" >> log.txt

  set hfs=Done
  set acs=Scan
  set run=8
  goto main
)

:facs (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Adware Cleaner Result :
  ) >> log.txt 

  rem accept adware cleaner eula
  bin\adwcleaner.exe /eula
  rem run adware cleaner with auto clean and dont reboot
  bin\adwcleaner.exe /clean /noreboot >> log.txt

  set acs=Done
  set cos=Ping Test
  set run=9
  goto main
)

:fcospin (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Ping Result :
  ) >> log.txt

  rem test ping 
  ping %server% >> log.txt

  set cos=Speed Test
  set run=10
  goto main
)

:fcosspe (
  ( 
    echo ________________________________________________________________________________
    echo Speedtest Result :
  ) >> log.txt 

  rem clean run speedtest and accept license
  bin\speedtest.exe --accept-license >> log.txt

  rem end of file
  ( 
    echo ________________________________________________________________________________
    echo End of File.
  ) >> log.txt 

  set cos=Done
  set run=11
  goto main
)

:fdone (
  rem clean memory (detect as virus)
  rem %windir%\system32\rundll32.exe advapi32.dll,ProcessIdleTasks

  rem show complete dialog
  bin\msg.vbs

  pause >nul 
  exit
)

