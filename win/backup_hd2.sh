#!/bin/sh
if [ -d /cygdrive/o/hd2 ] && [ -d /cygdrive/w ] ; then
	rsync -av --del -v /cygdrive/o/hd2/ /cygdrive/w/hd2
fi