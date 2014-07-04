@echo off

if not exist c:\dev\win.files\nul goto :error
set dotfiles=C:\dev\win.files

:UpdateSettings
  chdir c:\dev\win.files

  :: ConEmu
  copy /y %dotfiles%\ConEmu.xml %AppData%\ConEmu.xml

  :: Console2
  robocopy %dotfiles%\Console2 %AppData%\Console2 /MIR

  :: Git
  copy /y %dotfiles%\.gitconfig %userprofile%\.gitconfig

  :: Vim
  copy /y %dotfiles%\_vimrc %userprofile%\_vimrc
  robocopy %dotfiles%\vimfiles %userprofile%\vimfiles /MIR

:InstallSoftware
::  cinst packages.config

::InstallVimPlugins
::  git clone https://github.com/vim-scripts/Align.git
::  git clone https://github.com/jeffkreeftmeijer/vim-numbertoggle.git

goto :eof

:RepoMissingError
  echo \n---------- Error ----------
  echo win.files repo not found (c:\dev\win.files)
  echo Please run first_run.cmd first

:eof

