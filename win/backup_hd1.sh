#!/bin/sh
if [ -d /cygdrive/o/hd1 ] && [ -d /cygdrive/q ] ; then
	rsync -av --del -v /cygdrive/o/hd1/ /cygdrive/q/hd1
fi