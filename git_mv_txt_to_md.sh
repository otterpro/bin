#!/bin/bash
for i in *.txt; do
	[ -e "$i" ] || continue
	git mv "$i" "${i%.txt}.md" 
done
