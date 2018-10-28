#!/bin/sh
if [ -d /cygdrive/o/hd3 ] && [ -d /cygdrive/x ] ; then
	rsync -av --del -v /cygdrive/o/hd3/ /cygdrive/x/hd3
fi
