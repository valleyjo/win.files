@echo off

:instChocolatey
  if exist C:\Chocolatey\nul goto :instGit
  echo
  echo ----- Installing Chocolatey -----
  @powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%systemdrive%\chocolatey\bin

:instGit
  if exist "C:\Program Files (x86)\Git\nul" goto :dev
  echo
  echo ----- Installing Git-----
  cinst git

:dev
  if exist C:\dev\nul goto :clone
  echo
  echo ----- Making Local Dev Directory (c:\dev) -----
  mkdir C:\dev

:clone
  if exist c:\dev\win.files goto :runSetup
  echo
  echo ----- Cloneing win.files -----
  path=%path%;C:\Program Files (x86)\Git\bin
  git clone https://github.com/valleyjo/win.files.git c:\dev\win.files

:runSetup
  echo
  echo ----- Running Initial Setup -----
  C:\dev\win.files\setup.cmd

:eof
