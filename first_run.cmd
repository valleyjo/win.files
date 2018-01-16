@echo off

net.exe session 1>NUL 2>NUL || (Echo This script requires elevated rights. & pause & Exit /b 1)

:instChocolatey
  if exist %ProgramData%\chocolatey\nul goto :instGit
  if exist C:\Chocolatey\nul goto :instGit
  echo
  echo ----- Installing Chocolatey -----
  @powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ProgramData%\chocolatey\bin

:instGit
  if exist "C:\Program Files (x86)\Git\nul" goto :dev
  echo
  echo ----- Installing Git-----
  cinst --confirm git

:dev
  if exist C:\dev\nul goto :clone
  echo
  echo ----- Making Local Dev Directory (c:\dev) -----
  mkdir C:\dev

:clone
  if exist c:\dev\win.files goto :runSetup
  echo
  echo ----- Cloneing win.files -----
  "c:\program files\git\cmd\git.exe" clone https://github.com/valleyjo/win.files.git c:\dev\win.files

:runSetup
  echo
  echo ----- Running Initial Setup -----
  cinst --confirm C:\dev\win.files\packages.config && C:\dev\win.files\setup.cmd

:eof
