# Hey SysAdmin -
# It's really hard remembering all those different network shares you need to 
# touch every day right?  Well stop crying and fix it.  Just 3 easy steps! 
# 1 - Set your favorite network Locations below
# 2 - Add this script to your powershell profile so it runs when you open powershells
# 3 - Run 'netloc' or 'NetworkLocatrions' command from any powershell to launch a menu 
# to select and open a network location in a windows explorer session
# Don't say 'But what about shortcuts?' this is shorter than shortcuts (and cooler)
# You're welcome  -JN

function NetworkLocations {

    #Locations should be root unc shares (not subfolders inside shares)
    # Some endpoint that will invoke windows auth when path is invoked by the shell below
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
