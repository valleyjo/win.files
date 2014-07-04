::@echo off

if not exist c:\dev\win.files\nul goto :error
set dotfiles=C:\dev\win.files

:UpdateSettings
  chdir c:\dev\win.files

  :: ConEmu
  del %AppData%\ConEmu.xml
  copy %dotfiles%\ConEmu.xml %AppData%\ConEmu.xml

  :: Console2
  if exist %AppData%\Console2\console.xml del %AppData%\Console2\console.xml
  copy %dotfiles%\ConEmu.xml %AppData%\Console2\console.xml

  :: Git
  if exist %userprofile%\.gitconfig del %userprofile%\.gitconfig
  copy %dotfiles%\.gitconfig %userprofile%\.gitconfig

  :: Vim
  if exist %userprofile%\_vimrc del %userprofile$\_vimrc
  copy %dotfiles%\_vimrc %userprofile%\_vimrc
  if exist %userprofile%\_vimrc del %userprofile%\vimfiles
  copy %dotfiles%\vimfiles %userprofile%\vimfiles

:InstallSoftware
::  cinst packages.config

::InstallVimPlugins
::  git clone https://github.com/vim-scripts/Align.git
::  git clone https://github.com/jeffkreeftmeijer/vim-numbertoggle.git

:RepoMissingError
  echo \n---------- Error ----------
  echo win.files repo not found (c:\dev\win.files)
  echo Please run first_run.cmd first

:eof

