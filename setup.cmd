@echo off

if not exist c:\dev\win.files\nul goto :error

:UpdateSettings
	chdir c:\dev\win.files
	:: ConEmu
	del %AppData%\ConEmu.xml
	move ConEmu.xml %AppData%\ConEmu.xml
	:: Git
	del %userprofile%\.gitconfig
	move .gitconfig %userprofile%\.gitconfig
	:: Vim
	del %userprofile$\_vimrc
	move _vimrc %userprofile%\_vimrc
	del %userprofile%\vimfiles
	move vimfiles %userprofile%\vimfiles

:InstallSoftware
	cinst software_setup.xml

:RepoMissingError
	echo \n---------- Error ----------
	echo win.files repo not found (c:\dev\win.files)
	echo Please run first_run.cmd first

:eof