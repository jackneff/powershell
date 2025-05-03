function Get-NetworkSettings {

  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory=$True,
    ValueFromPipeline=$True,
    ValueFromPipelineByPropertyName=$True,
      HelpMessage='What computer name would you like to target?')]
    [Alias('host')]
    [ValidateLength(3,30)]
    [string[]]$Computername
  )

  PROCESS {

    foreach ($Computer in $Computername) {

      Write-Verbose "Processing $Computername"

      $Net = Get-WmiObject Win32_NetworkAdapterConfiguration -ComputerName $Computer

      $Settings = $Net | where {$_.ipaddress -ne $null} | select PSComputername, DHCPEnabled, DHCPServer, DNSDomain, DNSDomainSuffixSearchOrder, 
            DNSServerSearchOrder, IPAddress, WINSPrimaryServer, WINSSecondaryServer, DefaultIPGateway, IPSubnet, MACAddress

      }
      Write-Output $Settings
    }
  }