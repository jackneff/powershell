<#
  .SYNOPSIS
  Craleb is the powershell version of Belarc (license-free).  
  .DESCRIPTION
  Craleb generates a report of system properties for hardware, operating system, applications and services.  The idea
  is to capture a snapshot of a systems configuration.
  .EXAMPLE
  Craleb.ps1
  .EXAMPLE
  Craleb.ps1 -Include GroupPolicy,Applications
  .PARAMETER Include
  Use this parameter to include additional information to the report (ex GroupPolicy,Applications,RunningServices)
  .PARAMETER Full
  If you would like all additional information to be included use the -Full parameter
  #>

param([ValidateSet("GroupPolicy","Applications","RunningServices")][string[]]$Include,[switch]$Full)

$System = Get-WmiObject -Class win32_computersystem | select Name,Description,Domain,Manufacturer,Model,SystemType,Username
$Enclosure = Get-WmiObject -Class win32_systemenclosure | select Manufacturer,SMBIOSAssetTag,SerialNumber
$OS = Get-WmiObject -Class win32_operatingsystem | select Caption,Version,OSArchitecture,Description,InstallDate,SerialNumber

$Body = New-Object -Type PSObject -Property @{
    'ComputerName' = $System.Name
    'Description' = $OS.Description
    'Manufacturer' = $System.Manufacturer
    'Model' = $System.Model
    'Serial' = $Enclosure.SerialNumber
    'OSName' = $OS.Caption
    'OSVersion' = $OS.Version
    'OSArchitecture' = $OS.OSArchitecture
} | Select-Object ComputerName,Description,Manufacturer,Model,Serial,OSName,OSVersion,OSArchitecture |
    ConvertTo-Html -Fragment -As List -PreContent "<h2>System Summary</h2>" | Out-String
 
$Baseboard = Get-WmiObject -Class win32_baseboard | select Manufacturer,Product,SerialNumber
$BIOS = Get-WmiObject -Class win32_bios | select Name,Manufacturer,ReleaseDate,SerialNumber

$Body += New-Object -Type PSObject -Property @{
    'Manufacturer' = $Baseboard.Manufacturer
    'Product' = $Baseboard.Product
    'Serial' = $Baseboard.SerialNumber
    'BIOSName' = $BIOS.Name
    'BIOSReleaseDate' = $BIOS.ReleaseDate
} | Select-Object Manufacturer,Product,Serial,BIOSName,BIOSReleaseDate | 
    ConvertTo-Html -Fragment -As List -PreContent "<h2>Motherboard</h2>" | Out-String

$Body += Get-WmiObject -Class win32_processor | 
    Select-Object -Property Name,Manufacturer,NumberOfCores,NumberOfLogicalProcessors,L2CacheSize,L3CacheSize,DataWidth,CurrentClockSpeed,MaxClockSpeed | 
    ConvertTo-Html -Fragment -As List -PreContent "<h2>Processor</h2>" | Out-String


$Body += Get-WmiObject -Class win32_physicalmemory | 
    Select-Object DeviceLocator,@{n='Capacity(GB)';e={$_.capacity/1GB -as [int]}},Speed,SerialNumber | 
    ConvertTo-Html -Fragment -PreContent "<h2>Memory</h2>" | Out-String

$Body += Get-WmiObject -Class win32_logicaldisk | 
    Select-Object Name,Description,FileSystem,@{n='UNCPath';e={$_.providername}},@{n='Size(GB)';e={$_.size/1GB -as [int]}},@{n='FreeSpace(GB)';e={$_.freespace/1GB -as [int]}} | 
    ConvertTo-Html -Fragment -PreContent "<h2>Logical Drives</h2>" | Out-String

$Body += Get-WmiObject -Class win32_diskdrive | 
    Select-Object Model,@{n='Size(GB)';e={$_.size/1GB -as [int]}} | 
    ConvertTo-Html -Fragment -PreContent "<h2>Physical Drives</h2>" | Out-String

$Body += Get-WmiObject -Class win32_cdromdrive | 
    Select-Object Drive,Caption |
    ConvertTo-Html -Fragment -PreContent "<h2>CDROM</h2>" | Out-String

$VideoCard = Get-WmiObject -Class win32_displayconfiguration | select DeviceName,Description
$VideoMode = Get-WmiObject -Class win32_displaycontrollerconfiguration | select VideoMode

$Body += New-Object -Type PSObject -Property @{
    'Adapter' = $VideoCard.DeviceName
    'Mode' = $VideoMode.VideoMode
} | Select-Object Adapter,Mode | 
    ConvertTo-Html -Fragment -As List -PreContent "<h2>Graphics</h2>" | Out-String

$Body += Get-WmiObject -Class win32_desktopmonitor | 
    Select-Object MonitorManufacturer,Name | 
    ConvertTo-Html -Fragment -PreContent "<h2>Displays</h2>" | Out-String

