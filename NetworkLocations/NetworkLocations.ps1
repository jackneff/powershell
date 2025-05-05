# A jump list for common network shares you need to access often

function NetworkLocations {
    # Locations should be root unc shares (not subfolders inside shares)
    # Some endpoint that will invoke windows auth when path is called by the shell below
    $Locations = @(
        "\\localhost\c$"
        "\\server1\c$"
        "\\server2\c$"
        "\\server3\c$"
        "\\server4\c$"
    )
    $Selection = $Locations | Sort-Object | Out-GridView -PassThru 
    Write-Host $Selection
    Invoke-Item $Selection
}

Set-Alias -Name netloc -Value NetworkLocations
#Set-Alias -Name makeyourown -Value NetworkLocations
