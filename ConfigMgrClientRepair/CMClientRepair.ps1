
$Script:Root = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

#If script was not started as admin, restart it in escalated shell if(-not([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]"Administrator")){    Start-Process -File PowerShell.exe -Argument " -noprofile -file $($myinvocation.mycommand.definition)" -Verb Runas
    Break   }

function MainMenu {
    Clear-Host
    Write-Host "--------------------------------------"
    Write-Host "--------------MAIN MENU---------------"
    Write-Host "--------------------------------------"
    Write-Host "1.   ConfigMgr FullRip w/ WMI repair"
    Write-Host "2.   ConfigMgr FullRip no WMI repair"
    Write-Host "3.   ConfigMgr Client Install"
    Write-Host "4.   ConfigMgr Client Uninstall"
    Write-Host "5.   ConfigMgr Client Repair"
    Write-Host "6.   ConfigMgr Client Evaluation"
    Write-Host "7.   Restart CcmExec Service"
    Write-Host "8.   Trigger Client Actions"
    Write-Host "9.   Review CCM Logs"
    Write-Host "10.  Review CCMSETUP Logs"
    Write-Host "11.  Repair WMI"
    Write-Host "12.  Exit"
    Write-Host "--------------------------------------"
    Write-Host "--------------------------------------"
    Write-Host "--------------------------------------"
    [int]$Choice = Read-Host "Selection"
    
    switch($Choice){
        1{Uninstall-CMClient; Repair-WMI; Install-CMClient; Prompt}
        2{Uninstall-CMClient; Install-CMClient; Prompt}
        3{Install-CMClient; Prompt}
        4{Uninstall-CMClient; Prompt}
        5{Repair-CMClient; Prompt}
        6{CMClientEval; Prompt}
        7{Restart-CMService; Prompt}
        8{Invoke-CMActions; Prompt}
        9{View-CCMLogs}
        10{View-CCMSetupLogs}
        11{Repair-WMI; Prompt}
        12{Exit-Script}
    }
}

function Prompt{
    do{ $Choice = Read-Host "How would you like to proceed? (1=Return to Main Menu, 2=Exit)" } while(($Choice -ne 1) -and ($Choice -ne 2))
    if ($Choice -eq 1){
        MainMenu
    } else {
        Exit-Script
    }
}


function Install-CMClient{
    Write-Host "Preparing to install CMClient"
    $Site = Get-SiteCode
    $MP = "$($Site)sccm01.fcps.org"
    $CMD = & "$Script:Root\ccmsetup\ccmsetup.exe" /native /mp:$MP /smssitecode=$Site /noservice
    Write-Host "Installing CM client (MP=$($MP),SiteCode=$($Site))"
    & cmd.exe /c $CMD
    Write-Host "CM Client install running"
}

function Uninstall-CMClient{
    Write-Host "Preparing to uninstall CM Client"
    Write-Host "Deleting certificates"
    & "$Script:Root\tools\ccmdelcert.exe"
    Write-Host "Stopping services"
    & cmd.exe /c sc stop ccmsetup
    & cmd.exe /c sc delete ccmsetup
    Write-Host "Removing files"
    Remove-Item -Path $env:windir\ccm -Recurse -Force
    Remove-Item -Path $env:windir\ccmcache -Recurse -Force
    Remove-Item -Path $env:windir\ccmsetup -Recurse -Force
    Remove-Item -Path $env:windir\smscfg.ini -Force
    Remove-Item -Path $env:windir\sms*.mif -Force
    Write-Host "Deleting registry keys"
    $RegRoot = "HKLM:\Software\Microsoft"
    Remove-Item -Path "$RegRoot\ccm" -Recurse -Force
    Remove-Item -Path "$RegRoot\ccmsetup" -Recurse -Force
    Remove-Item -Path "$RegRoot\sms" -Recurse -Force
    Write-Host "Removing WMI namespaces"
    Get-WmiObject -Query "SELECT * FROM __Namespace WHERE Name='CCM'" -Namespace "root" | Remove-WmiObject
    Get-WmiObject -Query "SELECT * FROM __Namespace WHERE Name='SMS'" -Namespace "root\cimv2" | Remove-WmiObject
    Write-Host "CM Client uninstall finished"
}

