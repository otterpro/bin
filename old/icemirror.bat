"c:\program files\ice mirror\icemirror.exe" c:\_up0 Q:\_up0 /log=TRUE /MODE=1 /CASE=FALSE
echo BACKUP_HOME >> w:\log\backup.log
date /T >> Q:\log\backup.log
time /T >> Q:\log\backup.log

"c:\program files\ice mirror\icemirror.exe" g:\_data2 R:\_data2 /log=TRUE /MODE=1 /CASE=FALSE
echo BACKUP_ARCHIVE >> w:\log\backup.log
date /T >> R:\log\backup.log
time /T >> R:\log\backup.log