@echo off
cd /d C:\Users\isogu\quartz
echo Friss jegyzetek atmasolasa az Obsidianbol...
robocopy "I:\Saját meghajtó\Obsidian Vaults\Crown of the Oathbreaker" "C:\Users\isogu\quartz\content" /E /XD .obsidian .space .trash /XF .DS_Store
echo Weboldal frissitese es feltoltese a GitHubra...
git add .
git commit -m "automatic campaign update"
git push origin v5
echo KESZ! A weboldal 1-2 percen belul frissul az interneten.
pause