$Body += Get-WmiObject -Class win32_networkadapterconfiguration | where { $_.index -eq 7 } | 
    Select-Object Description,@{n='IPAddress';e={$_.ipaddress.getenumerator()}},@{n='Subnet';e={$_.ipsubnet.getenumerator()}},@{n='Gateway';e={$_.defaultipgateway.getenumerator()}},
    @{n='DNSServers';e={$_.dnsserversearchorder.getenumerator()}},DNSDomain,WINSPrimaryServer,WINSSecondaryServer |
    ConvertTo-Html -Fragment -As List -PreContent "<h2>Network</h2>" | Out-String

$Body += Get-WmiObject -Class win32_printer | 
    Select-Object Name,PortName |
    ConvertTo-Html -Fragment -PreContent "<h2>Printers</h2>" | Out-String

$Body += Get-WmiObject -Class win32_tcpipprinterport | 
    Select-Object Name,HostAddress |
    ConvertTo-Html -Fragment -PreContent "<h2>TCP/IP Printer Ports</h2>" | Out-String

$Body += Get-WmiObject -Class win32_usbcontrollerdevice | ForEach-Object { [wmi] ($_.dependent) } |
    Select-Object Description,DeviceID | 
    ConvertTo-Html -Fragment -As Table -PreContent "<h2>USB Devices</h2>" | Out-String

if (($Include -match 'GroupPolicy') -or ($Full)){
    $rsop_user = gpresult /r /f 
    $rsop_computer = gpresult /r /scope computer /f
    $rsop_user | Out-File "$env:TEMP\rsop_user_report.txt" -Force
    $rsop_computer | Out-File "$env:TEMP\rsop_computer_report.txt" -Force

    $Body += New-Object -Type PSObject -Property @{
        'UserOU' = $rsop_user | Select-String -SimpleMatch "CN=" | Select-Object -Last 1 | Out-String
        'ComputerOU' = $rsop_user | Select-String -SimpleMatch "CN=" | Select-Object -First 1 | Out-String
        'PolicyLastApplied' = $rsop_user | Select-String -SimpleMatch "Last time" | Select-Object -First 1 | Out-String
        'GPServer' = $rsop_user | Select-String -SimpleMatch "Group Policy was applied from" | Select-Object -First 1 | Out-String
    } | Select-Object UserOU,ComputerOU,PolicyLastApplied,GPServer |
        ConvertTo-Html -Fragment -As List -PreContent "<h2>Group Policy</h2>" `
            -PostContent "<span></span><a href=`"$env:TEMP\rsop_user_report.txt`">User Policies Full</a> | <a href=`"$env:TEMP\rsop_user_report.txt`">Computer Policies Full</a>" | Out-String
}

if (($Include -match 'Applications') -or ($Full)){
    $Body += Get-ItemProperty "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*","HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | 
        where {(($_.DisplayName -ne $null) -and ($_.DisplayName -notmatch "Update for") -and ($_.DisplayName -notmatch "Service Pack"))} | 
        Select-Object DisplayName,DisplayVersion,Publisher | sort DisplayName |
        ConvertTo-Html -Fragment -As Table -PreContent "<h2>Installed Applications</h2>" | Out-String
}

if (($Include -match 'RunningServices') -or ($Full)){
    $Body += Get-Service | where {$_.Status -eq "Running"} | Select-Object Name,DisplayName | sort Name | ConvertTo-Html -Fragment -As Table -PreContent "<h2>Running Services</h2>" | Out-String
}

$dt = Get-Date -Format "yyyyMMdd-HHmmss"

$file = "$($env:userprofile)\Desktop\CRALEB_Report_$($dt).html" 

$head = @'
<head>
<style>
    h1 {
        text-align: center;
        font-size: 15pt;
    }
    h2 { 
        font-size: 15pt;
    }
    table {
        Margin: 0px 0px 0px 50px;
        Border: 1px solid rgb(190, 190, 190);
        Font-Family: Tahoma;
        Font-Size: 10pt;
        Background-Color: rgb(252, 252, 252);
    }
    tr:hover td {
        Background-Color: rgb(150, 150, 220);
        Color: rgb(255, 255, 255);
    }
    tr:nth-child(even) {
        Background-Color: rgb(242, 242, 242);
    }
    th {
        Text-Align: Left;
        Color: rgb(150, 150, 220);
        Padding: 1px 4px 1px 4px;
    }
    td {
        Vertical-Align: Top;
        Padding: 1px 4px 1px 4px;
    }
    span {
        display: inline-block;
        width: 50px;
    }
</style>
</head>
'@


ConvertTo-HTML -Head $head -Body "<h1>System Report for $($System.Name)<br>Report Date: $(Get-Date)<br>User Profile: $($System.Username)</h1>" -PostContent $Body | Out-File $file

Invoke-Expression $file
