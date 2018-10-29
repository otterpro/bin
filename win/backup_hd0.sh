#!/bin/sh
echo "======================"
echo "HD0(TM0.sparsebundle): "
date "+%Y-%m-%d:%H:%M:%S"
if [ -d /cygdrive/o/TM0.sparsebundle ] && [ -d /cygdrive/p ] ; then
	rsync -av --del /cygdrive/o/TM0.sparsebundle/ /cygdrive/p/TM0.sparsebundle
fi
