REM Put in Scheduled Task to update _notes daily
set PATH=c:\cygwin64\bin;%PATH%
cd c:\cygwin64\home\dkim\_notes
git add -A
git commit -m"scheduled update"
git pull --no-edit
git push
exit 0
