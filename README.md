Win.Files
=========

Win Dot Files: Dotfiles for Windows

This repository is a quick and easy way to customize your windows system.

Steps to a great setup:

1. Open [`bootstrap.cmd`](https://raw.githubusercontent.com/valleyjo/win.files/master/bootstrap.cmd)
2. Save as bootstrap.cmd on your desktop
3. Right click and run as administrator

Bootstrapping will symlink individual setup files and create directory junctions for directories. This ensures that changes made will immediatly be available when you sync your repo.

NOTE: Remember that if you changes setting files from the applications themselves you are changing the files in this repository.

A bunch of software is automatically installed, view the packages file to see what is included.

Also included:

1. .gitconfig (be sure to put your own name and email in it)
2. ConEmu and Console2 settings
3. _vimrc
4. .agignore
5. a few vim colorschemes
