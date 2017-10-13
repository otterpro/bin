#!/bin/bash
for i in *blog.md; do
	[ -e "$i" ] || continue
	echo "$i" "${i% !blog.md}.md" 
	git mv "$i" "${i% !blog.md}.md" 
done
