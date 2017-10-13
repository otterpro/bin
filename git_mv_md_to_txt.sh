#!/bin/bash
for i in *.md; do
	[ -e "$i" ] || continue
	git mv "$i" "${i%.md}.txt" 
done