function Repair-CMClient{
    Write-Host "Running ccmrepair"
    try {
        & $env:windir\ccm\ccmrepair.exe
        Write-Host "Repair finished" 
    } catch {
        $_.Exception.Message
    }

}

function CMClientEval{
    $CCMEval = "$env:windir\ccm\ccmeval.exe"
    if (Test-Path $CCMEval){
        & cmd.exe /c $CCMEval
        & "$Script:Root\tools\cmtrace.exe" "$env:windir\ccm\logs\ccmeval.log"
    } else {
        Write-Error "CCMEval.exe file does not exist"
    }
}

function Restart-CMService{
    try{
        Restart-Service -Name CcmExec -Force
        Write-Host "CcmExec service restarted"
    } catch {
        $_.Exception.Message
    }
}

function Reset-CMClientPolicy{
    try{
        Invoke-WmiMethod -Namespace "Root\CCM" -Class SMS_Client -Name ResetPolicy -ArgumentList 1
        Write-Host "Policy reset"
    } catch {
        $_.Exception.Message
    }
}

function Repair-WMI{
    Write-Host "Stopping services"
    Stop-Service -Name Winmgmt -Force -WarningAction SilentlyContinue
    Remove-Item -Path "$($env:windir)\System32\wbem\repository" -Recurse -Force
    Set-Location "$($env:windir)\System32\wbem"
    Write-Host "Registering DLL files"
    foreach($DLL in (Get-ChildItem -Filter *.dll)){ regsvr32.exe -s $DLL.Name }
    Write-Host "Registering x64 DLL files"
    if((Test-Path "$($env:windir)\SysWOW64\wbem")){
       Set-Location "$($env:windir)\SysWOW64\wbem"
       foreach($DLL in (Get-ChildItem -Filter *.dll)){ regsvr32.exe -s $DLL.Name }
    }
    Write-Host "Resetting WMI repository"
    Invoke-Expression "$($env:windir)\System32\Wbem\winmgmt.exe /resetrepository"
    mofcomp C:\Program Files\Microsoft Policy Platform\SchemaNamespaces.mof
    mofcomp C:\Program Files\Microsoft Policy Platform\ExtendedStatus.mof
    Write-Host "Restarting services"
    Start-Service -Name Winmgmt -WarningAction SilentlyContinue
    Start-Service -Name CcmExec -WarningAction SilentlyContinue
}

function Invoke-CMActions{
    Write-Host "Checking in with the server"
    $ActionCodes="001,002,003,010,021,022,026,027,032,113,114,121"
    foreach ($Code in $ActionCodes){
        $ScheduleID = "{00000000-0000-0000-0000-000000000$Code}"
        ([wmiclass]‘root\ccm:SMS_Client’).TriggerSchedule($ScheduleID)
    }
    Write-Host "Finished"
}

function View-CCMLogs{

}

function View-CCMSetupLogs{

}

function Get-SiteCode{
    $Domain = Get-WmiObject -Class Win23_ComputerSystem | Select-Object -Expand Domain
    switch ($Domain){
        "fcps.org"{
            $SiteCode = 'cfm'
        }
        "es.fcps.org"{
            $SiteCode = 'esm'
        }
        "hsms.fcps.org"{
            if ($Computername -match "ms"){
                $SiteCode = 'msm'
            } elseif ($Computername -match "hs"){
                $SiteCode = 'hsm'
            } else {
                Write-Error "MP could not be determined"
            }
        }
    }
    Write-Output $SiteCode
}

function Exit-Script{
    exit
}


#This function must be last!
############################
MainMenu
############################
