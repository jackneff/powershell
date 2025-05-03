
function Get-ComputerUserInfo {

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = 'Computer name or IP?')]
        [Alias('U')]
        [ValidateLength(3, 30)]
        [string[]]$Computername
    )

    BEGIN {

        ipmo activedirectory

        $SCCMServer = "servername"
        $SCCMNamespace = "root\sms\site_104"

        $Results = @()

    }

    PROCESS {

        foreach ($computer in $computername) {

            Write-Verbose "Now working on $computer"
            
            #Get computer ADUC description
            $ADCompObj = Get-ADComputer $Computer -Properties *

            #Get user last logon
            $SMSQuery = "Select * from SMS_R_System where SMS_R_System.Name like '%$computer%'"
            $SMSObj = gwmi -Namespace $SCCMNamespace -ComputerName $SCCMServer -Query $SMSQuery

            if ($SMSObj) {
                $UserLastLogon = $SMSObj.LastLogonUsername
            }

            #Get user email from ADUC
            if ($UserLastLogon) {
                $ADUserObj = Get-ADUser $UserLastLogon -Properties EmailAddress
            }

            $hash = [ordered]@{
                "Computername"  = $computer
                "AD_Desc"       = $ADCompObj.Description
                "UserLastLogon" = $UserLastLogon
                "UserEmail"     = $ADUserObj.EmailAddress
            }

            $Results += New-Object PSObject -Property $hash

            Clear-Variable ADCompObj, ADUserObj, UserLastLogon

        } #end foreach

    }

    END {
        Write-Output $Results
    }
}