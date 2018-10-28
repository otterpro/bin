#!/bin/sh
date "+%Y-%m-%d:%H:%M:%S"
if [ -d /cygdrive/o/hd3 ] && [ -d /cygdrive/x ] ; then
	rsync -av --del -v /cygdrive/o/hd3/ /cygdrive/x/hd3
fi
