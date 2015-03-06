#!/bin/sh
# Daniel Kim (otter.pro): load vim after cd into dropbox/notes
case "$OSTYPE" in
	darwin*) 
		note_path=~/Dropbox/_notes
		editor=mvim
		;;
	*) 
		note_path=~/Dropbox/_notes
		editor=vim
		;;
esac
	cd $note_path
	$editor +CtrlP
