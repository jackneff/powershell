function Get-UserInfo {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $true, ValueFromPipeLine = $true)]$Username)

    $ADSearchBase = "OU"

    foreach ($Name in $Username) {
        $ADUserObj = Get-ADUser -Filter "Name -like '*$Name*'" -SearchBase $ADSearchBase -SearchScope Subtree -Properties *
        if ($ADUserObj -ne $null) {
            foreach ($Obj in $ADUserObj) {
                Write-Output $Obj | select Name, SAMAccountName, EmailAddress, UserPrincipalName, Enabled, OfficePhone, StreetAddress
            }
        }
        else {
            Write-Verbose "Zero objects returned"
        }
    }
}