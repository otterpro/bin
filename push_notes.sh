#!/bin/sh
#cd c:\cygwin64\home\DKim\_notes
GIT=/usr/bin/git
DATE=/usr/bin/date
cd ~/_notes
$GIT add -A
#$GIT commit -am"daily update `date`"
$GIT commit -am"daily update $DATE"
$GIT pull --no-edit
$GIT push
