#!/bin/sh
echo "======================"
echo "HD3: "
date "+%Y-%m-%d:%H:%M:%S"
if [ -d /cygdrive/o/hd3 ] && [ -d /cygdrive/x ] ; then
	rsync -av --del /cygdrive/o/hd3/ /cygdrive/x/hd3
fi
