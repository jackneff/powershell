$Profiles = Get-WmiObject -Class Win32_UserProfile
$NumDays = 5
$DateTimeString = Get-Date -Format u
$CutoffDate = (Get-Date).AddDays(-$NumDays)
$LogFile = "C:\ProfileDeletion.log"

#If a log file doesn't exist, create one
if (-not(Test-Path -Path $LogFile)){
    New-Item -Path $LogFile -ItemType File -Value "$DateTimeString`tLog file created" | Out-Null
}

#Cycle thru each profile and delete it if it's older than the cutoff date
foreach ($Profile in $Profiles){
    $SID = New-Object System.Security.Principal.SecurityIdentifier($Profile.Sid)
    $ProfileName = $SID.Translate([System.Security.Principal.NTAccount])
    $Name = $ProfileName.Value.Split("\")[1]
    if (($Profile.Special -eq $false) -and ($Profile.LastUseTime -lt $CutoffDate) -and ($Name -notmatch "admin")){
        try {
            $Profile.Delete()
            "$DateTimeString`t$Name`tSuccessfully Deleted" | Out-File $LogFile -Append
        } catch {
            "$DateTimeString`t$Name`tDelete Failed" | Out-File $LogFile -Append
        }
    }
}
