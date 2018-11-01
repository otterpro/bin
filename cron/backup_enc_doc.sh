#!/bin/sh
# copies encrypted doc.sparsebundle/ into 
echo "======================"
echo "doc.sparsebundle: "
date "+%Y-%m-%d:%H:%M:%S"
if [ -d /Volumes/?????/doc.sparsebundle ] && [ -d /Users/otter/Box\ Sync ] ; then
	rsync -av --del /Volumes/?????/doc.sparsebundle/ /Users/otter/Box\ Sync/backups/doc.sparsebundle
fi
