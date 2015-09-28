@echo off

:: Startup directory
chdir C:\

:: --------------------
:: Initialize Variables
:: --------------------
set dotfiles=C:\dev\win.files
set sublime="C:\Program Files\Sublime Text 2\sublime_text.exe"

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
doskey cd=pushd $*
doskey ls=dir /d $*
doskey cs=pushd $* $t dir /w
doskey subl=%sublime% $*
doskey fs=findstr /s /p /i /n $* *
doskey ll=ls /a $*
doskey devd=cd C:\dev\win.files
doskey t=type $*
doskey v=vim $*
doskey o=explorer .
doskey home=pushd %userprofile%

:: Copy present working directory to the clipboard
doskey ccd=echo %cd% $b clip

:: --------------------
:: Git Aliases
:: --------------------
doskey gap=git add -p
doskey gaa=git add --all
doskey gcm=git commit -m $*
doskey gg=git status
doskey gp=git push
doskey gl=git pull

:: --------------------
:: Wizmo Aliases
::  Wizmo is a sweet CLI tool for windows. It let's you do all kinda crazy things
::  URL: https://www.grc.com/wizmo/wizmo.htm
:: --------------------
:: Start screensaver (locks the screen too on win 8+)
doskey lock=wizmo blank

:: default flags for The Silver Searcher
doskey agdf=ag -p %dotfiles\.agignore -s $*

:: --------------------
:: Easy directory traversal
:: --------------------
doskey .=cd ..\ $t dir /w
doskey ..=cd ..\.. $t dir /w
doskey ...=cd ..\..\.. $t dir /w
doskey ....=cd ..\..\..\.. $t dir /w
doskey .....=cd ..\..\..\..\.. $t dir /w
