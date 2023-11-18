@echo off
rem run as admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
rem back to original batch directory
cd /d %~dp0

rem app properties
rem if new version updated please edit Resources/latestver too
set ver=1.5.3
title "NetAnalyzer %ver%"
set header=NetAnalyzer %ver% - https://github.com/ranggirahman
set verlink=https://raw.githubusercontent.com/ranggirahman/NetAnalyzer/main/resources/info.txt
set downloadlink=https://github.com/ranggirahman/NetAnalyzer/releases

rem display initial variable
set hws=-
set tad=-
set ips=-
set wss=-
set hfs=-
set acs=-
set cos=-
set cln=-
set run=fini

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
  echo   Time and Date         [%tad%] 
  echo   Hosts                 [%hfs%]
  echo   Internet Protocol     [%ips%]
  echo   Windows Sockets API   [%wss%]
  echo   Adware Cleaner        [%acs%]
  echo   Connection            [%cos%]
  echo   System Cleanup        [%cln%]                 
  echo.
  echo ________________________________________________________________________________
  echo.

  goto :%run%  
)

:fpop prompt type title
  echo WScript.Quit msgBox("%~1",%~2,"%~3") >"%~dp0\bin\fpop.tmp" 
  cscript //nologo //e:vbscript "%~dp0\bin\fpop.tmp"
  set "exitcode=%errorlevel%"
  del /f "%~dp0\bin\fpop.tmp" >nul 2>nul

  exit /b %exitcode%
rem close function

:fini (
  rem check connection
  call :fchk
  if %internet% == 1 (
    call :fupd
  )

  echo   Press "Enter" to Start
  pause >nul

  rem create operation directory if not exist
  if not exist "%~dp0\results" mkdir "%~dp0\results"
  if not exist "%~dp0\backup" mkdir "%~dp0\backup"

  rem if exist delete old temp log first
  if exist %~dp0\results\log del /F %~dp0\results\log
  
  rem create log file
  ( 
    echo %header% 
    echo Started : %date:/=-% %time::=-%
  ) > %~dp0\results\log

  set hws=Collect
  set run=fhws
  goto :main
)

:fchk (
  ping 8.8.8.8 -n 1 -w 1000 >nul
  rem if no connection
  if errorlevel 1 (
    set internet=0
  ) else (
    set internet=1
  )  
  
  rem end of function
  exit /b
)

:fupd (
  rem check app update  
  rem if exist delete old dump first
  if exist %~dp0\bin\fupd.tmp del /f %~dp0\bin\fupd.tmp

  rem get latest version
  powershell -command "(new-object System.Net.WebClient).DownloadFile('%verlink%', '%~dp0\bin\fupd.tmp')"

  rem find version value
  for /f "eol=: tokens=4 delims= " %%a in ('find "Version" %~dp0\bin\fupd.tmp') do (
   set latestver=%%a
  )

  del /f "%~dp0\bin\fupd.tmp" >nul 2>nul

  if %ver% == %latestver% (
    echo   No updates found
  ) else (
    echo   New version found %latestver%
    call :fpop "Choose 'Yes' to visit the site or 'No' to update later." "VBYesNo+VBQuestion" "New version found, Would you like to update ?"
    rem if Yes do update
    if errorlevel 7 (
      rem update later
    ) else if errorlevel 6 (
      start "" %downloadlink%"
      exit
    ) 
  )
  
  rem end of function
  exit /b
)

:fhws (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Hardware :
  ) >> %~dp0\results\log  

  rem collect hardware information
  systeminfo >> %~dp0\results\log

  set hws=Done
  set tad=Sync
  set run=ftad
  goto :main
)

:ftad (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Computer Time and Date :
  ) >> %~dp0\results\log
  
  rem start service
  net start w32time

  rem use w32tm to force synchronization with the specified ntp server
  w32tm /query /peers >> %~dp0\results\log
  sc config w32time start= auto >> %~dp0\results\log
  w32tm /config /manualpeerlist:%NTPServer% /syncfromflags:manual /reliable:YES /update >> %~dp0\results\log

  rem restart service
  net stop w32time
  net start w32time
  w32tm /resync /nowait >> %~dp0\results\log

  set tad=Done
  set hfs=Backup
  set run=fhfback
  goto :main
)

:fhfback (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Host File :
    echo.
  ) >> %~dp0\results\log

  rem execution search
  for /f "tokens=*" %%A in ('dir "%~dp0\backup\*" /B /S /O:D') do (set "newestback=%%A")

  rem compare newest backup with system
  fc "%newestback%" %SystemRoot%\System32\Drivers\etc\hosts >nul
  rem backup file is different from system
  if errorlevel 1 (
    copy %SystemRoot%\System32\Drivers\etc\hosts %~dp0\backup\"hosts %date:/=-% %time::=-%"
    echo Existing system Hosts files backup to 'hosts %date:/=-% %time::=-%' >> %~dp0\results\log
  ) else (
    echo Not backup because system Host file same as last backup >> %~dp0\results\log
  )
  set hfs=Update
  set run=fhfud
  goto :main
)

