function Deploy-Package {
  <#
  .SYNOPSIS
  Deploys packages and runs and install file
  .DESCRIPTION
  Deploys packages to machines using asynchronous jobs.  Will run up to 50 jobs at once and will throttle when it hits its limit.
  .PARAMETER Computers
  An array of computer names
  .PARAMETER Repository
  The specific folder where the package file resides
  .PARAMETER Package
  Name of the package folder
  .PARAMETER List
  Allows you to list the availabe packages in a repository
  .PARAMETER Timeout
  Sets a timeout for the entire cmdlet in minutes.  Default is 60.  Clock starts when all jobs have been initiated.
  .PARAMETER NoMetrics
  Suppresses the metrics in output
  .EXAMPLE
  Deploy to a single machine
  Deploy-Package -Computername Somename -Repository SoftwareDist -Package AdobeFlash -Verbose
  .EXAMPLE
  Deploy to many machines
  Get-Content somfile.txt | Deploy-Package -Repository IAVA -Package 2013-A-0001 -Verbose
  .EXAMPLE
  List available packages from a specific repository
  Deploy-Package -Repository IAVA -List
  .EXAMPLE
  Export results to a csv file to further investigate failed jobs
  Get-Content somelist.txt | Deploy-Package -Repository Microsoft -Package MS-014 -Verbose -NoMetrics | Export-CSV report.csv -noType
  .NOTES
  After the cmdlet is finished, the jobs are left untouched so a user can perform a Recieve-Job to analyze the results.  Howerver,
  those jobs are automatically removed if Deploy-Package is run again so be careful.
  #>

    [CmdletBinding()]
    param
    (
        [Parameter(
            Mandatory=$false,
            Position=1,
            ValueFromPipeline=$True,
            ValueFromPipelineByPropertyName=$True,
            HelpMessage='What Computer name would you like to target?')]
        [Alias('C')]
        [ValidateLength(3,30)]
        [string[]]$Computers,

        [Parameter(Mandatory=$true)]
        [ValidateSet("SoftwareDist","IAVA","Microsoft","Test")]
        [Alias('R')]
        [string]$Repository,

        [Alias('P')]
        [string]$Package,

        [Alias('L')]
        [switch]$List,

        [Alias('T')]
        [int]$Timeout=60,

        [Alias('N')]
        [switch]$NoMetrics
    )

    BEGIN {
        
        $RepoRoot = "\\detrdetddf002\NAE\NEC\TechShare\APPLICATIONS\FIXES_PATCHES_SERVICE_PACKS\#Packages"
        $RepoPath = "$RepoRoot\$Repository"

        if ($List){
            Get-ChildItem $RepoPath | sort Name | Format-Table Name,LastWriteTime -AutoSize
            Break
        } elseif ($Package -eq $null){
            Write-Error "You need to specify either -Package or -List params"
            Break
        }

        $Ping = New-Object System.Net.Networkinformation.ping

        #Clear any previous deploy-package jobs
        Get-Job -Name "dp_*" | Remove-Job -Force

    }

    PROCESS {

        $StartTime = Get-Date

        if (Test-Path "$RepoPath\$Package"){

            foreach ($Computer in $Computers) {

                while((Get-Job -State 'Running').Count -ge 50){ 
                    Write-Verbose "Max concurrent jobs reached, pausing for a moment..."
                    Start-Sleep -Seconds 5 
                }

                $PingTest = $null
                Trap {Continue} $PingTest = $Ping.Send($Computer,3000,[byte[]][char[]]"z"*16)

                if (($PingTest) -and ($PingTest.Status -eq 'Success')){
                    Write-Verbose "$($Computer):  Copying files"
                    $DestPath = "\\$Computer\c$\NEC"
                    #If NEC folder already exists delete it b/c it will have another kickoff.bat file in it
                    if (Test-Path $DestPath){ Remove-Item $DestPath -Recurse -Force }
                    Copy-Item -Path "$RepoPath\$Package" -Destination $DestPath -Recurse
                    Write-Verbose "$($Computer):  Starting install"
                    if (Get-ChildItem -Path "$RepoPath\$Package" -Filter kickoff.ps1){
                        Invoke-Command -ComputerName $Computer -FilePath "\\$Computer\c`$\nec\kickoff.ps1" -AsJob -JobName "dp_$Computer" | Out-Null
                    } else {
                        Invoke-Command -ComputerName $Computer -ScriptBlock {& cmd.exe /c "c:\nec\kickoff.bat"} -AsJob -JobName "dp_$Computer" | Out-Null
                    }
                } else {
                    Write-Verbose "$($Computer):  Not online" 
                }
            }

            Write-Verbose "All jobs have been initiated"

         } else {
            Write-Error "Package name not found"
         }
    }
}
