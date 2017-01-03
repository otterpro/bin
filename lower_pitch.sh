#!/bin/bash
# TODO: currently only handles lower case mp3, allow it to handle all cases
# whether upper/lower 
# TODO: set pitch on commandline
mkdir -p _output
for i in *.mp3; do
	[ -e "$i" ] || continue
	sox "$i" "_output/$i" pitch -600
done
