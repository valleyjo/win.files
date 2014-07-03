@echo off

:instChocolatey
	if exist C:\Chocolatey\nul goto :install
	echo \n----- Installing Chocolatey -----
	@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%systemdrive%\chocolatey\bin

:install
    echo %installedPrograms%|findstr /i git >nul:
    if %errorlevel%==0 goto :clone
	echo \n----- Installing Git-----
	cinst git

:dev
	IF EXIST C:\dev\nul goto :instGit
	echo \n----- Making Local Dev Directory (c:\dev) -----
	mkdir C:\dev

:clone
	if exist c:\dev\win.files goto :runSetup
	echo \n----- Cloneing win.files -----
	path=%path%;C:\Program Files (x86)\Git\bin
	git clone https://github.com/valleyjo/win.files.git c:\dev\win.files

:runSetup
	echo \n----- Running Initial Setup -----
	C:\dev\win.files\install.cmd

:eof
