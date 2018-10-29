#!/bin/sh
echo "======================"
echo "HD2: "
date "+%Y-%m-%d:%H:%M:%S"
if [ -d /cygdrive/o/hd2 ] && [ -d /cygdrive/w ] ; then
	rsync -av --del /cygdrive/o/hd2/ /cygdrive/w/hd2
fi
