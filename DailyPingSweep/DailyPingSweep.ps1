#region Worker Functions

ipmo activedirectory

function Get-PingStatus {

    [CmdletBinding()]

    param (

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = "Computer name or IP?")]
        [Alias('C')]
        [ValidateLength(3, 30)]
        [String[]]$Computername

    )

    BEGIN {

        $Ping = New-Object System.Net.Networkinformation.ping
    }

    PROCESS {

        foreach ($computer in $Computername) {

            try {
                $Status = $Ping.Send($computer, 500) | select -Expand Status
            }
            catch {
                $Status = "Failed"
            }

            $hash = @{
                "Computername" = $computer
                "Status"       = $Status
            }

            $Result = New-Object -Type PSObject -Property $hash

            Write-Output $Result
        }
    }
}

function Send-Email($body) {
 
    #SMTP server name
    $smtpServer = "smtp.constoso.com"
 
    #Creating a Mail object
    $msg = new-object Net.Mail.MailMessage
 
    #Creating SMTP server object
    $smtp = new-object Net.Mail.SmtpClient($smtpServer)
 
    #Email structure 
    $msg.From = "dailyping@company.com"
    $msg.ReplyTo = "noreply@company.com"
    $msg.To.Add("recipient@company.com")
    $msg.subject = "Daily Ping Sweep Report"
    $msg.body = $body
 
    #Sending email 
    $smtp.Send($msg)
  
}

function Get-Workstations {

    $searchBase = "OU"

    #Get workstations only from ADUC
    $workstations = Get-ADComputer -SearchBase $searchBase -Properties * -Filter {
        (OperatingSystem -notlike "*Server*") -and 
        (OperatingSystem -notlike "*Linux*") -and
        (OperatingSystem -notlike "unknown") }

    #Remove virtual machines and test machines
    $workstations = $workstations | where { ($_.name -notmatch "V0") -and ($_.name -notmatch "VE") -and ($_.name -notmatch "VT") -and
                                        ($_.name -notmatch "VM") -and ($_.name -notmatch "test") -and ($_.name -notmatch "VDI") }
    
    Return $workstations

}

#endregion Worker Functions

function Main {

    $ScanDate = Get-Date -Format "yyyy-MM-dd"

    $StartTime = Get-Date -Format "%H:mm"

    $Tenants = "ABC", "DEF", "HIJ"

    Write-Host "Retrieving workstations from Active Directory"
    $Computers = Get-Workstations

    $Results = @()

    foreach ($Tenant in $Tenants) {

        Write-Host "Now working on $Tenant"

        $ScanTime = Get-Date -Format "%H:mm"

        [int]$ScanHour = Get-Date -Format "%H"

        if (($ScanHour -ge 6) -and ($ScanHour -le 18)) {
            $DayorNight = "Day"
        }
        else {
            $DayorNight = "Night"
        }

        Write-Host "  Filtering computers"
        $TenantComputers = $Computers | where { $_.Name -match $Tenant }

        Write-Host "  Counting notebooks"
        $Notebooks = $TenantComputers | where { $_.Name -match "NB" }

        Write-Host "  Performing ping sweep"
        $Ping = Get-PingStatus ($TenantComputers | select -Expand Name) | ? { $_.Status -eq "Success" }


        $hash = [ordered]@{

            "ScanDate"   = $ScanDate
            "ScanTime"   = $ScanTime
            "Day/Night"  = $DayorNight
            "TenantName" = $Tenant
            "Computers"  = $TenantComputers.Count
            "Pinged"     = $Ping.Count
            "Online%"    = "{0:P0}" -f ($Ping.Count / $TenantComputers.Count)
            "Notebooks"  = $Notebooks.Count

        }

        $Results += New-Object PSObject -Property $hash

    }

    #Uncomment this to enable email feature
    #$EmailBody = $Results | ft -auto | Out-String
    #Send-Email $EmailBody

    $ReportFile = "\\server\Desktop Support\PUBLIC\PowershellReports\DailyPingSweep\DailyPingSweep.csv"

    $Results | Export-Csv -Path $ReportFile -Append -NoTypeInformation

}

Main