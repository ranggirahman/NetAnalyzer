@echo off
rem run as admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
rem back to original batch directory
cd /d %~dp0

rem initial variable
set header=Net Analyzer 1.5 - https://github.com/ranggirahman
title %header%
set server=8.8.8.8

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
echo   Hardware Check        [-]
echo   Domain Name Server    [-]
echo   Internet Protocol     [-]
echo   Windows Shockets API  [-]
echo   Hosts File            [-]
echo   Adware Cleaner        [-]
echo   Connection Test       [-]                 
echo.
echo ________________________________________________________________________________
echo.
echo                           Press "Enter" to Start
pause >nul

rem create log file
del log.txt 
( 
echo %header% 
echo Time : %time:~,5%, %date%
echo ________________________________________________________________________________
echo Hardware Info :
) > log.txt 

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
echo   Hardware Check        [Collect]
echo   Domain Name Server    [-]
echo   Internet Protocol     [-]
echo   Windows Shockets API  [-]
echo   Hosts File            [-]
echo   Adware Cleaner        [-]
echo   Connection Test       [-]                 
echo.
echo ________________________________________________________________________________
rem collect hardware information
systeminfo >> log.txt

( 
echo ________________________________________________________________________________
echo Domain Name Server :
) >> log.txt 

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
echo   Hardware Check        [Done]
echo   Domain Name Server    [Flush]
echo   Internet Protocol     [-]
echo   Windows Shockets API  [-]
echo   Hosts File            [-]
echo   Adware Cleaner        [-]
echo   Connection Test       [-]                 
echo.
echo ________________________________________________________________________________
rem flush domain name server
ipconfig /flushdns >> log.txt

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
echo   Hardware Check        [Done]
echo   Domain Name Server    [Register]
echo   Internet Protocol     [-]
echo   Windows Shockets API  [-]
echo   Hosts File            [-]
echo   Adware Cleaner        [-]
echo   Connection Test       [-]                 
echo.
echo ________________________________________________________________________________
rem register new domain name server
ipconfig /registerdns >> log.txt

( 
echo ________________________________________________________________________________
echo Internet Protocol :
) >> log.txt

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
echo   Hardware Check        [Done]
echo   Domain Name Server    [Release]
echo   Internet Protocol     [-]
echo   Windows Shockets API  [-]
echo   Hosts File            [-]
echo   Adware Cleaner        [-]
echo   Connection Test       [-]                 
echo.
echo ________________________________________________________________________________
rem release internet protocol
ipconfig /release >> log.txt

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
echo   Hardware Check        [Done]
echo   Domain Name Server    [Done]
echo   Internet Protocol     [Renew]
echo   Windows Shockets API  [-]
echo   Hosts File            [-]
echo   Adware Cleaner        [-]
echo   Connection Test       [-]                 
echo.
echo ________________________________________________________________________________
rem renew internet protocol
ipconfig /renew >> log.txt

( 
echo ________________________________________________________________________________
echo Windows Shockets API :
) >> log.txt 

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
echo   Hardware Check        [Done]
echo   Domain Name Server    [Done]
echo   Internet Protocol     [Done]
echo   Windows Shockets API  [Reset]
echo   Hosts File            [-]
echo   Adware Cleaner        [-]
echo   Connection Test       [-]                 
echo.
echo ________________________________________________________________________________
rem run windows shocket reset
netsh winsock reset >> log.txt

( 
echo ________________________________________________________________________________
echo Host File Issue :
) >> log.txt 

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
echo   Hardware Check        [Done]
echo   Domain Name Server    [Done]
echo   Internet Protocol     [Done]
echo   Windows Shockets API  [Done]
echo   Hosts File            [Update]
echo   Adware Cleaner        [-]
echo   Connection Test       [-]                 
echo.
echo ________________________________________________________________________________
rem get hosts file and overwrite system hosts file
powershell -command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts.sfw', '%SystemRoot%\System32\Drivers\etc\hosts')" >> log.txt

( 
echo ________________________________________________________________________________
echo Adware Cleaner Result :
) >> log.txt 

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
echo   Hardware Check        [Done]
echo   Domain Name Server    [Done]
echo   Internet Protocol     [Done]
echo   Windows Shockets API  [Done]
echo   Hosts File            [Done]
echo   Adware Cleaner        [Scan]
echo   Connection Test       [-]                 
echo.
echo ________________________________________________________________________________
rem accept adware cleaner eula
bin\adwcleaner.exe /eula
rem run adware cleaner with auto clean and dont reboot
bin\adwcleaner.exe /clean /noreboot >> log.txt

( 
echo ________________________________________________________________________________
echo Ping Result :
) >> log.txt 

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
echo   Hardware Check        [Done]
echo   Domain Name Server    [Done]
echo   Internet Protocol     [Done]
echo   Windows Shockets API  [Done]
echo   Hosts File            [Done]
echo   Adware Cleaner        [Done]
echo   Connection Test       [Ping Test]                 
echo.
echo ________________________________________________________________________________
rem test ping 
ping %server% >> log.txt

( 
echo ________________________________________________________________________________
echo Speedtest Result :
) >> log.txt 

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
echo   Hardware Check        [Done]
echo   Domain Name Server    [Done]
echo   Internet Protocol     [Done]
echo   Windows Shockets API  [Done]
echo   Hosts File            [Done]
echo   Adware Cleaner        [Done]
echo   Connection Test       [Speed Test]                 
echo.
echo ________________________________________________________________________________
rem clean run speedtest and accept license
bin\speedtest.exe --accept-license >> log.txt

( 
echo ________________________________________________________________________________
) >> log.txt 

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
echo   Hardware Check        [Collect]
echo   Domain Name Server    [-]
echo   Internet Protocol     [-]
echo   Windows Shockets API  [-]
echo   Hosts File            [-]
echo   Adware Cleaner        [-]
echo   Connection Test       [-]                 
echo.
echo ________________________________________________________________________________
echo.
echo                           Report Generated in "log.txt"
echo                           Please Restart Your PC
echo                           Press "Enter" to Exit

rem clean memory
%windir%\system32\rundll32.exe advapi32.dll,ProcessIdleTasks
rem show complete dialog
bin\msg.vbs

pause >nul 
exit