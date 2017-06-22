Write-Host "windows user's personal setup"
# MYVIMRC="C:\cygwin64\home\Dkim"
# [Environment]::SetEnvironmentVariable("MYVIMRC", "C:\Cygwin64\home\$env:username", "User")

# Must cd into install/dotfiles/bin folder (haven't decided where to put this)
#===========================================================================
# Chocolatey
#===========================================================================
if (!($env:ChocolateyInstall)) {  #if choco is not installed

    # ensure ExecutionPolicy to either AllSigned or Bypass
    Set-ExecutionPolicy -ExecutionPolicy AllSigned

    # install and update choco
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    choco upgrade chocolatey -y

    # Base
    choco install git -y
    choco install git-credential-winstore -y
    choco install poshgit -y
}


#===========================================================================
# Explorer: show Hidden files and show all extensions
#===========================================================================
# same as : Set Explorer Windows option 
    # Choose "Show hidden files, folders, and drives"
    # Uncheck "Hide extensions for known file types"
    # Uncheck "Hide protected operating system files (Recommended)"
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
if ((Get-ItemProperty $key).HideFileExt -ne 0) {
    # Do this only if necessary!  Get-ItemProperty first
    Write-Host "Setting Explorer to show hidden files and extensions"
    Set-ItemProperty $key Hidden 1
    Set-ItemProperty $key HideFileExt 0
    Set-ItemProperty $key ShowSuperHidden 1
    Stop-Process -processname explorer
}

#===========================================================================
# Swap Ctrl with CapsLock and assign Left ALT to Right CTRL
#===========================================================================
# see ~/bin/winkb*.reg
# Note: The user must re-login? /reboot to take effect
# setting binValues in registry: https://stackoverflow.com/a/33586470
#Change these three to match up to the extracted registry data and run as Admin
$key = 'HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout'
$attribute = "Scancode Map"
$propValue = (Get-ItemProperty $key).$attribute 
if (!$propValue) {  #if reg value doesn't exist
    $binValues = "00,00,00,00,00,00,00,00,03,00,00,00,1d,00,3a,00,1d,e0,38,00,00,00,00,00"
    $hexified = $binValues.Split(',') | % { "0x$_"}
    New-ItemProperty -Path $key -Name $attribute -PropertyType Binary -Value ([byte[]]$hexified)
}

# TODO: git clone my dotfiles and cd into that folder 
# then do the following



#===========================================================================
# create symbolic link for PS profile (includes aliases, etc)
#===========================================================================
# assuming my dotfiles have been installed!

#original intent: 
#   New-Item -path $profile -ItemType SymbolicLink -Value C:\cygwin64\home\DKim\bin\Microsoft.PowerShell_profile.ps1
if (!(Test-Path -Path $profile)) { 
    Write-Host "creating symbolic link for PS profile"
    New-Item -path $profile -ItemType SymbolicLink -Value "$PSScriptRoot\Microsoft.PowerShell_profile.ps1"
}