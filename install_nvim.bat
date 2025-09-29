@echo off
chcp 65001

mklink /D %LOCALAPPDATA%\nvim %USERPROFILE%\Documents\GitHub\vimrc\nvim
pause

