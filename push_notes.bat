REM DON'T USE THIS!!! INSTEAD USE push_notes.sh
REM and use CYGWIN's bash.exe to launch
REM Put in Scheduled Task to update _notes daily
REM PATH=c:\cygwin64\bin;%PATH%
set PATH=%USERPROFILE%\cyghome\bin;%PATH%
REM NOTES_PATH=c:\cygwin64\home\dkim\notes
set NOTES_PATH=%USERPROFILE%\cyghome\notes


cd %NOTES_PATH%
git add -A
git commit -m"scheduled update"
git pull --no-edit
git push
exit 0
