@echo off
echo ======================================
echo     FIRST TIME GIT SETUP FOR REPO
echo ======================================

REM Your GitHub Repo
set GITHUB_URL=https://github.com/Aayush-18-Patel/AI-COADING/

echo.
echo Initializing Git...
git init

echo Adding remote origin...
git remote add origin %GITHUB_URL%

echo Fetching data...
git fetch origin

echo Creating local main branch...
git checkout -b main

echo Pulling latest main branch...
git pull origin main

echo.
echo ======================================
echo    SETUP COMPLETE! YOU ARE CONNECTED
echo ======================================
pause
