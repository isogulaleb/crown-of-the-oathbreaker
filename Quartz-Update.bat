@echo off
chcp 65001
cd /d C:\Users\isogu\quartz

echo Friss jegyzetek atmasolasa az Obsidianbol...
:: Added /XO to skip files that haven't changed, preventing timestamp updates
robocopy "I:\Saját meghajtó\Obsidian Vaults\Crown of the Oathbreaker" "C:\Users\isogu\quartz\content" /E /XO /XD .obsidian .space .trash /XF .DS_Store

echo Weboldal frissitese es feltoltese a GitHubra...
git add .

:: Automatically extract the names of modified/new files for a precise commit message
setlocal enabledelayedexpansion
set "changes="
for /f "tokens=2 delims= " %%i in ('git status --porcelain') do (
    set "changes=!changes! %%~nxi,"
)
if defined changes (
    set "changes=!changes:~1,-1!"
    git commit -m "Frissítve: !changes!"
) else (
    git commit -m "Jegyzetek frissítése"
)

git push origin v5
echo KESZ! A weboldal 1-2 percen belul frissul az interneten.
pause
