@echo off

if not exist c:\dev\win.files\nul goto :RepoMissingError
set dotfiles=C:\dev\win.files

:: set global variables
setx h %userprofile%
setx d %userprofile%\desktop\

:UpdateSettings
  chdir c:\dev\win.files

  :: ConEmu
  ::reg import ConEmu.reg

  :: Console2
  robocopy %dotfiles%\Console2 %AppData%\Console2 /MIR /njh /njs /ndl /nc /ns
  robocopy %dotfiles%\Console2 %AppData%\Console /MIR /njh /njs /ndl /nc /ns

  :: Notepad++
  copy /y %dotfiles%\notepad++\config.xml %AppData%\notepad++\
  copy /y %dotfiles%\notepad++\obsidian.xml %AppData%\notepad++\themes\

  :: Git
  copy /y %dotfiles%\gitconfig.txt %userprofile%\.gitconfig

  :: Vim
  copy /y %dotfiles%\_vimrc %userprofile%\_vimrc
  robocopy %dotfiles%\vimfiles %userprofile%\vimfiles /MIR /njh /njs /ndl /nc /ns

  :: VsVim
  copy /y %dotfiles%\_vsvimrc %userprofile%\_vsvimrc

  :: gvim
  copy /y %dotfiles%\.gvimrc %userprofile%\.gvimrc

  :: sublime
  copy /y %dotfiles%\Preferences.sublime-settings "%appdata%\Sublime Text 3\packages\user\preferences.sublime-settings"

:ModifyRegistry
  regedit /S caps_lock_to_control.reg
  regedit /S paint_desktop_version.reg
  regedit /S source_code_pro_in_console.reg

:InstallVimPlugins
:: git clone https://github.com/vim-scripts/Align.git
  "c:\program files\git\cmd\git.exe" clone https://github.com/jeffkreeftmeijer/vim-numbertoggle.git %UserProfile%\vimfiles\plugin\vim-numbertoggle

goto :eof

:RepoMissingError
  echo
  color 4
  echo ---------- Error ----------
  color
  echo win.files repo not found (c:\dev\win.files)
  echo Please run first_run.cmd first

:eof
