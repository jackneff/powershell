
$Computers = Get-Content -Path "$PSScriptRoot\test.txt" | Select -first 20

$filenames = "vpnclient_setup"

$Ping = New-Object System.Net.Networkinformation.ping

$arrayJobs = @()

foreach ($computer in $Computers){

    while((Get-Job -State 'Running').Count -ge 25){ 
            Write-Host "Max concurrent jobs reached, pausing for a moment..."
            Start-Sleep -Seconds 5 
    }

    $PingTest = $null
    Trap {Continue} $PingTest = $Ping.Send($Computer,3000,[byte[]][char[]]"z"*16)

    if (($PingTest) -and ($PingTest.Status -eq 'Success')){
        Write-Host "$Computer pingable"
        $arrayJobs += Get-Wmiobject -namespace "root\CIMV2" -computername $Computer -Query "Select * from CIM_DataFile Where Extension = 'pdf'" -AsJob
    } else {
        Write-Host "$Computer not-pingable"
    }
}

$complete = $false
while(-not $complete){
    $arrayJobsInProgress = $arrayJobs |
        Where-Object { $_.State -match 'running'}
        if (-not $arrayJobsInProgress) {"All Jobs Have Complete"; $complete = $true}
}

$arrayJobs

#$results = $arrayJobs |  Receive-Job

foreach ($result in $results) {
    if ($filenames -contains $_.Filename) { 
        $SystemHasFiles
    } else { 

    }
}