REM Put in Scheduled Task to update _notes daily
set PATH=c:\cygwin64\bin;%PATH%
set NOTES_PATH=c:\cygwin64\home\dkim\Dropbox\_notes


cd %NOTES_PATH%
git add -A
git commit -m"scheduled update"
git pull --no-edit
git push
exit 0
