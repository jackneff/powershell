function Get-CATAInfo {

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
        [Alias('U')]
        [ValidateLength(3, 30)]
        [string[]]$Computername
    )

    BEGIN {

        $s = "\\TechShare\Scripts"

        ipmo activedirectory
        ipmo "$s\Get-UserLastLogon"
        ipmo "$s\Get-InstalledSoftware"

        $Results = @()

    }

    PROCESS {

        foreach ($computer in $computername) {

            Write-Verbose "Now working on $computer"
            
            #Get computer ADUC description
            $ComputerDesc = Get-ADComputer $computer | select -Expand Description

            #Get installed product info
            if (Test-Connection $computer -Count 1 -Quiet) {

                $instSoft = Get-InstalledSoftware -Computername $computer -Name "Adobe Flash"
            }

            #Get user last logon
            $user = Get-UserLastLogon -Computername $computer

            #Get user email from ADUC
            if ($user) {

                $UserEmail = Get-ADUser -Identity $u.UserLastLogon -Properties EmailAddress | select -expand EmailAddress

            }

            $hash = @{
                "Computername"    = $computer
                "Product Name"    = $instSoft.Name
                "Product Version" = $instSoft.Version
                "ComputerADDesc"  = $ComputerDesc
                "UserLastLogon"   = $user.UserLastLogon
                "UserEmail"       = $UserEmail
            }

            $Results += New-Object PSObject -Property $hash

        } #end foreach

        Write-Output $Results


    }
}