function Invoke-SCCMRepair {
  <#
  .SYNOPSIS
  Repairs sccm client
  .DESCRIPTION
  Repairs sccm client
  .EXAMPLE
  Get-Content somelist.txt | SCCM-Repair
  .PARAMETER computername
  The computer name to query. Just one.
  #>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True,
        ValueFromPipelineByPropertyName=$True,
            HelpMessage='What computer name would you like to target?')]
        [Alias('host')]
        [ValidateLength(3,30)]
        [string[]]$computername
    )

    begin {}

    process {

        write-verbose "Beginning process loop"

        foreach ($computer in $computername) {
            Write-Verbose "Processing $computer"
      
            if (Test-Connection $computer -Count 1 -Quiet){
                Write-Verbose "$computer online"
                if (Test-Path "\\$computer\c$\windows\syswow64\ccm\ccmrepair.exe"){
                    Write-Host "Repairing SCCM client on $computer..."
                    icm -ComputerName $computer -ScriptBlock {c:\windows\syswow64\ccm\ccmrepair.exe}

                } else {
                    Write-Verbose "CCMRepair.exe file doesn't exist on target"
                }
            }
        }
    }

    end {}
}