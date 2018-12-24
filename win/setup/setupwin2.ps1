#Start-Process PowerShell -ArgumentList "Set-ExecutionPolicy Restricted -Force" -Verb RunAs
# 
cd $PSScriptRoot

#===========================================================================
# CONFIG: change if needed
#===========================================================================
# change this if you want to rename the PC. 
# possible TODO: also set domain credential, etc
$ComputerName = $null
$keyboardRemapCapslock = $false
$MyChocolateyToolsPath="C:\bin\choco"
$emacs = $null  #if $true, install emacs and do settings

    # make sure to change choco install path for certain packages 
    #TODO: add the same for pstools , usually c:\tools\, but this needs to be changed
Write-Host "windows user's personal setup"
# Write-click on this script and run as Powershell script

# ensure ExecutionPolicy to either AllSigned or Bypass
# TODO: THIS should be in DOS SCRIPT
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

# if above line doesn't work, try this
# (https://superuser.com/questions/616106/set-executionpolicy-using-batch-file-powershell-script)
# Start-Process PowerShell -ArgumentList "Set-ExecutionPolicy unrestricted -Force" -Verb RunAs

# MYVIMRC="C:\cygwin64\home\Dkim"
# [Environment]::SetEnvironmentVariable("MYVIMRC", "C:\Cygwin64\home\$env:username", "User")

# Must cd into install/dotfiles/bin folder (haven't decided where to put this)

#===========================================================================
# Enable Developer Mode (may require reboot?)
# [powershell - Enable Windows 10 Developer Mode programmatically - Stack Overflow](https://stackoverflow.com/questions/40033608/enable-windows-10-developer-mode-programmatically?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa)
#===========================================================================

	# Create AppModelUnlock if it doesn't exist, required for enabling Developer Mode
	$RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
	if (-not(Test-Path -Path $RegistryKeyPath)) {
	    New-Item -Path $RegistryKeyPath -ItemType Directory -Force
	}
	
	# Add registry value to enable Developer Mode
	New-ItemProperty -Path $RegistryKeyPath -Name AllowDevelopmentWithoutDevLicense -PropertyType DWORD -Value 1
# 
#===========================================================================
# Chocolatey
#===========================================================================
if (!($env:ChocolateyInstall)) {  #if choco is not installed
    Write-Host "Installing Chocolatey"

    # install and update choco
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}


    #[Environment]::SetEnvironmentVariable($env:ChocolateyToolsLocation, "c:\bin\choco", [EnvironmentVariableTarget]::Machine)
    # Turns out I need to use User, not Machine
    # permanently
    [Environment]::SetEnvironmentVariable("ChocolateyToolsLocation", $MyChocolateyToolsPath, "User")
    # also for this session
    $env:ChocolateyToolsLocation= $MyChocolateyToolsPath   
    
    #NOTE: also might change it to c:\ProgramData\chocolatey\bin, as this is where some bin files are going to.

# choco update
    choco upgrade chocolatey -y
    # Base
    choco install git -y
    choco install git-credential-winstore -y
    choco install poshgit -y
    choco install cmake -y
    choco install python -y  
    choco install python2 -y
    # python2 required for gvim

    # tools essential
    choco install autohotkey -y
    choco install 7zip -y
    choco install ripgrep -y
    choco install ag -y
    choco install fzf -y
    choco install greenshot -y
    # utils
    choco install bginfo -y
    # broken?
    # choco install teracopy -y

    # Network tool
    # zerotier choco package is "possibly broken"
    choco install zerotier-one -y
    
    # editors
    choco install vim -y
    choco install sourcecodepro -y   #font
    # maybe: spacemacs

    # Media
    choco install ffmpeg -y
    choco install vlc -y
    choco install foobar2000 -y
    choco install musicbee -y
    
    # possibly broken/ fails, but would like
    # choco install synergy -y

    # windows  - home 
    # choco install nanumfont -y  # don't install. install fantasq istaed
        # problem: requires user to interact on GUI on setup!!!
    # TODO: no fantasq font yet
    
    # browsers
    choco install firefox -y
    choco install GoogleChrome -y
    
    # add to path: C:\ProgramData\chocolatey\bin\  (ffmpeg)
    #TODO: ? is this required? or is this set with chocolatey install?
    # [Environment]::SetEnvironmentVariable("Path", $env:Path + ";"+$env:ProgramData+"\chocolatey\bin", [EnvironmentVariableTarget]::Machine)
    # not sure, so commented out for now.  If 'ffmpeg' won't launch, check

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
#
#   This part didn't run for some reason when I ran it on new machine... 
#   TEST it again when 
 
$key = 'HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout'
$attribute = "Scancode Map"
$propValue = (Get-ItemProperty $key).$attribute 
if (!$propValue) {  #if reg value doesn't exist

    Write-Host "Keyboard setting - swapping Ctrl with Alt "
    if ($keyboardRemapCapslock) {
        # Ctrl-Capslock and LeftALT with RCTRL
        $binValues = "00,00,00,00,00,00,00,00,03,00,00,00,1d,00,3a,00,1d,e0,38,00,00,00,00,00"
    }
    else {
        # Only LeftALT with RCTRL
        #"Scancode Map"=hex:00,00,00,00,00,00,00,00,02,00,00,00,1d,e0,38,00,00,00,00,00
        $binValues = "00,00,00,00,00,00,00,00,02,00,00,00,1d,e0,38,00,00,00,00,00"
    }
    $hexified = $binValues.Split(',') | % { "0x$_"}
    New-ItemProperty -Path $key -Name $attribute -PropertyType Binary -Value ([byte[]]$hexified)
}

# TODO: git clone my dotfiles and cd into that folder 
# then do the following

#===========================================================================
# TODO: install cygwin and then git clone my repository first!!!
#===========================================================================
# DO I use cygwin? or git-windows-bash? cygwin is too heavy?!
# install git-win-bash, using DOS script, use it to bootstrap and 
# Currently using cygwin as git, since cygwin is more versatile

#choco install cygwin -y  # automatically installed by cyg-get?
choco install cyg-get -y
cyg-get git zip unzip vim zsh python curl tree

# CONTINUE HERE!!!
$cygwinBin="$env:ChocolateyToolsLocation\cygwin\bin"
$cygwinHomeDir="$env:ChocolateyToolsLocation\cygwin\home\$env:username"

# cygwin has to run at least once, as it creates username and home directory
# not sure if this will work... hopefully it's not interactive???  icon has mintty.exe -i (-i = ???)
&"$cygwinBin\mintty.exe"


#===========================================================================
# emacs : set $HOME (for domain user only), as it has problem finding it
#===========================================================================
if ($emacs) {

    choco install emacs -y  
$key = 'HKCU:\SOFTWARE\GNU\Emacs'
$attribute = "Home"
$propValue = (Get-ItemProperty $key).$attribute 
if (!$propValue) {  #if reg value doesn't exist

    Write-Host "Setting HOME value in Gnu Emacs"
    New-Item -Path $key -Force | Out-Null
    New-ItemProperty -Path $key -Name $attribute -PropertyType String -Value $HOME   -Force | Out-Null
}
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
