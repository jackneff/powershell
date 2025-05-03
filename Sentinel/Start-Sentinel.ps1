
function Main {

    if (Get-Module WorkerFunctions) { Remove-Module WorkerFunctions }
    Import-Module "$PSScriptRoot\WorkerFunctions.psm1"
    Import-Module ActiveDirectory

    #Check for required files and folders

    if (!(Test-Path "$PSScriptRoot\WorkerFunctions.psm1")) {
        Write-Error "Missing critical files"
        Break
    }

    #Check for whitelist folder. If not exist, create it
    if (!(Test-Path "$PSScriptRoot\Whitelists")) { New-Item -ItemType Folder -Path "$PSScriptRoot" -Name "Whitelists" | Out-Null }

    #If log file doesn't exist, create it
    $ScriptLog = "$PSScriptRoot\Sentinel_log.txt"
    if (!(Test-Path $ScriptLog)) { New-Item -ItemType File -Path "$PSScriptRoot" -Name "Sentinel_log.txt" | Out-Null }
    (Get-Date -Format "yyyy-MM-dd HH:mm:ss") + " | ############ Script Initialized ############" | Out-File $ScriptLog -Append
    
    #Retrieve computers from Active Directory groups with Quarantine in the name
    $QuarantineGroups = Get-ADGroup -Filter "Name -like 'Quarantined Systems*'" -SearchBase "OU" -Properties *
    $Ping = New-Object System.Net.Networkinformation.ping


    #Begin infinite loop!!!

    while ($true) {

        foreach ($Group in $QuarantineGroups) {

            $PackageLocation = "\\server\techshare$\APPLICATIONS\FIXES_PATCHES_SERVICE_PACKS\#Packages\IAVAs\$($Group.Description)"
            $GroupHasAudit = Test-Path -Path "$PackageLocation\Audit.ps1"
            $GroupHasPatch = Test-Path -Path "$PackageLocation\kickoff.bat"
            $ADComputers = $Group | Get-ADGroupMember

            if ($ADComputers) {
           
                foreach ($ADComputer in $ADComputers) { 

                    #Reset variables
                    $Computer = $ADComputer.Name
                    $AuditResult = $null
                    $To = $Group.Info
                    $Summary = $null
                    $OnWhitelist = $null
                    $PingTest = $false
                    $PingTime = $null
                    $Subject = "$($Group.Description) - $Computer - Online Now"
                    $EmailBody = "Computername:`t$Computer`n"
                    $EmailBody += "Group:`t`t$($Group.Name)`n"
                    $SendMail = "No"

                    #If it isn't in the whitelist proceed, else skip it

                    $OnWhitelist = CheckWhitelist $Group $Computer

                    if ($OnWhitelist -eq $false) {

                        Trap { Continue } $PingTest = $Ping.Send($Computer, 3000, [byte[]][char[]]"z" * 16)

                        if ($PingTest.Status -eq "Success") {

                            Write-Host "Ping reply $Computer - $($Group.Description)"

                            $PingTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

                            $EmailBody += "Ping time:`t`t$PingTime`n"


                            #Figure out if the IP is on the VPN segment

                            [int]$Subnet = $PingTest.Address.ToString().Split(".")[2]

                            if (($Subnet -ge 112) -and ($Subnet -le 127)) {

                                $EmailBody += "Note:`t`t`tMachine is connected over VPN`n"

                                    (Get-Date -Format "yyyy-MM-dd HH:mm:ss") + " | $($Group.Description) | $Computer | Ping Reply from subnet: $Subnet (VPN segment)" | Out-File $ScriptLog -Append

                            }
                            else {

                                    
                                    (Get-Date -Format "yyyy-MM-dd HH:mm:ss") + " | $($Group.Description) | $Computer | Ping Reply from subnet: $Subnet" | Out-File $ScriptLog -Append
                            }

                            #Find out if the target machine still needs the patch.  Audit returns "true" if it does.

                            if ($GroupHasAudit) {

                                Write-Host "  Sending Audit"

                                $Job = Invoke-Command -ComputerName $Computer -FilePath "$PackageLocation\Audit.ps1" -AsJob
                                Wait-Job $Job -Timeout 60
                                Stop-Job $Job
                                $AuditResult = Receive-Job $Job
                                Remove-Job $Job

                                Write-Host "  Audit finished"

                                #If the Audits finds that the target does not have the patch and
                                #a package is provided it will attempt to deploy the package

                                if ($AuditResult -ne $null) {

                                    if ($AuditResult -eq $false) {
                                    
                                        ##Send-Email to IA that this computer is clean and needs to be added to the whitelist
                                        $To = $Group.Info
                                        $Subject = "$($Group.Description) - $Computer - Already has patch"
                                        $Summary = "Necessary updates have already been applied please confirm with Retina then add it to the whitelist and remove it from the group in AD."
                                    
                                        #If the Audit finds that the computer still needs the patch and a package is available it 
                                        #will attempt to deploy the package

                                    }
                                    else { 

                                        if ($GroupHasPatch) {

                                            Write-Host "  Attempting to patch"

                                            Deploy-Package2 $Computer $($Group.Description)  
                                                
                                            Write-Host "  Performing confirmation audit"
                                            #Send follow up audit to validate package was successful
                                            $Job = Invoke-Command -ComputerName $Computer -FilePath "$PackageLocation\Audit.ps1" -AsJob | Out-Null
                                            Wait-Job $Job -Timeout 60
                                            Stop-Job $Job
                                            $AuditResult = Receive-Job $job
                                            Remove-Job $Job

                                            if ($AuditResult -eq $false) {
                                                #Scenario:  Automatic fix worked.  Send email to add to whitelist.
                                                $To = $Group.Info
                                                $Subject = "$($Group.Description) - $Computer - Successful auto patch"
                                                $Summary = "Machine was successfully patched by Sentinel please confirm with Retina.  Upon a clean scan please add the computer to the whitelist."

                                            }
                                            else {
                                                #Scenario:  Automatic fix was attempted but didn't work
                                                $Summary += "Attempt to deploy patch failed."


                                            }
                                            <#
                                                catch {
                                                    #Scenario: Deploy-Package errored out
                                                    $Summary += "Attempt to deploy patch errored out."
                                                }#>
                                        

                                        }
                                        else {
                                            #Scenario: Computer needs patch but one isn't available.
                                            $Summary = "Computer needs patch but one is not available for this group."
                                        }
                                    } 

                                }
                                else {
                                    Write-Host "  Audit failed"
                                    #Scenario: Audit failed
                                    $Summary = "Audit failed.  Could not determine if it is already patched or not."
                                }

                            }
                            else {
                                #Scenario: No Audit file found for this group
                                $Summary = "This group is not configured with a Audit file."
                            }

                        }
                        else {
                            #Scenario: Ping Failed - do nothing
                            #$Summary = "Ping Failed"
                        }
                    
                    }
                    else { 
                        #Scenario: Computer is already on the whitelist.  Send email to remove machine from security group in ADUC.
                        $Subject = "$($Group.Descrription) - $Computer - Already on whitelist"
                        $Summary = "This computer is already on the whitelist.  Please remove it from the AD group and refresh machine policy."
                    } #end else for if (!($OnWhitelist))


                    #Determine if an email has been sent about this machine in the last 4 hours
                    $LastEntry = gc "$PSScriptRoot\Sentinel_Log.txt" | where { ($_ -match $Group.Description) -and ($_ -match $Computer) -and ($_ -match "Email sent") } | select -Last 1
                    if ($LastEntry) {
                        $a = $LastEntry.Split("|")
                        $dt = [datetime]$a[0]
                        if ($dt -gt (Get-Date).AddHours(-4)) {
                            $SendMail = "No"
                            Write-Host "  Stopped email due to throttle limit"
                        }
                        else {
                            $SendMail = "Yes"
                        }
                    }
                    else {
                        $SendMail = "Yes"
                    }


                    ########################################################
                    #####                 Send Email                   #####
                    ########################################################

                    if ($SendMail -eq "Yes") {
                        if (($OnWhitelist -eq $true) -or ($PingTest.Status -eq "Success")) {

                            Write-Host "  Sending email"
                            $EmailBody += "`n`n" + $Summary
                            Send-Email $To $Subject $EmailBody

                                (Get-Date -Format "yyyy-MM-dd HH:mm:ss") + " | $($Group.Description) | $Computer | Email sent: $Summary" | Out-File $ScriptLog -Append
                        }
                    }

                    ########################################################
                    #####                 Send Email                   #####
                    ########################################################

                       

                } #end foreach ($ADComputer in $ADComputers)

            }
            else {
                #Get-Date -UFormat + ":  $($Group.Name) does not contain any members" | Out-File $ScriptLog -Append
            } #end else for if ($ADComputers)

        } #end foreach ($Group in $QuarantinedGroups)

        Remove-Job -State Completed
        Remove-Job -State Failed
        Write-Host "Sleeping for 5 minutes"
        (Get-Date -Format "yyyy-MM-dd HH:mm:ss") + " | ##################    END PASS    ##################" | Out-File $ScriptLog -Append
        Sleep -Seconds 300 

    } #end infinite while loop

}

Main