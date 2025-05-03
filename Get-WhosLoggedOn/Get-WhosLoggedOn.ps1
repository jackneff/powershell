function Get-WhosLoggedOn {
    [CmdletBinding()]
    param
    ([Parameter(Mandatory = $True, ValueFromPipeline = $True)] [string[]]$Computername)
    ."\\TechShare\Scripts\Get-PingStatus.ps1"
    foreach ($Computer in $Computername) {
        $obj = $null
        if ((Get-PingStatus -Computername $Computer).Status -eq "Up") {
            $wmi = Get-WmiObject -ComputerName $Computer -ClassName Win32_ComputerSystem
            $obj = @{ Computername = $Computer; LoggedOnUser = $wmi.UserName }
            Write-Output (New-Object PSObject -Property $obj)
        }
    }
}