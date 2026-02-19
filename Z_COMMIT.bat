@echo off
setlocal EnableDelayedExpansion

:: Path to private repo
set INNER_REPO=E:\JG-main\Z_OTHER\AI-COADING

echo ==========================================
echo     AUTO COMMIT (MAIN + CAPSTONE)
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

:: ---------- INNER CAPSTONE REPO (SHARED SAFE MODE) ----------
echo Committing CAPSTONE Repo...
pushd "%INNER_REPO%"

for /f "delims=" %%b in ('git rev-parse --abbrev-ref HEAD') do set innerbranch=%%b

git add .
git diff --cached --quiet || git commit -m "%commitmsg%"

echo Pulling latest changes...
git pull origin %innerbranch% --rebase

echo Pushing to remote...
git push origin %innerbranch%

popd
pause