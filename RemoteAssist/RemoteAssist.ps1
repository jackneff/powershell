function RemoteAssist {
    param([string]$Computername )
    if ($Computername) {
        & msra.exe /offerra $Computername
    }
    else {
        & msra.exe /offerra
    }
}

Set-Alias -Name ra -Value RemoteAssist