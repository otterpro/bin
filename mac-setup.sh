#!/bin/sh
# setup script for Mac

# xcode cmdline tool
xcode-select --install

# homebrew
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

brew install coreutils
brew install binutils
brew install diffutils
brew install gzip
brew install watch
brew install tmux
brew install wget
brew install nmap
brew install gpg
brew install htop
brew install trash
brew install m-cli
brew install macvim
brew install vlc

# optional
brew install tldr

# wishlist
# brew cask install evernote
# brew cask install google-chrome
# brew cask install firefox 
# beardspice - not avail on brew
# zerotier and setup
# amazon music

# ffmpeg
brew install ffmpeg --with-fdk-aac --with-ffplay --with-freetype --with-frei0r --with-libass --with-libvo-aacenc --with-libvorbis --with-libvpx --with-opencore-amr --with-openjpeg --with-opus --with-rtmpdump --with-schroedinger --with-speex --with-theora --with-tools

