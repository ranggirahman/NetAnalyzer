@echo off
rem run as admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
rem back to original batch directory
cd /d %~dp0

rem ----------------- test field -----------------



@REM ping 8.8.8.8 -n 1 -w 1000 > nul

@REM if errorlevel 1 (
@REM   echo Not Connected
@REM ) else (
@REM   echo Connected
@REM )

@REM powershell -command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts.sfw', '%~dp0\bin\host\host-download')
@REM fc bin\host\host-download %SystemRoot%\System32\Drivers\etc\hosts > nul
@REM if errorlevel 1 (
@REM   echo Not Same
@REM ) else (
@REM   echo Same
@REM )


Rem | Configuration
Set "MainDirectory=%~dp0\bin\AdwCleaner\Logs"
Set "FileExtension=*.txt"
Set "CopyDestination=%~dp0"

Rem | Search for the newest file in a directory/sub-directory
for /f "tokens=*" %%A in ('DIR "%MainDirectory%\%FileExtension%" /B /S /O:D') do (SET "NewestFile=%%A")

Rem | Copy file to a destination
echo "%NewestFile%"



rem ----------------- end field -----------------

pause