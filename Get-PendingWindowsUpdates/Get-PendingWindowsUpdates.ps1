# Checks a list of servers from a text file for windows updates that are
# installed and awaiting a restart.  These are usually occassions
# we need to schedule for maintenance windows.
# Run this script on a schedule to get regular reports


# SET TRUE TO ENABLE FILE EXPORT
$ExportToFile = $True
$ExportFilePath = "PendingWindowsUpdatesReport.csv"

# SET TRUE TO ENABLE EMAILS
$SendEmail = $False
$SmtpTo = "helpdesk@yourcompany.com" 
$SmtpFrom = "noreply@yourcompany.com"
$SmtpSubject = 'Windows Updates Pending Install'

$ServerList = Get-Content "Servers.txt"

$Updates = @()
  
try {
    $Updates = Invoke-Command -ComputerName $ServerList {
        
        $Application = Get-WmiObject -Namespace "root\ccm\clientsdk" -Class CCM_SoftwareUpdate 
        
        if (!$Application) {
            $Obj = New-Object PSObject -Property ([ordered]@{      
                    ArticleId   = " - "
                    Publisher   = " - "
                    Software    = " - "
                    Description = " - "
                    State       = " - "
                    StartTime   = " - "
                    DeadLine    = " - "
                })
            $Update = $Obj
        }
        else {
            foreach ($App in $Application) {
                $EvState = Switch ( $App.EvaluationState  ) {
                    '0' { "None" } 
                    '1' { "Available" } 
                    '2' { "Submitted" } 
                    '3' { "Detecting" } 
                    '4' { "PreDownload" } 
                    '5' { "Downloading" } 
                    '6' { "WaitInstall" } 
                    '7' { "Installing" } 
                    '8' { "PendingSoftReboot" } 
                    '9' { "PendingHardReboot" } 
                    '10' { "WaitReboot" } 
                    '11' { "Verifying" } 
                    '12' { "InstallComplete" } 
                    '13' { "Error" } 
                    '14' { "WaitServiceWindow" } 
                    '15' { "WaitUserLogon" } 
                    '16' { "WaitUserLogoff" } 
                    '17' { "WaitJobUserLogon" } 
                    '18' { "WaitUserReconnect" } 
                    '19' { "PendingUserLogoff" } 
                    '20' { "PendingUpdate" } 
                    '21' { "WaitingRetry" } 
                    '22' { "WaitPresModeOff" } 
                    '23' { "WaitForOrchestration" } 
                    default { "Unknown" }
                }

                $StartTime = if ($App.StartTime) { Get-Date ([system.management.managementdatetimeconverter]::todatetime($($App.StartTime))) } else { "None" }
                $Deadline = if ($App.Deadline) { Get-Date ([system.management.managementdatetimeconverter]::todatetime($($App.Deadline))) } else { "None" }
  
                $Obj = New-Object PSObject -Property ([ordered]@{      
                        ArticleId   = $App.ArticleID
                        Publisher   = $App.Publisher
                        Software    = $App.Name
                        Description = $App.Description
                        State       = $EvState
                        StartTime   = $StartTime
                        DeadLine    = $Deadline
                    })
  
                $Update = $Obj
            }
        }

        Write-Output $Update
  
    } -ErrorAction Stop | Select-Object @{n = 'ServerName'; e = { $_.pscomputername } }, ArticleID, Publisher, Software, Description, State, StartTime, DeadLine
}
catch [System.Exception] {
    Write-Host "Error" -BackgroundColor Red -ForegroundColor Yellow
    $_.Exception.Message
}

# DEBUGGING
# Display results
# $Updates | Out-GridView -Title "Updates"
# Export results to CSV
# $Updates | Export-Csv "PendingWindowsUpdates.csv" -Force -NoTypeInformation


################################
################################
# EXPORT CSV
################################
################################

if ($ExportToFile) {
    $Updates | Export-Csv $ExportFilePath -NoTypeInformation -Force
}

################################
################################
# SEND EMAIL
################################
################################

if ($SendEmail) {
    $Head = Get-Content .\style.html
    $Content = $Updates | Sort-Object ServerName | ConvertTo-Html -As Table -Head $Head | Out-String
    $BodyTemplate = Get-Content .\body.html
    $Body = $BodyTemplate -replace "{{CONTENT}}", $Content
    $Message = @{
        SmtpServer = $SmtpServer
        Port       = 25
        To         = $SmtpTo
        From       = $SmtpFrom
        Subject    = $SmtpSubject
        Body       = $Body
        BodyAsHtml = $true
        UseSsl     = $true
    }
    Send-MailMessage @Message
}

  




