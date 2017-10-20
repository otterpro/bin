$cygwinBin="$env:ChocolateyToolsLocation\cygwin\bin"
# dotfiles 
# UNTESTED!!!  THIS SHOULD BE IN DOS SCRIPT
# unfortunately, it can't easily do git clone, so dotfiles will have to be done separately

#$DotfileTargetPath="$env:ChocolateyToolsLocation\cygwin\home\$env:username\.dotfiles"
#$DotfileTargetPath="/home/otter/.dotfiles"

#&"$cygwinBin\git.exe" clone https://github.com/otterpro/dotfiles.git $DotfileTargetPath
#&"$cygwinBin\bash.exe" "$DotfileTargetPath\dotfiles.sh"

#===========================================================================
# link .vim, .vimrc, .gvim
# NOTE: must install cygwin and git clone /bin first!!!
#===========================================================================
$cygwinHomeDir="$env:ChocolateyToolsLocation\cygwin\home\$env:username"
New-Item -Path  "$env:USERPROFILE\.vimrc" -ItemType SymbolicLink -Value "$cygwinHomeDir\.dotfiles\.vimrc"
Move-Item -Path "$env:USERPROFILE\vimfiles\" "$env:USERPROFILE\vimfiles_old\"
    # Remove-Item -Path "$env:USERPROFILE\vimfiles\" -Recurse -Force
    # also delete existing vimfiles\ since I can't create new symlink on existin dir
    # but instead of deleting, move it to temp folder for safety!!!
New-Item -Path  "$env:USERPROFILE\vimfiles\"  -ItemType SymbolicLink -Value "$cygwinHomeDir\.dotfiles\.vim\"
    # Windows Vim uses vimfiles/, not .vim/
New-Item -Path  "$env:USERPROFILE\.gvimrc"  -ItemType SymbolicLink -Value "$cygwinHomeDir\.dotfiles\.gvimrc"