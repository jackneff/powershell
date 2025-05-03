$AddressList = @(
    "www.google.com", 
    "www.youtube.com", 
    "www.pokemon.com",
    "www.disney.com"
)

$Results = @()

foreach ($A in $AddressList) {

    $Record = Resolve-DnsName $A | Where-Object { $_.Type -eq "A" } | Select-Object -First 1

    $IP = $Record.IPAddress

    $Interface = Find-NetRoute -RemoteIPAddress $IP | Select-Object IPAddress, InterfaceIndex, InterfaceAlias, InterfaceMetric, AddressState, NextHop 

    $InterfaceIndex = $Interface.InterfaceIndex 
    
    $NetAdapter = Get-NetAdapter -InterfaceIndex $InterfaceIndex

    $Results += [pscustomobject]@{

        "Address"              = $A
        "IPAddress"            = $IP
        "InterfaceIndex"       = $InterfaceIndex | Select-Object -First 1
        "InterfaceAlias"       = $Interface.InterfaceAlias | Select-Object -First 1
        "InterfaceDescription" = $NetAdapter.InterfaceDescription
        "InterfaceMetric"      = $Interface.InterfaceMetric | Select-Object -First 1
        "AddressState"         = $Interface.AddressState | Select-Object -First 1
        "NextHop"              = $Interface.NextHop | Select-Object -First 1

    }

}


$Results | Sort-Object -Property Address | Format-Table