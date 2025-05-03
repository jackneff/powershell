function Deploy-Package {
    <#
  .SYNOPSIS
  Deploys a package
  .DESCRIPTION
  Deploys a package
  .EXAMPLE
  PSDeploy -Computername somename -Package Java7
  .EXAMPLE
  Get-Content somfile.txt | PSDeploy -Computername -Package AdobeFlash -LogPath c:\somefolder\somelog.txt
  .PARAMETER Computername
  The computer name to query. Just one.
  .PARAMETER Package
  Name of the package to deploy.
  .PARAMETER LogPath
  [Optional]::Where you want the log file placed.
  #>

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = 'What computer name would you like to target?')]
        [Alias('Host')]
        [ValidateLength(3, 30)]
        [string[]]$Computername,

        [Parameter(Mandatory = $False)]
        [Alias('Patch')]
        [string]$Package,

        [Parameter(Mandatory = $False)]
        [string]$Patch,

        [Parameter(Mandatory = $False)]
        [string]$LogPath
    )

    BEGIN {

        if ($Package) {
            $Repository = "\\server\TechShare\APPLICATIONS\FIXES_PATCHES_SERVICE_PACKS\#Packages"
            $pName = $Package
        }
        elseif ($Patch) {
            $Repository = "\\server\TechShare\APPLICATIONS\FIXES_PATCHES_SERVICE_PACKS\#Packages\Patchs" 
            $pName = $Patch
        }
        else {
            Write-Host "Need to specify -Package or -Patch" -ForegroundColor Red
        }
        
    }

    PROCESS {

        if (Test-Path "$Repository\$pName") {

            foreach ($computer in $computername) {

                Write-Verbose "Now working on $computer"

                if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {

                    Write-Verbose "Target online, copying files..."

                    $DestPath = "\\$computer\c$\TEMP"

                    #If TEMP folder already exists delete it b/c it will have another kickoff.bat file in it
                    if (Test-Path $DestPath) { Remove-Item $DestPath -Recurse -Force }

                    Copy-Item -Path "$Repository\$pName" -Destination $DestPath -Recurse

                    Write-Verbose "Kicking off install script"

                    ICM -ComputerName $computer -ScriptBlock { & cmd.exe /c "c:\nec\kickoff.bat" } | Out-Null

                    Write-Verbose "Install script finished"

                }
                else {

                    Write-Verbose "$computer is offline"

                    if ($LogPath) { "$computer`tOFFLINE" >> $LogPath }
                }
            }
        }
        else {
            Write-Host "ERROR: Cannot access package files!" -ForegroundColor Red 
        }
    }

    END {}
}
