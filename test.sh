#!/bin/bash
for i in ~/_notes/*\#test.txt; do
	[ -e "$i" ] || continue
	echo "$i" 
done
