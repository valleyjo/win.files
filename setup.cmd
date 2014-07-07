@echo off

if not exist c:\dev\win.files\nul goto :error
set dotfiles=C:\dev\win.files

:InstallSoftware
  cinst packages.config

:UpdateSettings
  chdir c:\dev\win.files

  :: ConEmu
  copy /y %dotfiles%\ConEmu.xml "C:\Program Files\ConEmu\ConEmu.xml"

  :: Console2
  robocopy %dotfiles%\Console2 %AppData%\Console2 /MIR /njh /njs /ndl /nc /ns

  :: Git
  copy /y %dotfiles%\.gitconfig %userprofile%\.gitconfig

  :: Vim
  copy /y %dotfiles%\_vimrc %userprofile%\_vimrc
  robocopy %dotfiles%\vimfiles %userprofile%\vimfiles /MIR /njh /njs /ndl /nc /ns

  :: Dexpot
  robocopy %dotfiles%\Dexpot %AppData%\Dexpot /MIR /njh /njs /ndl /nc /ns

:ModifyRegistry
  regedit /S swap_caps_lock_and_control.reg

:InstallVimPlugins
::  git clone https://github.com/vim-scripts/Align.git
  git clone https://github.com/jeffkreeftmeijer/vim-numbertoggle.git %UserProfile%\vimfiles\plugin\vim-numbertoggle

goto :eof

:RepoMissingError
  echo
  echo ---------- Error ----------
  echo win.files repo not found (c:\dev\win.files)
  echo Please run first_run.cmd first

:eof

