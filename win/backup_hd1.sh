#!/bin/sh
echo "======================"
echo "HD1: "
date "+%Y-%m-%d:%H:%M:%S"
if [ -d /cygdrive/o/hd1 ] && [ -d /cygdrive/q ] ; then
	rsync -av --del /cygdrive/o/hd1/ /cygdrive/q/hd1
fi
