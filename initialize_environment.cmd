@echo off
:: Startup directory
chdir %userprofile%

:: --------------------
:: Initialize Variables
:: --------------------
set dotfiles=C:\dev\win.files
set sublime="%programfiles%\Sublime Text 3\sublime_text.exe"
set pad="C:\Program Files (x86)\Notepad++\notepad++.exe"

:: --------------------
:: Augment the Path
::  += local dev dir
::  += dotfiles dir
::  += git dir
:: --------------------
path=%path%;C:\dev;%dotfiles%;%ProgramFiles(x86)%\Git\cmd;

:: --------------------
:: Prompt Settings
::  ex: 03:50:12.34 | Sun 12/03/1992 | Directory Stack: +++
::      c:\Default\Start\Dir
:: --------------------
prompt $T$S$B$S$D$S$B$SDirectory$SStack:$S$+$_$P$G

:: --------------------
:: Aliases
:: --------------------
doskey cd=chdir $*
doskey ls=dir /d $*
doskey cs=pushd $* $t dir /d
doskey p=pushd $*
::doskey b=popd $* $t dir /d
doskey subl=%sublime% $*
doskey pad=%pad% $*
doskey fs=findstr /s /p /i /n $* *
doskey ll=ls /a $*
doskey devd=cd C:\dev\
doskey t=type $*
doskey v=vim $*
doskey o=explorer .
doskey home=pushd %userprofile%
doskey h=pushd %userprofile%
doskey desktop=pushd %userprofile%\desktop\
doskey d=pushd %userprofile%\desktop\
doskey bginfo=c:\dev\bginfo.exe c:\dev\bginfo.bgi /nolicprompt /timer:00

:: Copy present working directory to the clipboard
doskey ccd=powershell -c "(get-location).ToString()|Set-Clipboard"

:: --------------------
:: Git Aliases
:: --------------------
doskey gap=git add -p
doskey gaa=git add --all
doskey gcm=git commit -m $*
doskey gg=git status
doskey gp=git push
doskey gl=git pull --prune
doskey glog=git log --graph --pretty=format:"%%Cred%%h %%Creset %%an: %%s - %%Cgreen%%cr %%Creset" --abbrev-commit --date=relative $*
doskey gloga=git log --graph --pretty=format:"%%Cred%%h %%Creset %%an: %%s - %%Cgreen%%cr %%Creset" --abbrev-commit --date=relative --author=$*

:: --------------------
:: Easy directory traversal
:: --------------------
doskey .=cd ..\ $t dir /w
doskey ..=cd ..\.. $t dir /w
doskey ...=cd ..\..\.. $t dir /w
doskey ....=cd ..\..\..\.. $t dir /w
doskey .....=cd ..\..\..\..\.. $t dir /w
