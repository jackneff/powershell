# Gets uptime for a list of machines

if (-not([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")){   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

if (-not(Test-Path "$PSScriptRoot\computers.txt")){
    Write-Error "File computers.txt not found in script directory"
    Pause
    Break
}

$computers = Get-Content "$PSScriptRoot\computers.txt"

if ($computers -eq $null){
    Write-Error "computers.txt file is blank"
    Pause
    Break
}

$ErrPref = $ErrorActionPreference
$Date = Get-Date -Format "yyyyMMdd-HHmmss"
$UptimeReport = "$PSScriptRoot\Reports\$date-UptimeReport.csv"
$FailReport = "$PSScriptRoot\Reports\$date-failed.txt"
$OfflineReport = "$PSScriptRoot\Reports\$date-offline.txt"

foreach ($computer in $computers){
    if (Test-Connection -ComputerName $computer -Count 1 -Quiet){
        try{
            $ErrorActionPreference = "Stop"
            $wmi = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computer
            if ($wmi -ne $Null){
                    $LastBootTime=$wmi.ConvertToDateTime($wmi.Lastbootuptime)
                    [TimeSpan]$uptime = New-TimeSpan $LastBootTime $(get-date)
                    $obj = New-Object PSObject -Property @{ 
                        Computername=$computer
                        Days=$uptime.days
                        Hours=$uptime.hours
                        Minutes=$uptime.minutes
                        Seconds=$uptime.seconds
                    }
            }
            $obj | select Computername,Days,Hours,Minutes,Seconds | Export-Csv -Path $UptimeReport -NoTypeInformation -Append
            $wmi=$null
            $ErrorActionPreference = $ErrPref

        }
        catch {
            $computer | Out-File $FailReport -Append
            $ErrorActionPreference = $ErrPref
            }
    } else {
        $computer | Out-File $OfflineReport -Append
    }
}

