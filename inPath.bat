@echo off
:inPath pathVar
::
::  Tests if the path stored within variable pathVar exists within PATH.
::
::  The result is returned as the ERRORLEVEL:
::    0 if the pathVar path is found in PATH.
::    1 if the pathVar path is not found in PATH.
::    2 if pathVar is missing or undefined or if PATH is undefined.
::
::  If the pathVar path is fully qualified, then it is logically compared
::  to each fully qualified path within PATH. The path strings don't have
::  to match exactly, they just need to be logically equivalent.
::
::  If the pathVar path is relative, then it is strictly compared to each
::  relative path within PATH. Case differences and double quotes are
::  ignored, but otherwise the path strings must match exactly.
::
::------------------------------------------------------------------------
::
:: Error checking
if "%~1"=="" exit /b 2
if not defined %~1 exit /b 2
if not defined path exit /b 2
::
:: Prepare to safely parse PATH into individual paths
setlocal DisableDelayedExpansion
set "var=%path:"=""%"
set "var=%var:^=^^%"
set "var=%var:&=^&%"
set "var=%var:|=^|%"
set "var=%var:<=^<%"
set "var=%var:>=^>%"
set "var=%var:;=^;^;%"
set var=%var:""="%
set "var=%var:"=""Q%"
set "var=%var:;;="S"S%"
set "var=%var:^;^;=;%"
set "var=%var:""="%"
setlocal EnableDelayedExpansion
set "var=!var:"Q=!"
set "var=!var:"S"S=";"!"
::
:: Remove quotes from pathVar and abort if it becomes empty
set "new=!%~1:"=!"
if not defined new exit /b 2
::
:: Determine if pathVar is fully qualified
echo("!new!"|findstr /i /r /c:^"^^\"[a-zA-Z]:[\\/][^\\/]" ^
                           /c:^"^^\"[\\][\\]" >nul ^
  && set "abs=1" || set "abs=0"
::
:: For each path in PATH, check if path is fully qualified and then do
:: proper comparison with pathVar.
:: Exit with ERRORLEVEL 0 if a match is found.
:: Delayed expansion must be disabled when expanding FOR variables
:: just in case the value contains !
for %%A in ("!new!\") do for %%B in ("!var!") do (
  if "!!"=="" endlocal
  for %%C in ("%%~B\") do (
    echo(%%B|findstr /i /r /c:^"^^\"[a-zA-Z]:[\\/][^\\/]" ^
                           /c:^"^^\"[\\][\\]" >nul ^
      && (if %abs%==1 if /i "%%~sA"=="%%~sC" exit /b 0) ^
      || (if %abs%==0 if /i "%%~A"=="%%~C" exit /b 0)
  )
)
:: No match was found so exit with ERRORLEVEL 1
exit /b 1