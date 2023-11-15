@echo off
rem run as admin
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
rem back to original batch directory
cd /d %~dp0

rem ----------------- test field -----------------


call :MsgBox "Would you like to go to URL?"  "VBYesNo+VBQuestion" "Click yes to go to URL"
  if errorlevel 7 (
      echo NO - don't go to the url
  ) else if errorlevel 6 (
      echo YES - go to the url
      start "" "http://www.google.com"
  )

  exit /b


:MsgBox prompt type title
  echo WScript.Quit msgBox("%~1",%~2,"%~3") >"%~dp0\bin\tmp" 
  cscript //nologo //e:vbscript "%~dp0\bin\tmp"
  set "exitCode=%errorlevel%" & del "%~dp0\bin\tmp" >nul 2>nul
  endlocal & exit /b %exitCode%

rem ----------------- end field -----------------

pause