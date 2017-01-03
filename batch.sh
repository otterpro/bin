#!/bin/bash
for i in *\@blog.txt; do
	[ -e "$i" ] || continue
	git mv "$i" "${i//@/!}"  
done
