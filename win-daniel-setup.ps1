# 
cd $PSScriptRoot

#===========================================================================
# CONFIG: change if needed
#===========================================================================
# change this if you want to rename the PC. 
# possible TODO: also set domain credential, etc
$ComputerName = $null


Write-Host "windows user's personal setup"
# Write-click on this script and run as Powershell script

# ensure ExecutionPolicy to either AllSigned or Bypass
Set-ExecutionPolicy -ExecutionPolicy AllSigned

# if above line doesn't work, try this
# (https://superuser.com/questions/616106/set-executionpolicy-using-batch-file-powershell-script)
# Start-Process PowerShell -ArgumentList "Set-ExecutionPolicy unrestricted -Force" -Verb RunAs

# MYVIMRC="C:\cygwin64\home\Dkim"
# [Environment]::SetEnvironmentVariable("MYVIMRC", "C:\Cygwin64\home\$env:username", "User")

# Must cd into install/dotfiles/bin folder (haven't decided where to put this)
#===========================================================================
# Chocolatey
#===========================================================================
if (!($env:ChocolateyInstall)) {  #if choco is not installed
    Write-Host "Installing Chocolatey"

    # install and update choco
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    choco upgrade chocolatey -y

    # Base
    choco install git -y
    choco install git-credential-winstore -y
    choco install poshgit -y

    # UI tools
    choco install autohotkey -y
    choco install 7zip -y

    # Network tool
    # zerotier choco package is "possibly broken"
    choco install zerotier-one -y

    # utils
    choco install bginfo -y

    # possibly broken/ fails, but would like
    # choco install teracopy -y
    # choco install zerotier-one -y
    # choco install synergy -y

    # windows  - home 
    # choco install nanumfont -y
    # problem: requires user to interact on GUI on setup!!!
}

#===========================================================================
# Enable Remote Desktop (RDP)
# http://windowsitpro.com/windows/enable-remote-desktop-using-powershell
#===========================================================================
(Get-WmiObject Win32_TerminalServiceSetting -Namespace root\cimv2\TerminalServices).SetAllowTsConnections(1,1) | Out-Null
(Get-WmiObject -Class "Win32_TSGeneralSetting" -Namespace root\cimv2\TerminalServices -Filter "TerminalName='RDP-tcp'").SetUserAuthenticationRequired(0) | Out-Null
# open firewall for RDP
Get-NetFirewallRule -DisplayName "Remote Desktop*" | Set-NetFirewallRule -enabled true

#===========================================================================
# NETWORK setup
#===========================================================================
# Enable PING
Get-NetFirewallRule -DisplayName "*File and Printer Sharing (Echo Request - ICMPv4-In)*" | Set-N etFirewallRule -enabled true


# Enable File and Printer Sharing - also be able to see \\COMPUTER
# TODO/FUTURE: array of folders on top, and create dir and share here
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes

# optional: add sharing SMB
    # mkdir "C:\Shared"   #same as New-Item -path "C:\Shared"
    # New-SMBShare –Name “My_Shared” –Path “C:\Shared” –FullAccess Administrator -Confirm:$false


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
# Swap Ctrl with CapsLock and/or assign Left ALT to Right CTRL
#===========================================================================
# see ~/bin/winkb*.reg
# Note: The user must re-login? /reboot to take effect
# setting binValues in registry: https://stackoverflow.com/a/33586470
#Change these three to match up to the extracted registry data and run as Admin
# currently, I'm only using LALT-RCTRL swap
#   CAPSLOCK is handled by Autohotkey due to ESC-CTRL mechanism
 
$key = 'HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout'
$attribute = "Scancode Map"
$propValue = (Get-ItemProperty $key).$attribute 
if (!$propValue) {  #if reg value doesn't exist

    Write-Host "Keyboard setting - swapping Ctrl with Alt "
    # Ctrl-Capslock and LeftALT with RCTRL
    # $binValues = "00,00,00,00,00,00,00,00,03,00,00,00,1d,00,3a,00,1d,e0,38,00,00,00,00,00"

    # Only LeftALT with RCTRL
    #"Scancode Map"=hex:00,00,00,00,00,00,00,00,02,00,00,00,1d,e0,38,00,00,00,00,00
    $binValues = "00,00,00,00,00,00,00,00,02,00,00,00,1d,e0,38,00,00,00,00,00"
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
if (!(Test-Path -Path $profile.CurrentUserAllHosts)) { 
    Write-Host "creating symbolic link for PS profile"
    New-Item -path $profile.CurrentUserAllHosts -ItemType SymbolicLink -Value "$PSScriptRoot\profile.ps1"
}

#===========================================================================
# Computer Name
# * must be last item, since it will restart
# optional
# FUTURE: add Domain cred here
#===========================================================================
if ($ComputerName) {
    Rename-Computer -NewName $ComputerName -Restart
}
