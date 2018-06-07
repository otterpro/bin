#!/bin/sh
#./make_sshkey.sh

cd ~
# dotfiles
git clone ssh://github.com/otterpro/dotfiles.git ~/.dotfiles
~/.dotfiles/dotfiles.sh

# bin.  
# commented out because it's Assumed that it's already loaded. 
# git clone ssh://github.com/otterpro/bin.git ~/bin

# TODO: notes (optional)
#git clone otterpro@bitbucket.org:otterpro/notes.git ~/notes
