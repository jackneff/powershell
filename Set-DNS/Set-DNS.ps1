function Set-DNS {

  param
  (
    [Parameter(Mandatory=$True,
    ValueFromPipeline=$True,
    ValueFromPipelineByPropertyName=$True,
      HelpMessage='What computer name would you like to target?')]
    [Alias('host')]
    [ValidateLength(3,30)]
    [string[]]$Computername,

    [Parameter(Mandatory=$True,
        HelpMessage='Set Mode to Dynamic or Static')]
    [ValidateSet("Dynamic","Static")]
    [switch]$Mode,

    [string[]]$DNS
  )

  PROCESS {

    foreach ($Computer in $Computername) {

    Write-Verbose "Now working $Computer"

    if ($Mode -eq "Static"){

        if ($DNS){

                Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration -ComputerName $Computername | where { $_.IPAddress } | 
                    Invoke-CimMethod -MethodName SetDNSServerSearchOrder -Arguments @{DNSServerSearchOrder = $DNS}
        } else {
            Write-Error "DNS settings not provided"
        }

    } elseif ($Mode -eq "Dynamic"){
    
        Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration -ComputerName $Computername | where { $_.IPAddress } | 
            Invoke-CimMethod -MethodName EnableDHCP

    }


      }
    }
  }