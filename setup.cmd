@echo off

if not exist c:\dev\win.files\nul goto :RepoMissingError
set dotfiles=C:\dev\win.files

:UpdateSettings
  chdir c:\dev\win.files

  :: ConEmu
  :: prefer ethan brown config over my own customized config
  ::copy /y %dotfiles%\ConEmu.xml "C:\Program Files\ConEmu\ConEmu.xml"

  :: Console2
  robocopy %dotfiles%\Console2 %AppData%\Console2 /MIR /njh /njs /ndl /nc /ns
  robocopy %dotfiles%\Console2 %AppData%\Console /MIR /njh /njs /ndl /nc /ns

  :: Git
  copy /y %dotfiles%\.gitconfig %userprofile%\.gitconfig

  :: Vim
  copy /y %dotfiles%\_vimrc %userprofile%\_vimrc
  robocopy %dotfiles%\vimfiles %userprofile%\vimfiles /MIR /njh /njs /ndl /nc /ns

  :: VsVim
  copy /y %dotfiles%\_vsvimrc %userprofile%\_vsvimrc

  :: Dexpot
  robocopy %dotfiles%\Dexpot %AppData%\Dexpot /MIR /njh /njs /ndl /nc /ns

:ModifyRegistry
  regedit /S caps_lock_to_control.reg

:InstallVimPlugins
::  git clone https://github.com/vim-scripts/Align.git
  git clone https://github.com/jeffkreeftmeijer/vim-numbertoggle.git %UserProfile%\vimfiles\plugin\vim-numbertoggle

goto :eof

:RepoMissingError
  echo
  color 4
  echo ---------- Error ----------
  color
  echo win.files repo not found (c:\dev\win.files)
  echo Please run first_run.cmd first

:eof
