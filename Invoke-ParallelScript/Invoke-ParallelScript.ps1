function Invoke-ParallelScript {

    <#
.SYNOPSIS 
    Runs a script on multiple computers 
    
.DESCRIPTION
    Runs the script, waits, then combines the results into a single table

.PARAMETER TargetsCSV
    Path to a csv file with all of the target information (list of host names). By default
    it will look for a 'targets.csv' in the same directory as this script

.PARAMETER ScriptFile
    Path to a powershell script.  The script must only return one pscustomobject

.PARAMETER Wait
    Number of seconds to wait between checking if all jobs are finished (default=5)

.PARAMETER Max
    Max number of times the script will check if the jobs are finished before force exiting (default=20)

.EXAMPLE
    Invoke-ParallelScript -TargetsCSV 'targets.csv' -ScriptFile 'Script.ps1'
#>

    [CmdletBinding()]
    Param (
        [string]$TargetsCSV = "$PSScriptRoot\targets.csv",
        [Parameter(Mandatory = $true)]
        [string]$ScriptFile,
        [int]$Wait = 5,
        [int]$Max = 20
    )

    Begin {

        # Remove any previously run jobs from the current shell environment
        Get-Job | Remove-Job

        $targets = Import-Csv $targetsCSV | Select-Object -ExpandProperty hostname | ForEach-Object { 

            $hostname = $_

            # If line is blank do not add it to targets array
            if ($hostname.Length -lt 1) {
                continue
            }
            # If not blank, trim any whitespace and add to targets array
            else {
                Write-Output $hostname.trim()
            }
        }

        if ( $targets.Length -lt 1) {
            Write-Verbose "Targets list is empty killing script"
            Exit
        }
        else {
            Write-Verbose "Total targets: $($targets.Length)"
        }

    }

    Process {

        Write-Verbose "Starting remote jobs"

        foreach ($target in $targets) {
            try {
                Invoke-Command -AsJob -JobName $_ -ComputerName $target -FilePath $scriptFile | Out-Null
            }
            catch {
                Write-Error -Message "Invocation failed on host: $($target)"
            }
        }

        $jobCount = (Get-Job).count
        Write-Verbose "$($jobCount) jobs started!  Now waiting for them to finish"

        $i = 1

        while ( ($i -le $Max) -and (Get-Job).state.contains("Running") ) {
            Write-Verbose "...waiting... ($i of $Max)"
            $i++
            Start-Sleep -Seconds $Wait
        }

        if ($i -eq $Max) { 
            Write-Error "Timed out waiting for jobs to finish"
        }
        else {
            Write-Verbose "All jobs finished"
        }

    }

    End {

        # Send results to the pipeline
        Get-Job | Receive-Job | Select-Object -Property * -ExcludeProperty RunspaceId, PSShowComputerName | Sort-Object Hostname

    }

}