:fhfud (
  rem if connected
  if %internet% == 1 (
    rem get hosts file and overwrite system hosts file
    powershell -command "(new-object System.Net.WebClient).DownloadFile('%hostslink%', '%~dp0\bin\hosts\hosts-download')"

    rem delete some ip detected as danger
    findstr /v "52.215.192.131 www.status.streamable.com status.streamable.com" %~dp0\bin\hosts\hosts-download > %SystemRoot%\System32\Drivers\etc\hosts

    rem update log file
    echo Update Success from %hostsprovider% >> %~dp0\results\log
  rem if disconnected
  ) else (
    rem get hosts file and overwrite system hosts file
    copy %~dp0\bin\hosts\hosts-patch %SystemRoot%\System32\Drivers\etc\hosts

    rem update log file
    echo Update Success >> %~dp0\results\log
  )

  set hfs=Done
  set ips=Flush DNS
  set run=fipsfls
  goto :main
)

:fipsfls (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Internet Protocol :
  ) >> %~dp0\results\log 
  
  rem flush domain name server
  ipconfig /flushdns >> %~dp0\results\log

  set ips=Register DNS
  set run=fipsreg
  goto :main
)

:fipsreg (
  rem register new domain name server
  ipconfig /registerdns >> %~dp0\results\log

  set ips=Release IP
  set run=fipsrel
  goto :main
)

:fipsrel (
  rem release internet protocol
  ipconfig /release >> %~dp0\results\log

  set ips=Renew IP
  set run=fipsnew
  goto :main
)

:fipsnew (
  rem renew internet protocol
  ipconfig /renew >> %~dp0\results\log

  set ips=Done
  set wss=Reset
  set run=fwss
  goto :main
)

:fwss (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Windows Sockets API :
  ) >> %~dp0\results\log 
  rem run windows socket reset
  netsh winsock reset >> %~dp0\results\log

  set wss=Done
  set acs=Scan
  set run=facs
  goto :main
)

:facs (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Adware Cleaner :
  ) >> %~dp0\results\log 

  rem run adware cleaner with auto clean and dont reboot
  %~dp0\bin\adwcleaner.exe /eula /clean /noreboot /path %~dp0\results

  rem execution search
  for /f "tokens=*" %%A in ('dir "%~dp0\results\AdwCleaner\Logs\*.txt" /B /S /O:D') do (SET "newestadwl=%%A")

  rem copy to log
  type "%newestadwl%" >> %~dp0\results\log

  set acs=Done
  set cos=Test
  set run=fcos
  goto :main
)

:fcos (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo Connection :
    echo.
  ) >> %~dp0\results\log 

  rem check connection
  call :fchk
  if %internet% == 1 (
    rem clean run speedtest and accept license
    %~dp0\bin\speedtest.exe --accept-license >> %~dp0\results\log
    set cos=Done
  ) else (
    echo Connection test skipped because it doesn't connect to the internet >> %~dp0\results\log
    set cos=Skip
  )   
  
  set cln=Clean
  set run=fcln
  goto :main
)

:fcln (
  rem update log file
  ( 
    echo ________________________________________________________________________________
    echo System Cleanup :
    echo.
  ) >> %~dp0\results\log 

  rem delete temporary files
  del /s /f /q %windir%\temp\*.* >nul
  del /s /f /q %windir%\prefetch\*.* >nul
  del /s /f /q %temp%\*.* >nul
  del /s /f /q %appdata%\temp\*.* >nul
  del /s /f /q %homepath%\appdata\locallow\temp\*.* >nul

  rem delete used drivers files (not needed because already installed)
  del /s /f /q %systemdrive%\amd\*.* >nul
  del /s /f /q %systemdrive%\nvidia\*.* >nul
  del /s /f /q %systemdrive%\intel\*.* >nul

  rem delete temporary folders
  rd /s /q %windir%\temp >nul
  rd /s /q %windir%\prefetch >nul
  rd /s /q %temp% >nul
  rd /s /q %appdata%\temp >nul
  rd /s /q %homepath%\appdata\locallow\temp >nul

  rem delete used drivers folders (not needed because already installed)
  rd /s /q %systemdrive%\amd >nul
  rd /s /q %systemdrive%\nvidia >nul
  rd /s /q %systemdrive%\intel >nul

  rem recreate empty temporary folders
  md %windir%\temp >nul
  md %windir%\prefetch >nul
  md %temp% >nul
  md %appdata%\temp >nul
  md %homepath%\appdata\locallow\temp >nul

  rem update log file
  echo System File Cleanup Success >> %~dp0\results\log

  set cln=Done
  set run=fend
  goto :main
)

:fend (
  set tcom=%date:/=-% %time::=-%

  rem update log file (end)
  ( 
    echo ________________________________________________________________________________
    echo Completed : %tcom%
  ) >> %~dp0\results\log 
  
  ren %~dp0\results\log "log %tcom%.txt"
  
  rem show popup dialog
  call :fpop "Select 'Yes' to restart computer now or 'No' to review report and restart later." "VBYesNo+VBQuestion" "Would you like to restart computer now ?"
  rem if No do view report
  if errorlevel 7 (
    echo Restart Pending >> %~dp0\results\log
    %~dp0\results\"log %tcom%.txt"
  rem if Yes do restart
  ) else if errorlevel 6 (
    echo Restart Immediately >> %~dp0\results\log
    shutdown -t 0 -r -f
  )

  exit
)