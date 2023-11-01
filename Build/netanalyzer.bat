@echo off
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
cd /d %~dp0

attrib -h "bin\completed.vbs"

set header=Net Analyzer 1.5 - https://github.com/ranggirahman
title %header%
set server=8.8.8.8

cls
Echo.
Echo                           %header%
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [-]
echo                           Internet Protocol     [-]
echo                           Windows Shockets API  [-]
echo                           Hosts File            [-]
echo                           Ping Test             [-]
echo                           Speed Test            [-]                          
echo.
echo ________________________________________________________________________________
echo.
echo                           Press "Enter" to Start
pause >nul
del log.txt 
( 
echo %header% 
echo Time : %time:~,5%, %date%
echo ________________________________________________________________________________
echo Hardware Info :
) > log.txt 

systeminfo >> log.txt

( 
echo ________________________________________________________________________________
echo Domain Name Server :
) >> log.txt 

cls
Echo.
Echo                           %header%
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [Flush]
echo                           Internet Protocol     [-]
echo                           Windows Shockets API  [-]
echo                           Hosts File            [-]
echo                           Ping Test             [-]
echo                           Speed Test            [-]                              
echo.
echo ________________________________________________________________________________
ipconfig /flushdns >> log.txt

cls
Echo.
Echo                           %header%
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [Register]
echo                           Internet Protocol     [-]
echo                           Windows Shockets API  [-]
echo                           Hosts File            [-]
echo                           Ping Test             [-]
echo                           Speed Test            [-]                              
echo.
echo ________________________________________________________________________________
ipconfig /registerdns >> log.txt

( 
echo ________________________________________________________________________________
echo Internet Protocol :
) >> log.txt

cls
Echo.
Echo                           %header%
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [Done]
echo                           Internet Protocol     [Release]
echo                           Windows Shockets API  [-]
echo                           Hosts File            [-]
echo                           Ping Test             [-]
echo                           Speed Test            [-]                           
echo.
echo ________________________________________________________________________________
ipconfig /release >> log.txt

cls
Echo.
Echo                           %header%
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [Done]
echo                           Internet Protocol     [Renew]
echo                           Windows Shockets API  [-]
echo                           Hosts File            [-]
echo                           Ping Test             [-]
echo                           Speed Test            [-]                            
echo.
echo ________________________________________________________________________________
ipconfig /renew >> log.txt

( 
echo ________________________________________________________________________________
echo Windows Shockets API :
) >> log.txt 

cls
Echo.
Echo                           %header%
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [Done]
echo                           Internet Protocol     [Done]
echo                           Windows Shockets API  [Reset]
echo                           Hosts File            [-]
echo                           Ping Test             [-]
echo                           Speed Test            [-]                             
echo.
echo ________________________________________________________________________________
netsh winsock reset >> log.txt

cls
Echo.
Echo                           %header%
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [Done]
echo                           Internet Protocol     [Done]
echo                           Windows Shockets API  [Done]
echo                           Hosts File            [Update]
echo                           Ping Test             [-]
echo                           Speed Test            [-]                             
echo.
echo ________________________________________________________________________________
powershell -command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts.sfw', '%SystemRoot%\System32\Drivers\etc\hosts')"

( 
echo ________________________________________________________________________________
echo Ping Result :
) >> log.txt 

cls
Echo.
Echo                           %header%
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [Done]
echo                           Internet Protocol     [Done]
echo                           Windows Shockets API  [Done]
echo                           Hosts File            [Done]
echo                           Ping Test             [Sent]
echo                           Speed Test            [-]                             
echo.
echo ________________________________________________________________________________
ping %server% >> log.txt

( 
echo ________________________________________________________________________________
echo Speedtest Result :
) >> log.txt 

cls
Echo.
Echo                           %header%
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [Done]
echo                           Internet Protocol     [Done]
echo                           Windows Shockets API  [Done]
echo                           Hosts File            [Done]
echo                           Ping Test             [Done]
echo                           Speed Test            [Running]                        
echo.
echo ________________________________________________________________________________
bin\speedtest.exe --accept-license >> log.txt

( 
echo ________________________________________________________________________________
) >> log.txt 

cls
Echo.
Echo                           %header%
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [Done]
echo                           Internet Protocol     [Done]
echo                           Windows Shockets API  [Done]
echo                           Hosts File            [Done]
echo                           Ping Test             [Done]
echo                           Speed Test            [Done]                             
echo.
echo ________________________________________________________________________________
echo.
echo                           Report Generated in "log.txt"
echo                           Please Restart Your PC
echo                           Press "Enter" to Exit

echo.>"bin\completed.vbs" lol=msgbox ("All Process is Complete",64,"Net Analyzer")
attrib +h "bin\completed.vbs"
bin\completed.vbs


pause >nul 