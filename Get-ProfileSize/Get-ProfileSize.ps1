
$Profile = Get-ChildItem "c:\Users" | sort LastWriteTime -Descending | select -First 1
$Folder = gci "c:\Users\$Profile" -Recurse | Measure-Object -Sum Length

$Hash = [ordered]@{
    CName = $env:COMPUTERNAME
    Profile = $Profile.Name
    Size = "{0:N2}" -f ($Folder.Sum / 1MB)
}

New-Object PSObject -Property $Hash