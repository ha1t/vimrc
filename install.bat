@echo off
chcp 65001

mklink /D %USERPROFILE%\.vim %USERPROFILE%\Documents\GitHub\vimrc\vim
IF EXIST "%USERPROFILE%\.vim" (
    mkdir "%USERPROFILE%\.vim\backup"
)
mklink %USERPROFILE%\.vimrc %USERPROFILE%\Documents\GitHub\vimrc\vimrc
pause

