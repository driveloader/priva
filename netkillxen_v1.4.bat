@echo off

:: Set script version
set "version=1.4"

:: Configure console
title NetKill v%version%
chcp 65001 >nul
color

:: Request Admin Privileges
:admin
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else (
    goto gotAdmin
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c %~s0", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

if not exist license.ld call :auth
goto main_menu

:main_menu
mode con:cols=120 lines=21
cls
echo                     	[92mNote: The logo may not display correctly, thank you for your understanding :-)[0m
echo 			[91m███    ██ ███████ ████████ ██   ██ ██ ██      ██          ██   ██ [0m
echo 			[91m████   ██ ██         ██    ██  ██  ██ ██      ██           ██ ██  [0m
echo 			[91m██  ██ ██ ███████    ██    █████   ██ ██      ██            ███   [0m
echo 			[91m██  ██ ██ ██         ██    ██  ██  ██ ██      ██           ██ ██  [0m
echo 			[91m██   ████ ███████    ██    ██   ██ ██ ███████ ███████     ██   ██ [0m
echo 				[91mNET[0m[93mSUPPORT[0m SCHOOL CLIENT [91mKILL[0m[93mER[0m - v%version% - By Long Do
echo 		   Original [91mNETKILL[0m script by GWE. Continued and Upgraded by [96mLong Do.[0m
echo.
echo 			======================================================================
echo 							MENU:
echo 			======================================================================
echo 				 		1. Kill NetSupport
echo 						2. Exploit Service
echo 						3. Exploit Undocumented ntdll functions (Experimental)
echo 						4. Instructions
echo 						5. Exit
echo 			======================================================================
echo.
set /p "choice=.   						Choose an option (1-5): "

if "%choice%"=="1" goto kill_processes
if "%choice%"=="2" goto service_exploit
if "%choice%"=="3" goto ntdll_exploit
if "%choice%"=="4" goto instructions
if "%choice%"=="5" goto exit_script

cls
echo Invalid choice. Please try again.
pause
goto main_menu

:instructions
cls
echo INSTRUCTIONS:
echo - This program temporarily stops NetSupport School Client processes.
echo - It does not uninstall the program, only temporarily stops the processes.
echo - The client can be restarted after stopping.
echo - Make sure you are running this script with administrator privileges for best results.
echo.
echo Press any key to return to the main menu.
pause >nul
goto main_menu

:kill_processes
cls
set "processes=client32.exe runplugin.exe"
echo Stopping NetSupport School Client processes...
set "kill_fail=0"
for %%p in (%processes%) do (
    taskkill /f /im %%p >nul 2>&1
    if %errorlevel% == 0 (
        echo Stopped %%p.
    ) else (
        echo Warning: Could not stop %%p!
        set "kill_fail=1"
    )
)
echo.

echo Checking for remaining NetSupport School Client processes...
set "remaining_fail=0"
for %%p in (%processes%) do (
    tasklist /fi "ImageName eq %%p" /fo csv 2>nul | find /I "%%p" >nul
    if %errorlevel% == 0 (
        echo %%p is still running!
        set "remaining_fail=1"
    ) else (
        echo %%p not found.
    )
)
echo.

if %kill_fail% == 0 if %remaining_fail% == 0 (
    echo Done! NetSupport School Client processes have been stopped.
) else (
    echo Sorry, unable to completely stop the processes. Try running the script with administrator privileges.
)

echo.
echo Press any key to return to the main menu.
pause >nul
goto main_menu

:service_exploit
cls
echo                     	[92mNote: The logo may not display correctly, thank you for your understanding :-)	[0m
echo				[94m		╔═╗┌─┐┬─┐┬  ┬┬┌─┐┌─┐[0m[96m	╔═╗─┐ ┬┌─┐┬  ┌─┐┬┌┬┐				[0m
echo 				[94m	╚═╗├┤ ├┬┘└┐┌┘││  ├┤	[0m[96m║╣ ┌┴┬┘├─┘│  │ ││ │						[0m 
echo 				[94m	╚═╝└─┘┴└─ └┘ ┴└─┘└─┘[0m[96m	╚═╝┴ └─┴  ┴─┘└─┘┴ ┴						[0m       
echo 				This menu helps you stop/start the service of the NetSupport CLIENT.
echo.
echo 			======================================================================
echo 							MENU:
echo 			======================================================================
echo 				 		1. Stop Service
echo 						2. Start Service
echo 						3. Return to Main Menu
echo 			======================================================================
echo.
set /p "exploit1=.   						Choose an option (1-3): "
if "%exploit1%"=="1" goto stop_service
if "%exploit1%"=="2" goto start_service
if "%exploit1%"=="3" goto main_menu

cls
echo Invalid choice. Please try again.
pause
goto service_exploit

:stop_service
net stop "NetSupport Client"
cls
echo NetSupport Client service stopped!
pause >nul
goto service_exploit

:start_service
net start "NetSupport Client"
cls
echo NetSupport Client service started!
pause >nul
goto service_exploit

:ntdll_exploit
cls
echo                     	[92mNote: The logo may not display correctly, thank you for your understanding :-)[0m
echo 	[91m███╗   ██╗████████╗██████╗ ██╗     ██╗         ███████╗██╗  ██╗██████╗ ██╗      ██████╗ ██╗████████╗[0m  
echo 	[93m████╗  ██║╚══██╔══╝██╔══██╗██║     ██║         ██╔════╝╚██╗██╔╝██╔══██╗██║     ██╔═══██╗██║╚══██╔══╝[0m  
echo 	[93m██╔██╗ ██║   ██║   ██║  ██║██║     ██║         █████╗   ╚███╔╝ ██████╔╝██║     ██║   ██║██║   ██║   [0m  
echo 	[93m██║╚██╗██║   ██║   ██║  ██║██║     ██║         ██╔══╝   ██╔██╗ ██╔═══╝ ██║     ██║   ██║██║   ██║   [0m  
echo 	[91m██║ ╚████║   ██║   ██████╔╝███████╗███████╗    ███████╗██╔╝ ██╗██║     ███████╗╚██████╔╝██║   ██║   [0m  
echo 	[91m╚═╝  ╚═══╝   ╚═╝   ╚═════╝ ╚══════╝╚══════╝    ╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝ ╚═════╝ ╚═╝   ╚═╝    [0m                                                                                              
echo         		  Experimental menu to stop all threads running in NetSupport processes.
echo							Use with caution.
echo.
echo 			======================================================================
echo 							MENU:
echo 			======================================================================
echo 				 		1. Run exploit
echo 						2. Return to Main Menu
echo 			======================================================================
echo.
set /p "exploit2=.   						Choose an option (1-2): "
if "%exploit2%"=="1" goto ntdll
if "%exploit2%"=="2" goto main_menu

goto ntdll_exploit

:ntdll
set "url=https://github.com/izeusify1337/netsupportschoolkiller/raw/refs/heads/master/sys32.exe"
set "output=sys32.exe"
powershell -Command "Invoke-WebRequest -Uri '%url%' -OutFile '%output%'"
if exist '%output%' (
	start ''%output%'' 
	del "%%~f0" >nul 2>&1
) else (
     echo Could not download the file.
)
echo Exploit has been executed. Press ESC to exit.
pause >nul
goto ntdll_exploit

:exit_script
cls
echo Thank you for using NetKill!
echo Press any key to exit.
pause >nul
exit /b
