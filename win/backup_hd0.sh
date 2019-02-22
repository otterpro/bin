#!/bin/sh
echo "======================"
echo "HD0: "
# echo "HD0(TM0.sparsebundle): "
date "+%Y-%m-%d:%H:%M:%S"

# skip TimeMachine for now
# if [ -d /cygdrive/o/TM0.sparsebundle ] && [ -d /cygdrive/p ] ; then
# 	rsync -av --del /cygdrive/o/TM0.sparsebundle/ /cygdrive/p/TM0.sparsebundle
# fi

if [ -d /cygdrive/o/hd0 ] && [ -d /cygdrive/p ] ; then
	rsync -av --del /cygdrive/o/hd0/ /cygdrive/p/hd0
fi
