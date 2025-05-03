function Get-PingStatus {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [ValidateLength(3,30)]
        [String[]]$Computername
    )

    $Ping = New-Object System.Net.Networkinformation.ping
   
    foreach ($Computer in $Computername){
        try {
            $Ping.Send($computer,500) | Out-Null
            $Status="UP"
        }
        catch {
            $Status = "DOWN"
        }

        $Result = New-Object PSObject -Property @{
            "Computername" = $Computer.ToUpper()
            "Status" = $Status
        }

        Write-Output $Result
    }
}