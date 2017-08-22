#!/bin/bash
# not used anymore? as "v" has been aliased to vim/mvim in .aliases
case "$OSTYPE" in
	darwin*) 
		#note_path=~/Dropbox/_notes
		note_path=/Volumes/Samsung128/Dropbox/_notes
		editor=mvim
		;;
	*) 
		note_path=~/_notes
		editor=vim
		;;
esac
if [ $# == 0 ]; then
  mvim
else
  mvim --servername $(basename $(pwd)) \
       --remote-tab-silent "$@" 1>/dev/null 2>&1
fi

#http://tammersaleh.com/posts/useful-macvim-script/
