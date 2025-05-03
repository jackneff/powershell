
function FetchHBSSValues {
    
    $Key1 = "HKLM:SOFTWARE\Wow6432Node\McAfee"
    $Key2 = "HKLM:SOFTWARE\Wow6432Node\Network Associates\ePolicy Orchestrator\Agent"
    $Key3 = "HKLM:SOFTWARE\Wow6432Node\Network Associates\TVD\Shared Components\Framework"
    $Key4 = "HKLM:SOFTWARE\Wow6432Node\Network Associates\ePolicy Orchestrator\Application Plugins"

    #Fetch all TEMPessary key values
    $AVEngine = Get-ItemProperty -Path "$Key1\AVEngine"
    $HIP = Get-ItemProperty -Path "$Key1\HIP"
    $HIP_Settings = Get-ItemProperty -Path "$Key1\HIP\Config\Settings"
    $Key2Values = Get-ItemProperty -Path $Key2
    $Key3Values = Get-ItemProperty -Path $Key3

    #This string return requires some fancy formatting to make it look like a date   
    $LastAgentToServCom = [datetime]::ParseExact("$($Key2Values.LastPropsVersion)", "yyyyMMddHHmmss", $null)

    #Compile values into a hash table
    $Values = [ordered]@{
        #Computername = $Key2Values.Computername
        HIPsVersion                    = $HIP.VERSION
        SecurityContentVersion         = $HIP.ContentVersion
        SecurityContentCreated         = $HIP.ContentCreated
        McAfeeAgentVersion             = $Key3Values.Version
        LastSecurityUpdateCheck        = $HIP_Settings.Client_LastPolicyEnforcementTime 
        LastAgentToServerCommunication = "{0:yyyy-MM-dd HH:mm:ss}" -f $LastAgentToServCom
        ScanEngineVersion32bit         = "$($AVEngine.EngineVersion32Major).$($AVEngine.EngineVersion32Minor)"
        ScanEngineVersion64bit         = "$($AVEngine.EngineVersion64Major).$($AVEngine.EngineVersion64Minor)"
        DATVersion                     = "$($AVEngine.AVDatVersion).$($AVEngine.AVDatVersionMinor)"
        DATCreatedOn                   = "{0:yyyy-MM-dd}" -f [datetime]$AVEngine.AVDatDate
    }

    #Add module names and versions to the hash table Values
    Get-ChildItem $Key4 | ForEach-Object {
        if ($_.GetValue('Product Name') -ne $null) {
            $ProductName = $_.GetValue('Product Name') -replace '\s', ''
            $ProductVersion = $_.GetValue('Version')
            $Values += @{
                $ProductName = $ProductVersion
            }
        }
    }


    Write-Output (New-Object -Type PSObject -Property $Values)
}

function Get-HBSSInfo {

    param ($Computername)
    
    foreach ($Computer in $Computername) {
        Invoke-Command -ComputerName $Computer -ScriptBlock ${function:FetchHBSSValues}
    }

}

function Invoke-CollectAndSendProps {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $true, ValueFromPipeline = $true)]$Computername)
    foreach ($Computer in $Computername) {
        Invoke-Command -ComputerName $Computer -ScriptBlock { & cmd /c "C:\Program Files (x86)\McAfee\Common Framework\CmdAgent.exe" /p /e /c }
    }
}

function Invoke-McAfeeUpdate {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $true, ValueFromPipeline = $true)]$Computername)
    foreach ($Computer in $Computername) {
        Invoke-Command -ComputerName $Computer -ScriptBlock { & cmd /c "C:\Program Files (x86)\McAfee\VirusScan Enterprise\mcupdate.exe" /update }
    }
}

function Remove-HBSSFrmPkg {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $true, ValueFromPipeline = $true)]$Computername)
    foreach ($Computer in $Computername) {
        Write-Verbose "$($Computer): Starting frmpkg removal job"
        Invoke-Command -ComputerName $Computer -ScriptBlock { & cmd /c "C:\Program Files (x86)\McAfee\Common Framework\FrmInst.exe" /forceuninstall } -AsJob | Out-Null
    }
}

function Install-HBSSFrmPkg {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $true, ValueFromPipeline = $true)]$Computername)
    $InstallFile = "\\techshare\FramePkg.exe"
    if (-not( Test-Path -Path $InstallFile)) { 
        Write-Error "FrmInst.exe file not found terminating script"
        Start-Sleep -Seconds 5
        Break
    }

    foreach ($Computer in $Computername) {
        Write-Verbose "$($Computer): Starting frmpkg install job"
        if (Test-Path -Path "\\$Computer\c$\TEMP") { Remove-Item "\\$Computer\c$\TEMP" -Recurse -Force }
        md "\\$Computer\c$\TEMP" | Out-Null
        Copy-Item -Path $InstallFile -Destination "\\$Computer\c$\TEMP"
        Invoke-Command -ComputerName $Computer -ScriptBlock { & cmd /c "C:\TEMP\FramePkg.exe" } -AsJob | Out-Null
    }
}

function Get-McAfeeServices {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $true, ValueFromPipeline = $true)]$Computername)
    foreach ($Computer in $Computername) {
        Write-Verbose "Fetching McAfee services on $Computer"
        Invoke-Command -ComputerName $Computer -ScriptBlock { Get-Service -DisplayName McAfee* }
    }
}

function Get-HIPSLogs {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $true, ValueFromPipeline = $true)]$Computername, [Parameter(Mandatory = $true)]$Destination)
    foreach ($Computer in $Computername) {
        md "$Destination\$($Computer)_HIPSLogs" | Out-Null
        Copy-Item -Path "C:\Users\All Users\Application Data\mcafee\Host Intrusion Prevention\*" -Destination "$Dest\$($Computer)_HIPSLogs"
    }
}