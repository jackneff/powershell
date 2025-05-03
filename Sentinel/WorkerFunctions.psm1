#Sentinel Worker Functions

function CheckWhitelist {

    param ($Group, $Computer)

    $Whitelist = "$PSScriptRoot\Whitelists\$($Group.Name).txt"

    #If a whitelist doesn't exist for this audit group create one
    if (!(Test-Path -Path $Whitelist)) {
        New-Item -Path "$PSScriptRoot\Whitelists" -Name "$($Group.Name).txt" -ItemType File
    }

    $List = gc $Whitelist

    if ($List -contains $Computer) {

        Return $true

    }
    else {

        Return $false
    }

}

function Deploy-Package {

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
        [string]$Patch
    )

    BEGIN {

        if ($Package) {
            $Repository = "\\server\TechShare\APPLICATIONS\FIXES_PATCHES_SERVICE_PACKS\#Packages"
            $pName = $Package
        }
        elseif ($Patch) {
            $Repository = "\\server\TechShare\APPLICATIONS\FIXES_PATCHES_SERVICE_PACKS\#Packages\IAVAs" 
            $pName = $Patch
        }
        else {
            Write-Host "Need to specify -Package or -IAVA" -ForegroundColor Red
        }
        
    }

    PROCESS {

        if (Test-Path "$Repository\$pName") {

            foreach ($computer in $computername) {

                Write-Verbose "Now working on $computer"

                if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {

                    Write-Verbose "Target online, copying files..."

                    $DestPath = "\\$computer\c$\TEMP\"

                    #If TEMP folder already exists delete it b/c it will have another kickoff.bat file in it
                    if (Test-Path $DestPath) { Remove-Item $DestPath -Recurse -Force }

                    Copy-Item -Path "$Repository\$pName" -Destination $DestPath -Recurse

                    Write-Verbose "Kicking off install script"

                    ICM -ComputerName $computer -ScriptBlock { & cmd.exe /c "C:\TEMP\kickoff.bat" } | Out-Null

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
}

function Send-Email {
    param ($StrAddresses, $Subject, $Body)

    $AddressList = @()
    $AddressList = $StrAddresses.Split(";")
    $AddressList = $AddressList | ForEach-Object { $_.Trim() }
 
    #SMTP server name
    $smtpServer = "smtp.yourserver.com"
 
    #Creating a Mail object
    $msg = new-object Net.Mail.MailMessage
 
    #Creating SMTP server object
    $smtp = new-object Net.Mail.SmtpClient($smtpServer)

    #Load the recipient names
    $AddressList | ForEach-Object { $msg.To.Add("$_") }
 
    #Email structure 
    $msg.From = ""
    $msg.ReplyTo = ""
    $msg.Subject = $Subject
    $msg.Body = $Body
 
    #Sending email 
    $smtp.Send($msg)
}

function Invoke-SCCMActions {
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
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = 'What computer name would you like to target?')]
        [Alias('host')]
        [ValidateLength(3, 30)]
        [string[]]$computername
    )

    begin {}

    process {

        write-verbose "Beginning process loop"

        foreach ($computer in $computername) {
            Write-Verbose "Processing $computer"
      
            if (Test-Connection $computer -Count 1 -Quiet) {
                Write-Host "$computer is online, triggering actions:"

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000001}') | Out-Null
                    Write-Host "   HW Inventory Scan - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   HW Inventory Scan - Failed" -ForegroundColor Red
                }

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000002}') | Out-Null
                    Write-Host "   SW Inventory Scan - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   SW Inventory Scan - Failed" -ForegroundColor Red
                }

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000003}') | Out-Null
                    Write-Host "   Discover Data Record - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   Discovery Data Record - Failed" -ForegroundColor Red
                }

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000021}') | Out-Null
                    Write-Host "   Machine Policy Retrieval & Evaluation - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   Machine Policy Retrieval & Evaluation - Failed" -ForegroundColor Red
                }

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000010}') | Out-Null
                    Write-Host "   File Collection - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   File Collection - Failed" -ForegroundColor Red
                }

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000022}') | Out-Null
                    Write-Host "   SW Metering and Usage Report - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   SW Metering and Usage Report - Failed" -ForegroundColor Red
                }

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000113}') | Out-Null
                    Write-Host "   SW Updates Scan - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   SW Updates Scan - Failed" -ForegroundColor Red
                }

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000114}') | Out-Null
                    Write-Host "   SW Updates Store - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   SW Updates Store - Failed" -ForegroundColor Red
                }

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000108}') | Out-Null
                    Write-Host "   SW Updates Deployment - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   SW Updates Deployment - Failed" -ForegroundColor Red
                }

                
            }
            else {

                Write-Verbose "$computer is offline"
            }
        }
    }

    end {}
}

function Deploy-Package2 {

    param ($Computer, $Patch)

    $Repository = "\\server\TechShare\APPLICATIONS\FIXES_PATCHES_SERVICE_PACKS\#Packages\Patches"

    if (Test-Path "\\$Computer\c$\TEMP") {
     
        Remove-Item "\\$Computer\c$\TEMP" -Recurse -Force 
    }

    Copy-Item -Path "$Repository\$Patch" -Destination "\\$Computer\c$\TEMP" -Recurse

    $Job = Invoke-Command -ComputerName $Computer -ScriptBlock { & cmd.exe /c "C:\TEMP\kickoff.bat" } -AsJob
    Wait-Job $Job -Timeout 60
    $Result = Receive-Job $Job 
    Remove-Job $Job

    Write-Output $Result

}
