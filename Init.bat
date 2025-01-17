SETLOCAL enabledelayedexpansion
@ECHO off
MODE con lines=20 cols=56
COLOR 0A
CD /D %~dp0
TITLE Chrome Portable Initialazation
:HEAD
ECHO  ======================================================
ECHO  1. 获取/更新 Chrome
ECHO  2. 获取/更新 Chrome++ （不适用）
ECHO  ======================================================
:: 选择菜单
:: Use xcopy to retrieve the key press: https://stackoverflow.com/a/27257111/14168341
<NUL SET /p ".=请输入 1-8 选择，其它键退出："
SET "choix=" & for /f "delims=" %%a in ('xcopy /l /w "%~f0" "%~f0" 2^>nul') DO IF not defined choix set "choix=%%a"
SET "choix=%choix:~-1%"
FOR %%i in ( 1 2 ) DO IF %choix%==%%i ECHO %choix% && TIMEOUT /NOBREAK /T 1 >NUL
CLS
ECHO.
IF /i "%choix%"=="1" GOTO CHROME	
IF /i "%choix%"=="2" GOTO CHROMEPLUS
EXIT

:CHROME
CD "%~DP0Utils\"
::FOR /F "delims=" %%a in ('curl.exe -Lf https://ghproxy.com/https://github.com/coo11/Chrome/releases/download/stable_latest/x64.txt') DO SET URL=%%a
curl -o install.7z https://ghproxy.com/https://github.com/coo11/Chrome/releases/download/stable_latest/Chrome_Portable.7z && RD ..\App /S /Q >NUL 2>&1 & 7za x install.7z -aoa -o..\ && DEL install.7z /F /Q
PAUSE
GOTO BACK

:CHROMEPLUS
CD "%~DP0Utils\"
::curl -Locp.zip "https://nightly.link/shuax/chrome_plus/workflows/build/main/windows_x64.zip" && 7za x cp.zip -aoa && MD ..\App >NUL 2>&1 & move /Y version.dll ..\App\version.dll & DEL cp.zip /F /Q
:: Author of this plugin has been caught
:: The last version is 1.5.4.0
curl -O https://ghproxy.com/https://raw.githubusercontent.com/coo11/Chrome/master/Utils/version.dll && MD ..\App >NUL 2>&1 & move /Y version.dll ..\App\version.dll
PAUSE
GOTO BACK

:BACK
TIMEOUT /T 2 >NUL
CD /D %~dp0
CLS
GOTO HEAD