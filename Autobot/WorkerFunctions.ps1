#ALL OUTPUT MUST BE FORMATTED AS HTML


$Script:HTMLHeader = @"
<style>
@charset "UTF-8";

table
{
font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;
border-collapse:collapse;
}
td 
{
font-size:1em;
border:1px solid #98bf21;
padding:5px 5px 5px 5px;
}
th 
{
font-size:1.1em;
text-align:center;
padding-top:5px;
padding-bottom:5px;
padding-right:7px;
padding-left:7px;
background-color:#A7C942;
color:#ffffff;
}
name tr
{
color:#F00000;
background-color:#EAF2D3;
}
</style>
"@
 
function Get-Menu {
    $Options = @()
    $Options += New-Object PSObject -Property @{Keyword="hello";Description="Check if autobot is listening"}
    $Options += New-Object PSObject -Property @{Keyword="menu";Description="Returns a list of available autobot tasks"}
    $Options += New-Object PSObject -Property @{Keyword="ping";Description="Pings a list of machines"}
    $Options += New-Object PSObject -Property @{Keyword="logged on user";Description="Get who is logged on a computer"}
    $Options += New-Object PSObject -Property @{Keyword="search user";Description="Search user account in AD"}
    $Options += New-Object PSObject -Property @{Keyword="search computer";Description="Search computer account in AD"}
    $Options += New-Object PSObject -Property @{Keyword="system info";Description="Get system information on a computer"}
    $Options += New-Object PSObject -Property @{Keyword="unlock user";Description="Unlock user AD account"}
    $Options += New-Object PSObject -Property @{Keyword="remove printer group";Description="Remove printer group from AD"}
    $Options += New-Object PSObject -Property @{Keyword="force gpupdate";Description="Force gpudpate on client computer"}
    $Options += New-Object PSObject -Property @{Keyword="force restart";Description="Force restart on a client computer"}
    $Report = $Options | select Keyword,Description | ConvertTo-Html -Head $Script:HTMLHeader | Out-String
    return $Report
}

function SayHello {
    [string]$Message = "Yes I'm here"
    ConvertTo-Html -Body $Message | Out-String
}

function Get-PingStatus($Items){
    $Results = @()
    foreach ($Item in $Items){
        $Item = $Item.Trim()
        $obj = New-Object PSObject -Property @{
            Item = $Item
            Task = "Ping"
            Status = "Down"
        }
        if (Test-Connection -ComputerName $Item -Count 1 -Quiet) { 
            $obj.status = "Up"
        }
        $Results += $obj
    }
    $Report = $Results | select Item,Task,Status | ConvertTo-Html -Head $Script:HTMLHeader | Out-String
    return $Report
}

function Get-LoggedOnUser($Items){
    $Results = @()
    foreach ($Item in $Items){
        $Item = $Item.Trim()
        $obj = New-Object PSObject -Property @{
            Item = $Item
            Task = "Logged On User"
            PingStatus = "Down"
            Username = ""
        }
        if (Test-Connection -ComputerName $Item -Count 1 -Quiet) { 
            $obj.status = "Up"
            try {
                $Username = Get-WmiObject -ComputerName $Item -Class Win32_ComputerSystem | Select -expand Username
                $obj.Username = $Username -split "\\" | Select -Index 1
            } 
            catch {
                $obj.Username = $Error[0].Exception.Message
            }
        }
        $Results += $obj
    }
    $Report = $Results | select Item,Task,PingStatus,Username | ConvertTo-Html -Head $Script:HTMLHeader | Out-String
    return $Report
}

function Search-User($Items){
    $Results = @()
    $DCs = 'dc1@work.com','dc2@work.com','dc3@work.com'
    foreach ($DC in $DCs){
        foreach ($Item in $Items){
            $Item = $Item.Trim()
            $String = "*$Item*"
            $Username = Get-ADUser -Server $DC -Filter { SamAccountName -like $String } | Select -expand Name

            if ($Username){
                switch ($DC){
                    'msads02.work.com'{$Domain = "ms.work.com"}
                    'esads02.es.work.com'{$Domain = "es.work.com"}
                    'hsmsads02.hsms.work.com'{$Domain = "hsms.work.com"}
                }
                foreach ($Name in $Username){
                    $obj = New-Object PSObject -Property @{
                        Item = $Item
                        Task = "Search user"
                        Username = $Name
                        Domain = $Domain
                    }
                    $Results += $obj
                }
            }
        }
    }
    if ($Results){
        $Report = $Results | select Item,Task,Username,Domain | sort Item | ConvertTo-Html -Head $Script:HTMLHeader | Out-String
    } else {
        $Message = [string]"No items found in active directory"
        $Report = ConvertTo-Html -Body $Message | Out-String
    }
    return $Report
}

function Search-Computer($Items){
    $Results = @()
    foreach ($Item in $Items){
        $Item = $Item.Trim()
        $String = "*$Item*"
        $Computername = Get-ADComputer -Filter { Name -like $String } | Select -Expand Name
        if ($Computername){
            foreach ($Computer in $Computername){
                $obj = New-Object PSObject -Property @{
                    Item = $Item
                    Task = "Search Computer"
                    Computer = $Computer
                }
                $Results += $obj
            }
            $Report = $Results | Select Item,Task,Computer | sort Item | ConvertTo-Html -Head $Script:HTMLHeader | Out-String
        } else {
            $Message = [string]"No items found in active directory"
            $Report = ConvertTo-Html -Body $Message | Out-String
        }
    }
    return $Report
}

function Get-ADUCUser($Items){
    
}

function Get-ADUCComputer($Items){

}

