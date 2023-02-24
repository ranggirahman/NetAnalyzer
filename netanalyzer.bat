@echo off
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
cd %~dp0

attrib -h "completed.vbs"

title Net Analyzer - https://github.com/ranggirahman

cls
Echo.
Echo                           Net Analyzer 1.4 
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [-]
echo                           Internet Protocol     [-]
echo                           Windows Shockets API  [-]
echo                           Ping Test             [-]
echo                           Speed Test            [-]                          
echo.
echo ________________________________________________________________________________
echo.
echo                           Press "Enter" to Start
pause >nul
del log.txt 
( 
echo Net Analyzer 1.4 Report : %time:~,5%, %date%
) > log.txt 

( 
echo ________________________________________________________________________________
echo Domain Name Server :
) >> log.txt 

cls
Echo.
Echo                           Net Analyzer 1.4 
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [Flush]
echo                           Internet Protocol     [-]
echo                           Windows Shockets API  [-]
echo                           Ping Test             [-]
echo                           Speed Test            [-]                              
echo.
echo ________________________________________________________________________________
ipconfig /flushdns >> log.txt

cls
Echo.
Echo                           Net Analyzer 1.4 
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [Register]
echo                           Internet Protocol     [-]
echo                           Windows Shockets API  [-]
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
Echo                           Net Analyzer 1.4 
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [Done]
echo                           Internet Protocol     [Release]
echo                           Windows Shockets API  [-]
echo                           Ping Test             [-]
echo                           Speed Test            [-]                           
echo.
echo ________________________________________________________________________________
ipconfig /release >> log.txt

cls
Echo.
Echo                           Net Analyzer 1.4 
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [Done]
echo                           Internet Protocol     [Renew]
echo                           Windows Shockets API  [-]
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
Echo                           Net Analyzer 1.4 
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [Done]
echo                           Internet Protocol     [Done]
echo                           Windows Shockets API  [Reset]
echo                           Ping Test             [-]
echo                           Speed Test            [-]                             
echo.
echo ________________________________________________________________________________
netsh winsock reset >> log.txt

( 
echo ________________________________________________________________________________
echo Ping Result :
) >> log.txt 

cls
Echo.
Echo                           Net Analyzer 1.4 
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [Done]
echo                           Internet Protocol     [Done]
echo                           Windows Shockets API  [Done]
echo                           Ping Test             [Sent]
echo                           Speed Test            [-]                             
echo.
echo ________________________________________________________________________________
ping 8.8.8.8 >> log.txt

( 
echo ________________________________________________________________________________
echo Speedtest Result :
) >> log.txt 

cls
Echo.
Echo                           Net Analyzer 1.4 
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [Done]
echo                           Internet Protocol     [Done]
echo                           Windows Shockets API  [Done]
echo                           Ping Test             [Done]
echo                           Speed Test            [Running]                        
echo.
echo ________________________________________________________________________________
speedtest.exe --accept-license >> log.txt

echo.>completed.vbs lol=msgbox ("All Process is Complete",64,"Net Analyzer")
attrib +h "completed.vbs"
completed.vbs

( 
echo ________________________________________________________________________________
) >> log.txt 

cls
Echo.
Echo                           Net Analyzer 1.4 
echo ________________________________________________________________________________
echo.
echo                           Domain Name Server    [Done]
echo                           Internet Protocol     [Done]
echo                           Windows Shockets API  [Done]
echo                           Ping Test             [Done]
echo                           Speed Test            [Done]                             
echo.
echo ________________________________________________________________________________
echo.
echo                           Report Generated in "log.txt"
echo                           Please Restart Your PC
echo                           Press "Enter" to Exit
pause >nul 