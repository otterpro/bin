﻿# TODO: create scheduled task to git push_notes.sh
$cygwinBin="$env:ChocolateyToolsLocation\cygwin\bin"
$cygwinHomeDir="$env:ChocolateyToolsLocation\cygwin\home\$env:username"

#===========================================================================
# dotfiles 
# UNTESTED!!!  THIS SHOULD BE IN DOS SCRIPT
# unfortunately, it can't easily do git clone, so dotfiles will have to be done separately
#===========================================================================

#$DotfileTargetPath="$env:ChocolateyToolsLocation\cygwin\home\$env:username\.dotfiles"
#$DotfileTargetPath="/home/otter/.dotfiles"

#&"$cygwinBin\git.exe" clone https://github.com/otterpro/dotfiles.git $DotfileTargetPath
#&"$cygwinBin\bash.exe" "$DotfileTargetPath\dotfiles.sh"

#===========================================================================
# create SSH key  (so I can SSH and also use GIT)
#===========================================================================
& $cygwinBin\bash.exe $cygwinHomeDir\bin\setup\make_sshkey.sh
# create symlink: cygwin's home .ssh/ ==> Windows home .ssh/
#     so that Git for Bash as well as other Git/SSH clients can use SSH keys
New-Item -Path  "$env:USERPROFILE\.ssh\"  -ItemType SymbolicLink -Value "$cygwinHomeDir\.ssh\"

#===========================================================================
# symlink .vim, .vimrc, .gvim
# symlink cygwin's ~/ to Win's ~/cyghome/
# NOTE: must install cygwin and git clone /bin first!!!
#===========================================================================
New-Item -Path  "$env:USERPROFILE\.vimrc" -ItemType SymbolicLink -Value "$cygwinHomeDir\.dotfiles\.vimrc"
Move-Item -Path "$env:USERPROFILE\vimfiles\" "$env:USERPROFILE\vimfiles_old\"
    # Remove-Item -Path "$env:USERPROFILE\vimfiles\" -Recurse -Force
    # also delete existing vimfiles\ since I can't create new symlink on existin dir
    # but instead of deleting, move it to temp folder for safety!!!
New-Item -Path  "$env:USERPROFILE\vimfiles\"  -ItemType SymbolicLink -Value "$cygwinHomeDir\.dotfiles\.vim\"
    # Windows Vim uses vimfiles/, not .vim/
New-Item -Path  "$env:USERPROFILE\.gvimrc"  -ItemType SymbolicLink -Value "$cygwinHomeDir\.dotfiles\.gvimrc"

# ~/cyghome => /cygwin..../home/USER/
New-Item -Path  "$env:USERPROFILE\cyghome\"  -ItemType SymbolicLink -Value "$cygwinHomeDir\"

#===========================================================================
# create symbolic link for PS profile (includes aliases, etc)
#  ~/bin/profile.ps1 ==> C:\Users\<USERNAME>\Documents\WindowsPowershell\profile.ps1
#  * Warning: Make sure not to delete existing profile.ps1, 
#  * esp if working on other's PC (or based on company's policy)
# TODO: move profile.ps1 from bin/ to .dotfiles/ instead...
#=========================================================================== 
#original intent: 
#   New-Item -path $profile -ItemType SymbolicLink -Value C:\cygwin64\home\DKim\bin\Microsoft.PowerShell_profile.ps1
if (!(Test-Path -Path $profile.CurrentUserAllHosts)) { 
    Write-Host "creating symbolic link for PS profile"
    New-Item -path $profile.CurrentUserAllHosts -ItemType SymbolicLink -Value "$PSScriptRoot\profile.ps1"
}
