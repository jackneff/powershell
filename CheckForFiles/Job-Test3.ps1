
#Clear previous jobs
Get-Job -State Completed | Remove-Job

$Computers = Get-Content -Path "$PSScriptRoot\scansystems.txt" #| Select -first 20

#Array of search strings
$filenames = "vpnclient_setup"

$Ping = New-Object System.Net.Networkinformation.ping

foreach ($Computer in $Computers){

    while((Get-Job -State 'Running').Count -ge 25){ 
            Write-Host "Max concurrent jobs reached, pausing for a moment..."
            Start-Sleep -Seconds 5 
    }

    $PingTest = $null
    Trap {Continue} $PingTest = $Ping.Send($Computer,3000,[byte[]][char[]]"z"*16)

    if (($PingTest) -and ($PingTest.Status -eq 'Success')){
        Write-Host "$Computer pingable"
        Invoke-Command -Computername $Computer -Scriptblock { Get-Wmiobject -Namespace "root\CIMV2" -Query "Select * from CIM_DataFile Where Extension = 'pdf'" } -AsJob | Out-Null
    } else {
        Write-Host "$Computer not-pingable"
    }
}

#Here's your pause loop to wait for all the jobs to finish
do { Start-Sleep -Seconds 5; write "Sleeping..." } while (Get-Job -State Running)

$JobResults = Get-Job -State Completed | Receive-Job

$Hits = @()

foreach ($Filename in $Filenames){
    $arr = $JobResults | WHERE { $_.Name -match $Filename }
    if ($arr){
        foreach ($a in $arr){
            $obj = New-Object PSObject -Property @{
                SearchString = $Filename
                Computer = $a.PSComputername
                Filename = $a.Name
            }
        $Hits += $obj
        }
    }
}

Write-Output $Hits | select SearchString,Computer,Filename