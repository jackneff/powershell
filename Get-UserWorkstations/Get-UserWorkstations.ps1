function Get-UserWorkstations {

    param ([Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [String[]]$Names)

    foreach ($Name in $Names) {

        $ADUserAcct = Get-ADUser -Filter "Displayname -like '*$Name*'" -SearchBase "OU" -Properties * 

        if ($ADUserAcct) {
            foreach ($Acct in $ADUserAcct) {
                $SAMName = $Acct.sAMAccountName
                $Query = "Select SMS_R_System.Name from SMS_R_System where SMS_R_System.LastLogonUserName like '%$SAMName%'"
                [array]$Computers = Get-WmiObject -ComputerName 'sccm_server' -Namespace 'root\sms\site' -Query $Query
                if ($Computers) {
                    $Obj = [ordered]@{Username = $SAMName; Computers = $Computers.Name }
                    Write-Output (New-Object PSObject -Property $Obj)
                }
            }
        }
        else {
            Write-Host "Name not found"
        }

    }
}
