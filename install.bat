@echo off
chcp 65001

echo Vim.exeのパスを確認します...
where vim
if %errorlevel% neq 0 (
    echo.
    echo ❌ Vim.exeのパスは通っていません。
    echo.
    call :CreateSymlink "CorvusSKK\userdict.txt" "%USERPROFILE%\bin\vim.exe"
) else (
    echo.
    echo ✅ Vim.exeのパスは正常に通っています。
)
echo.

mklink /D %USERPROFILE%\.vim %USERPROFILE%\Documents\GitHub\vimrc\vim
IF EXIST "%USERPROFILE%\.vim" (
    mkdir "%USERPROFILE%\.vim\backup"
)
mklink %USERPROFILE%\.vimrc %USERPROFILE%\Documents\GitHub\vimrc\vimrc
pause

