@echo off
title Directory Nuke

:: Get the directory where the script is located
set "current_dir=%~dp0"

:: Confirm deletion
echo WARNING: This will delete all files and subdirectories in %current_dir%
echo Are you sure you want to continue? (y/n)
set /p confirmation=

if /i not "%confirmation%"=="y" (
    echo Operation cancelled.
    exit /b
)

:: Delete all files and directories in the current directory
del /s /q "%current_dir%\*.*"
rmdir /s /q "%current_dir%\*"

echo All files and directories have been deleted.
pause
