#!/usr/bin/env bash
#
# Daniel Kim 
# 
# 1. install Visual Studio Code
# 2. symlink config files from ~/.dotfiles/
#
# Requirements: ~/.dotfiles/, homebrew, chocolatey(?), cygwin
#
# UNTESTED:  
# * can `choco` be run from cygwin's bash shell?

# Settings file locations
# * Windows %APPDATA%\Code\User\settings.json
# * macOS $HOME/Library/Application Support/Code/User/settings.json
# * Linux $HOME/.config/Code/User/settings.json
mac_vscode_path="$HOME/Library/Application Support/Code/User"
win_vscode_path="$(cygpath "$APPDATA")/Code/User"
linux_vscode_path="$HOME/.config/Code/User"

# changed path (removed _optional/ as it seemed redundant at this time)
# vscode_dotfile_path="$HOME/.dotfiles/_optional/VSCode"
vscode_dotfile_path="$HOME/.dotfiles/_VSCode"

#cd into script's path
cd $(dirname $0) ; pwd -P

## Check OS, OS-dependent code
if [[ "$OSTYPE" =~ "darwin" ]]
then
    export OS="mac"
	
	# first install VS code
	brew install visual-studio-code

	#Visual Code - assuming it exists. 
	# ln -sf ~/.dotfiles/_optional/VSCode/settings.json $mac_vscode_path/settings.json
	# ln -sf ~/.dotfiles/_optional/VSCode/keybindings.json $mac_vscode_path/keybindings.json
	# ln -sf ~/.dotfiles/_optional/VSCode/snippets/ $mac_vscode_path/snippets
	ln -sf "$vscode_dotfile_path/settings.json" "$mac_vscode_path/settings.json"
	ln -sf "$vscode_dotfile_path/keybindings.json" "$mac_vscode_path/keybindings.json"
	ln -sf "$vscode_dotfile_path/snippets/" "$mac_vscode_path/snippets"

elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    export OS="linux"
	echo "Haven't done Linux yet... TODO"
	exit 1

elif [[ "$OSTYPE" == "cygwin" ]]; then
    export OS="cygwin"

	# enable symlink in cygwin!!! this is needed for "ln -s" later here...
	export CYGWIN="winsymlinks:nativestrict"

	# choco install vscode -y
	# ??? assuming that choco can be run from cygwin bash shell!

	# * Windows %APPDATA%\Code\User\settings.json
	# if ln -s doesn't work for some reason, then create a powershell script to do this instead
	# ln -sf ~/.dotfiles/_optional/VSCode/settings.json ~/Library/Application\ Support/Code/User/settings.json
	# ln -sf ~/.dotfiles/_optional/VSCode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
	# ln -sf ~/.dotfiles/_optional/VSCode/snippets/ ~/Library/Application\ Support/Code/User/snippets
	ln -sf "$vscode_dotfile_path/settings.json" "$win_vscode_path/settings.json"
	ln -sf "$vscode_dotfile_path/keybindings.json" "$win_vscode_path/keybindings.json"
	ln -sf "$vscode_dotfile_path/snippets/" "$win_vscode_path/"
	
else
    echo "Don't know what to do with '$OSTYPE' operating system. Need to implement this"
    exit 1
fi
