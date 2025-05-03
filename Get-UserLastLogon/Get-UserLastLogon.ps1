
function Get-UserLastLogon {

    <#
  .SYNOPSIS
  Gets the last user to logon from SCCM.
  .DESCRIPTION
  Gets the last user to logon from SCCM.
  .EXAMPLE
  Get-UserLastLogon -Computername ABCDEFG12345
  .EXAMPLE
  Get-Content somfile.txt | Get-UserLastLogon
  .PARAMETER Computername
  The computer name to query. Just one.
  #>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = 'Computer name or IP?')]
        [Alias('Host')]
        [Alias('C')]
        [ValidateLength(3, 30)]
        [string[]]$Computername
    )

    BEGIN {

        $SCCMServer = "sccmserver"
        $SCCMNamespace = "root\sms\site_104"

        $Results = @()
    }

    PROCESS {

        Foreach ($computer in $Computername) {

            Write-Verbose "Now working on $computer"

            $SMSQuery = "Select * from SMS_R_System where SMS_R_System.Name like '%$computer%'"
            $SMSObj = gwmi -Namespace $SCCMNamespace -ComputerName $SCCMServer -Query $SMSQuery

            if ($SMSObj) {
                $UserLastLogon = $SMSObj.LastLogonUsername
            }
            else {
                $UserLastLogon = "Not found"
            }

            $hash = @{
                "Computername"  = $SMSObj.Name
                "UserLastLogon" = $UserLastLogon
            }

            $Results += New-Object -Type PSObject -Property $hash

        }

        Write-Output $Results

    }
}