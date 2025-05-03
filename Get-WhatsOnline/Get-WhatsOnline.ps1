function Get-WhatsOnline {
  <#
  .SYNOPSIS
  Takes a list of computer from pipeline and returns only those that are currently online.
  .DESCRIPTION
  Takes a list of computer from pipeline and returns only those that are currently online.
  .EXAMPLE
  Get-Content somelist.txt | Get-WhatsOnline | Out-File report.txt
  .EXAMPLE
  Import-CSV somelist.csv | Foreach { Get-WhatsOnline $_.name } | Get-WhosOnline | Out-File report.txt
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

    begin {
        $onNow = @()
    }

    process {

        write-verbose "Beginning process loop"

        foreach ($computer in $computername) {
            Write-Verbose "Processing $computer"
      
            if (Test-Connection $computer -Count 1 -Quiet){
                $onNow += $computer
            }
        }
    }

    end {
        Write-Output $onNow
    }
}