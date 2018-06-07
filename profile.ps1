# my PS profile

Set-Alias grep Select-String

# used "ripgrep" for grep, but not anymore.
function grep_rg{
    $count = @($input).Count
    $input.Reset()

    if ($count) {
        $input | rg.exe --hidden $args
    }
    else {
        rg.exe --hidden $args
    }
}


#  `Equivalent of *Nix 'which' command in Powershell? <http://stackoverflow.com/questions/63805/equivalent-of-nix-which-command-in-powershell>`_::
function which($name) {
       Get-Command $name | Select-Object -ExpandProperty Definition
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# import posh-docker if it had been installed
if (Get-Module -ListAvailable -Name posh-docker) {
    Import-Module posh-docker
    #Write-Host "Module exists"
} else {
    #Write-Host "Module does not exist"
    # install here if wanted
}