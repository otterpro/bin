#!/bin/sh
ssh-keygen -t rsa -C "coconutstudio@gmail.com" -P ""

# TODO: copy ssh key to github and bitbucket

cd ~
# dotfiles
git clone ssh://github.com/otterpro/dotfiles.git ~/.dotfilesh
~/.dotfiles/dotfiles.sh

# bin
git clone ssh://github.com/otterpro/bin.git ~/bin

# TODO: notes (optional)
git clone otterpro@bitbucket.org:otterpro/notes.git ~/notes
