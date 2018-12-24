$cygwinBin="$env:ChocolateyToolsLocation\cygwin\bin"
$cygwinHomeDir="$env:ChocolateyToolsLocation\cygwin\home\$env:username"

# install conemu, if needed
choco install conemu -y

# if file already exists, then rename it as backup
If (Test-Path "$env:APPDATA\conemu.xml") {
    Rename-Item -Path "$env:APPDATA\conemu.xml" -NewName "$env:APPDATA\conemu(backup).xml"
    }
# symlink conemu.xml
New-Item -Path "$env:APPDATA\conemu.xml" -ItemType SymbolicLink -Value "$cygwinHomeDir\.dotfiles\_win\ConEmu.xml"
