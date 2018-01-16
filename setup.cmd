@echo off

net.exe session 1>NUL 2>NUL || (Echo This script requires elevated rights. & pause & Exit /b 1)

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
  ::copy /y %dotfiles%\notepad++\config.xml %AppData%\notepad++\
  ::copy /y %dotfiles%\notepad++\obsidian.xml %AppData%\notepad++\themes\

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

  :: Command Prompt shortcut
  copy /y "%dotfiles%\Command Prompt.lnk" %userprofile%\desktop\

  :: VS Code setup
  copy /y "%dotfiles%\vscode_settings.json" %appdata%\Code\User\Settings.json
  start "install powershell" "%programfiles%\Microsoft VS Code\Code.exe" "--install-extension ms-vscode.powershell"
  start "install cpptools" "%programfiles%\Microsoft VS Code\Code.exe" "--install-extension ms-vscode.cpptools"
  start "install c#" "%programfiles%\Microsoft VS Code\Code.exe" "--install-extension ms-vscode.csharp"
  start "install vscode_vim" "%programfiles%\Microsoft VS Code\Code.exe" "--install-extension vscodevim.vim"

  :: source code pro fonts
  copy /y %dotfiles%\source_code_pro\SourceCodePro-Bold.ttf %windir%\Fonts
  copy /y %dotfiles%\source_code_pro\SourceCodePro-Black.ttf %windir%\Fonts
  copy /y %dotfiles%\source_code_pro\SourceCodePro-Light.ttf %windir%\Fonts
  copy /y %dotfiles%\source_code_pro\SourceCodePro-Medium.ttf %windir%\Fonts
  copy /y %dotfiles%\source_code_pro\SourceCodePro-Regular.ttf %windir%\Fonts
  copy /y %dotfiles%\source_code_pro\SourceCodePro-Semibold.ttf %windir%\Fonts
  copy /y %dotfiles%\source_code_pro\SourceCodePro-ExtraLight.ttf %windir%\Fonts

:powershell
  powershell -Command "new-item $profile -force -type File"
  powershell -Command "cp %dotfiles%\Microsoft.PowerShell_profile.ps1 $profile"

:ModifyRegistry
  regedit /S caps_lock_to_control.reg
  regedit /S paint_desktop_version.reg
  regedit /S source_code_pro.reg
  regedit /S windbg_workspaces.reg
  regedit /S key_repeat.reg

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
