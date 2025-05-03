function Get-BitlockerKey {

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = 'What computer name would you like to target?')]
        [Alias('c')]
        [ValidateLength(3, 30)]
        [string[]]$Computers
    )


    BEGIN {
        ipmo activedirectory
    }

    PROCESS {
    
        foreach ($Computer in $Computers) {

            [array]$BitlockerKey = Get-ADObject -filter * -SearchBase "OU" -Properties msfve-recoverypassword | 
            where { $_.distinguishedname -match $Computer -and $_.objectclass -eq "msFVE-RecoveryInformation" } | select -ExpandProperty msfve-recoverypassword

            $obj = New-Object PSObject -Property @{
                Computername = $Computer
                BitlockerKey = $BitlockerKey
            }

            $obj
        }
    
    }

}