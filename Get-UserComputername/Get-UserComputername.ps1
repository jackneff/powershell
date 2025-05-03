# Find a domain user's computername by querying SCCM device database for devices where 'LastLogonUserName' is equal to Username

function Get-UserComputername {

    [CmdletBinding()]
    
    param (
        [Parameter(Mandatory = $true, Position = 0)]$Username,
        [Parameter(Mandatory = $false, Position = 1)]$SCCMServer,
        [Parameter(Mandatory = $false, Position = 2)]$Namespace = "root\sms\site_sitecode"
    )
        
    process {
        Get-CimInstance -ClassName SMS_R_SYSTEM -Namespace $Namespace -ComputerName $SCCMServer -Filter "LastLogonUserName = '$Username'" | Select-Object Name, LastLogonUserName, LastLogonTimestamp
    }
        
}