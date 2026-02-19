@echo off
setlocal EnableDelayedExpansion

:: ----------------------------------------
:: YOUR PUBLIC GITHUB REPO (ALWAYS USED)
:: ----------------------------------------
set GITHUB_URL=https://github.com/Aayush-18-Patel/AI-COADING/

:: Path to your local repo
set INNER_REPO=D:\AI-COADING

echo ==========================================
echo      AUTO COMMIT (MAIN + CAPSTONE)
echo ==========================================

:: Timestamp
for /f "tokens=1-3 delims=/" %%a in ("%date%") do (
    set dd=%%a
    set mm=%%b
    set yyyy=%%c
)
set hh=%time:~0,2%
set mn=%time:~3,2%
if "%hh:~0,1%"==" " set hh=0%hh:~1,1%
set commitmsg=Date :- %dd%-%mm%-%yyyy%--- Time :- %hh%:%mn%

echo Commit Message: "%commitmsg%"
echo.

:: --------- NAVIGATE TO REPO ---------
pushd "%INNER_REPO%"

:: --------- FIRST TIME SETUP ---------
if not exist ".git" (
    echo.
    echo ======================================================
    echo        FIRST TIME SETUP – CONFIGURING REPOSITORY
    echo ======================================================
    echo.

    git init

    echo Adding GitHub remote...
    git remote add origin "%GITHUB_URL%"

    echo Fetching branches...
    git fetch origin

    echo Checking for default branch...
    git rev-parse --verify origin/main >nul 2>&1
    if !errorlevel! == 0 (
        set branch=main
    ) else (
        git rev-parse --verify origin/master >nul 2>&1
        if !errorlevel! == 0 (
            set branch=master
        ) else (
            echo No main/master found. Creating main...
            set branch=main
            git checkout -b main
            goto CONTINUE_SETUP
        )
    )

    echo Creating local branch and syncing...
    git checkout -b %branch%
    git pull origin %branch%

    :CONTINUE_SETUP
    echo Setup complete!
    echo.
)

:: --------- DETECT ACTIVE BRANCH ---------
for /f "delims=" %%b in ('git rev-parse --abbrev-ref HEAD') do set activebranch=%%b

echo Using Branch: %activebranch%
echo.

:: --------- AUTO COMMIT ---------
git add .
git diff --cached --quiet || git commit -m "%commitmsg%"

echo Pulling latest changes...
git pull origin %activebranch% --rebase

echo Pushing...
git push origin %activebranch%

popd
pause
