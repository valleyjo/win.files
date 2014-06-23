@echo off

:: --------------------
:: Initialize Variables
:: --------------------
set dotfiles=C:\dev\win.files
set sublime="C:\Program Files\Sublime Text 2\sublime_text.exe"

:: --------------------
:: Augment the Path
::  += local dev dir
::  += dotfiles dir
:: --------------------
path=%path%;C:\dev;%dotfiles%

:: --------------------
:: Prompt Settings
::  ex: 03:50:12.34 | Sun 12/03/1992 | C:\Default\Start\Dir
:: --------------------
prompt $T$S$B$S$D$S$B$S$P$G

:: --------------------
:: Aliases
:: --------------------
doskey cd=chdir $*
doskey ls=dir /w $*
doskey cs=cd $* $t dir /w
doskey subl=%sublime% $*
doskey fs=findstr /s /p /i /n $* *
doskey ll=ls /a

:: Copy present working directory to the clipboard
doskey cpwd=echo %cd% $b clip

:: --------------------
:: Wizmo Aliases
::  Wizmo is a sweet CLI tool for windows. It let's you do all kinda crazy things
::  URL: https://www.grc.com/wizmo/wizmo.htm
:: --------------------
:: Start screensaver (locks the screen too on win 8+)
doskey lock=wizmo blank

:: default flags for The Silver Searcher
doskey ag=ag -p %dotfiles\.agignore -s $*

:: --------------------
:: Easy directory traversal
:: --------------------
doskey .=cd ..\ $t dir /w
doskey ..=cd ..\.. $t dir /w
doskey ...=cd ..\..\.. $t dir /w
doskey ....=cd ..\..\..\.. $t dir /w
doskey .....=cd ..\..\..\..\.. $t dir /w
