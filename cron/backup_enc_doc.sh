#!/bin/sh
# copies encrypted doc.sparsebundle/ into 
echo "======================"
echo "doc.sparsebundle: "
date "+%Y-%m-%d:%H:%M:%S"
if [ -d /Volumes/HD0/doc.sparsebundle ] && [ -d /Users/otter/Box\ Sync ] ; then
	/usr/bin/rsync -av --del /Volumes/HD0/doc.sparsebundle/ /Users/otter/Box\ Sync/backups/doc.sparsebundle
fi