function Get-SystemInfo($Items){
    foreach ($Item in $Items){
        $obj = New-Object PSObject -Property @{
            Item = $Item
            Task = "System Info"
            Make = ""
            Model = ""
            Serial = ""
            Memory = ""
            OS = ""
            Username = ""
            IP = ""
            LastBootTime = ""
            ErrorMessage = ""
        }
        if (Test-Connection -ComputerName $Item -Count 1 -Quiet){
            try {
                $ComputerSystem = Get-WmiObject -ComputerName $Item -Class win32_computersystem -Property *
                $Bios = Get-WmiObject -ComputerName $Item -Class win32_bios
                $NIC = Get-WmiObject -ComputerName $Item -Class win32_networkadapterconfiguration | where {$_.IPAddress}
                $OS = Get-WmiObject -ComputerName $Item -Class win32_operatingsystem
                $obj.Make = $ComputerSystem.Manufacturer
                $obj.Model = $ComputerSystem.Model
                $obj.Serial = $Bios.SerialNumber
                $obj.Memory = "{0:N2}" -f ($ComputerSystem.TotalPhysicalMemory / 1GB)
                $obj.OS = (($o.Name -split "\|" | select -index 0) + "(" + ($o.OSArchitecture) + ")")
                $obj.Username = $ComputerSystem.Username
                $obj.IP = ($NIC.IPAddress | select -Index 0)
                $obj.LastBootTime = ($OS.ConvertToDateTime($OS.LastBootUpTime))
            }
            catch {
                $obj.ErrorMessage = $Error[0].Exception.Message
            }
        } else {
            $obj.ErrorMessage = "Computer offline"
        }
        
        $Report += $obj | select Item,Task,Make,Model,Serial,Memory,OS,Username,IP,LastBootTime,ErrorMessage | ConvertTo-Html -As List -Head $Script:HTMLHeader | Out-String
        $Report += '<br>'
    }
    return $Report
}

function Get-UserComputerName($Items){
    foreach ($Item in $Items){
        $SCCMServer = "CASSCCM01.work.com"
        $SCCMNameSpace="root\sms\site_CAS"
        $Query = "SELECT Name,LastLogonUserName FROM sms_r_system WHERE LastLogonUserName like '%$Item%'"
        $Computers = Get-WmiObject -Namespace $SCCMNameSpace -ComputerName $SCCMServer -Query $Query | Sort-Object LastLogonUsername | Select-Object Name,LastLogonUserName

        foreach ($C in $Computers){
            $Computer = $C.Name
            $LastUser = $C.LastLogonUserName
            if (Test-Connection -ComputerName $Computer -Count 1 -Quiet){
                $Ping = $true
                try {
                    $User = Get-WmiObject -ComputerName $Computer -Class Win32_ComputerSystem -ErrorAction Stop
                    if ($User){
                        $Username = $User | Select-Object -Expand Username | Split-Path -Leaf
                    } else {
                        $Username = "Vacant"
                    }
                }
                catch {
                    $Username = $Error[0].Exception.Message
                }
                
            } else {
                $Ping = $false
                $Username = ""
            }
            $obj = New-Object PSObject -Property @{
                Item = $Item
                Task = "Get User Computername"
                LastUser = $LastUser
                Computername = $Computer
                Ping = $Ping
                CurrentUser = $Username
            }
            $Report += $obj | Select Item,Task,LastUser,Computername,Ping,CurrentUser | ConvertTo-Html -As List -Head $Script:HTMLHeader | Out-String
            $Report += '<br>'
        }
    }
    return $Report
}

function Get-AllComputerUsers($Items){

}

function Unlock-Account($Items){
    $Results = @()
    foreach ($Item in $Items){
        $obj = New-Object PSObject -Property @{
            Item = $Item
            Task = "Unlock Account"
            Success = $false
            ErrorMessage = ""
        }
        try {
            Unlock-ADAccount -Identity galen.neff
            $obj.Success = $true
        }
        catch {
            $obj.ErrorMessage = $Error[0].Exception.Message
        }
        $Results += $obj
    }
    $Report = $Results | select Item,Task,Success,ErrorMessage | ConvertTo-Html -Head $Script:HTMLHeader | Out-String
    return $Report
}

function Add-PrinterGroup($Items){

}

function Remove-PrinterGroup($Items){
    $Results = @()
    foreach ($Item in $Items){
        #Failsafe: If group isn't a printer group break loop
        if ($item -notmatch "Printer"){ Break }
        $obj = New-Object PSObject -Property @{
            Item = $Item
            Task = "Remove Printer Group"
            Success = $false
            ErrorMessage = ""
        }
        try {
            Get-ADGroup -Identity $Item | Remove-ADGroup -Confirm:$false
            $obj.Success = $true
        }
        catch {
            $obj.ErrorMessage = $Error[0].Exception.Message
        }
        $Results += $obj
    }
    $Report = $Results | select Item,Task,Success,ErrorMessage | ConvertTo-Html -Head $Script:HTMLHeader | Out-String
    return $Report
}

function Force-GPupdate {
    $Results = @()
    foreach ($Item in $Items){
        
        $obj = New-Object PSObject -Property @{
            Item = $Item
            Task = "Force GPUpdate"
            Success = $false
            ErrorMessage = ""
        }

        if (Test-Connection -ComputerName $Item -Count 1 -Quiet){
            try {
                & c:\pstools\psexec.exe \\$Item gpudpate /force
                $obj.Success = $true
            }
            catch {
                $obj.ErrorMessage = $Error[0].Exception.Message
            }
        }
        $Results += $obj
    }
    $Report = $Results | select Item,Task,Success,ErrorMessage | ConvertTo-Html -Head $Script:HTMLHeader | Out-String
    return $Report
}

function Remove-SCCMClient {

}

function Force-Restart {

}

function RepairWMI {

}

function View-EventLog {

}