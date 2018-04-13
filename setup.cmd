@echo off

:: only run if we are in admin mode
net.exe session 1>NUL 2>NUL || (Echo This script requires elevated rights. & pause & Exit /b 1)

if not exist c:\dev\win.files\nul goto :RepoMissingError
set dotfiles=C:\dev\win.files
set powershellprofiledir=%userprofile%\documents\WindowsPowershell

:: set global variables
setx h %userprofile%
setx d %userprofile%\desktop\

:UpdateSettings
  chdir c:\dev\win.files

  :: ConEmu
  ::reg import ConEmu.reg

  :: Console2
  mklink /J %appdata%\Console %dotfiles%\Console2
  mklink /J %appdata%\Console2 %dotfiles%\Console2

  :: Notepad++
  mklink /J %appdata%\notepad++ %dotfiles%\notepad++

  :: Git
  mklink %h%\.gitconfig %dotfiles%\gitconfig.txt

  :: Vim
  mklink %h%\_vimrc %dotfiles%\_vimrc
  mklink /J %h%\vimfiles %dotfiles%\vimfiles

  :: VsVim
  mklink %h%\_vsvimrc %dotfiles%\_vsvimrc

  :: gvim
  mklink %h%\.gvimrc %dotfiles\.gvimrc

  :: sublime
  if not exist "%appdata%\Sublime Text 3\packages\user\" mkdir "%appdata%\Sublime Text 3\packages\user"
  mklink "%appdata%\Sublime Text 3\packages\user\preferences.sublime-settings" %dotfiles%\Preferences.sublime-settings 

  :: Command Prompt shortcut (symlink-ing a .lnk is weird so do a regular copy)
  copy /y "%dotfiles%\Command Prompt.lnk" %h%\desktop\

  :: VS Code setup
  if not exist %appdata%\Code\User mkdir %appdata%\Code\User
  mklink %appdata%\Code\User\Settings.json %dotfiles%\vscode_settings.json
  code "--install-extension ms-vscode.powershell"
  code "--install-extension ms-vscode.cpptools"
  code "--install-extension ms-vscode.csharp"
  code "--install-extension vscodevim.vim"

  :: source code pro fonts (don't expect these to change so we can leave a copy here)
  copy /y %dotfiles%\source_code_pro\SourceCodePro-Bold.ttf %windir%\Fonts
  copy /y %dotfiles%\source_code_pro\SourceCodePro-Black.ttf %windir%\Fonts
  copy /y %dotfiles%\source_code_pro\SourceCodePro-Light.ttf %windir%\Fonts
  copy /y %dotfiles%\source_code_pro\SourceCodePro-Medium.ttf %windir%\Fonts
  copy /y %dotfiles%\source_code_pro\SourceCodePro-Regular.ttf %windir%\Fonts
  copy /y %dotfiles%\source_code_pro\SourceCodePro-Semibold.ttf %windir%\Fonts
  copy /y %dotfiles%\source_code_pro\SourceCodePro-ExtraLight.ttf %windir%\Fonts

:ModifyRegistry
  regedit /S caps_lock_to_control.reg
  regedit /S paint_desktop_version.reg
  regedit /S source_code_pro.reg
  regedit /S windbg_workspaces.reg
  regedit /S key_repeat.reg

:powershell
  powershell -Command "Set-ExecutionPolicy Unrestricted -Force"
  :: make the directory where powershell profiles live then hardlink the profile
  if not exist %powershellprofiledir% mkdir %powershellprofiledir%
  mklink /H %powershellprofiledir%\Microsoft.PowerShell_profile.ps1 %dotfiles%\Microsoft.PowerShell_profile.ps1
  mklink /H %powershellprofiledir%\Microsoft.VSCode_profile.ps1 %dotfiles%\Microsoft.PowerShell_profile.ps1

:InstallVimPlugins
:: git clone https://github.com/vim-scripts/Align.git
:: "c:\program files\git\cmd\git.exe" clone https://github.com/jeffkreeftmeijer/vim-numbertoggle.git %UserProfile%\vimfiles\plugin\vim-numbertoggle

goto :eof

:RepoMissingError
  echo
  color 4
  echo ---------- Error ----------
  color
  echo win.files repo not found (c:\dev\win.files)
  echo Please run first_run.cmd first

:eof
