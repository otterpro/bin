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
