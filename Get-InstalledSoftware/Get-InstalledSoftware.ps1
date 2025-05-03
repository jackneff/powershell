function Get-InstalledSoftware {
  <#
  .SYNOPSIS
  Gets a list of software local or remote machine
  .DESCRIPTION
  Gets a list of software on local or remote machine
  .EXAMPLE
  Get-InstalledSoftware -Computername somename | select Name,Version | sort Name | ft -Auto
  Gets all installed software on a remote machine and formats the output.
  .EXAMPLE
  Get-InstalledSoftware -Computername somename -Filter "Java"
  Finds all software with Java in its name.
  .EXAMPLE
  Get-InstalledSoftware -Computername somename -Filter "Java" -Uninstall
  Finds all software with Java in its name and asks the user if they would like to uninstall it.
  .EXAMPLE
  Get-Content .\sometextfile.txt | Get-InstalledSofware -Filter "Java" -Uninstall -NoPrompt -Verbose
  Pulls in a list of computer names, finds all software with Java in the name and uninstalls it without prompting the user.
  .PARAMETER Computername
  The computer name to query. Just one.
  .PARAMETER Name
  Name of the software product.  Can be a partial string.  If contains spaces make sure you "put it in quotes".
  #>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$True,
            ValueFromPipeline=$True,
            ValueFromPipelineByPropertyName=$True,
            HelpMessage='What computer name would you like to target?')]
        [Alias('Host')]
        [ValidateLength(3,30)]
        [string[]]$Computername,

        [Parameter(Mandatory=$False)]
        [Alias('Software')]
        [Alias('Name')]
        [string[]]$Filter,

        [Parameter(Mandatory=$False)]
        [switch]$Uninstall,

        [Parameter(Mandatory=$False)]
        [switch]$NoPrompt


    )

    begin {
        $appArray = @()
    }

    process {

        Write-Verbose "Beginning PROCESS loop"

        foreach ($computer in $computername) {

            Write-Verbose "Now working on $computer"

            if (Test-Connection -ComputerName $computer -Count 1 -Quiet){

                Write-Verbose "$computer is on.  Querying installed applications..."

                if ($Filter){
                    $apps = gwmi -ComputerName $computer -Class win32_product | where {$_.name -like "*$Filter*"}
                } else {
                    $apps = gwmi -ComputerName $computer -Class win32_product
                } 
              
                $appArray += $apps

            } else {
                Write-Verbose "$computer is offline"
            }
        }

        Write-Verbose "Ending PROCESS loop"
    }

    end {

        if ($appArray){
    
            Write-Verbose "Checking for uninstall switch"

            if ($Uninstall){

                Write-Verbose "Uninstall process engaged.  Checking for NoPrompt switch"
            
                if ($NoPrompt){

                    Write-Verbose "NoPrompt switch engaged.  Beginning loop to silently uninstall applications."

                    foreach ($app in $appArray){

                        Write-Verbose "Uninstalling $($app.Name) on $($app.PSComputername)"

                        try {
                            $app.Uninstall() | Out-Null
                            Write-Verbose "Uninstall SUCCESSFUL"
                        }
                        catch {
                            Write-Verbose "Uninstall FAILED"
                        }

                        Write-Verbose "Done with $($app.PSComputername)"
                    }

                    Write-Verbose "Ending app uninstall loop"

                } else {

                    Write-Verbose "NoPrompt switch not engaged, going loud."

                    clear

                    Write-Host "`n!!!!!!!WARNING WARNING WARNING WARNING WARNING WARNING!!!!!!!" -ForegroundColor Yellow
                    Write-Host "!!!!!!!WARNING WARNING WARNING WARNING WARNING WARNING!!!!!!!" -ForegroundColor Yellow
                    Write-Host "!!!!!!!WARNING WARNING WARNING WARNING WARNING WARNING!!!!!!!" -ForegroundColor Yellow
                    Write-host "`nThe following items will be uninstalled:" -ForegroundColor Yellow

                    $appArray | select PSComputername,Name,Version | Sort PSComputername | ft -auto
                
                    do {
                        $answer = Read-Host "Are you sure you want to proceed? (Y or N)"

                        if (($answer -ne 'Y') -and ($answer -ne 'N')){ Write-Host "Invalid answer, try again!" -ForegroundColor Red}

                    } while (($answer -ne 'Y') -and ($answer -ne 'N'))

                
                    if ($answer -eq 'Y'){

                        Write-Verbose "Beginning app uninstall loop"
                    
                        foreach ($app in $appArray){

                            Write-Verbose "Uninstalling $($app.Name) on $($app.PSComputername)"

                            try {
                                $app.Uninstall() | Out-Null
                                Write-Verbose "Uninstall SUCCESSFUL"
                            }
                            catch {
                                Write-Verbose "Uninstall FAILED"
                            }
                        
                        }

                        Write-Verbose "Ending app uninstall loop"

                    } else {
                        Write-Host "`nYou answered No.  Ending function."
                    }
                }

            } else {
                Write-Verbose "Sending results to the pipeline"
                Write-Output $appArray
            }

        } else {
            Write-Output "Software not found"
        }
    }
}
