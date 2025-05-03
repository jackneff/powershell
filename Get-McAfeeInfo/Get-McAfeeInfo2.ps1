
function FetchHBSSValues {
    
    $Key1 = "HKLM:SOFTWARE\Wow6432Node\McAfee"
    $Key2 = "HKLM:SOFTWARE\Wow6432Node\Network Associates\ePolicy Orchestrator\Agent"
    $Key3 = "HKLM:SOFTWARE\Wow6432Node\Network Associates\TVD\Shared Components\Framework"
    $Key4 = "HKLM:SOFTWARE\Wow6432Node\Network Associates\ePolicy Orchestrator\Application Plugins"

    #Fetch all necessary key values
    $AVEngine = Get-ItemProperty -Path "$Key1\AVEngine"
    $HIP = Get-ItemProperty -Path "$Key1\HIP"
    $HIP_Settings = Get-ItemProperty -Path "$Key1\HIP\Config\Settings"
    $Key2Values = Get-ItemProperty -Path $Key2
    $Key3Values = Get-ItemProperty -Path $Key3

    #This string return requires some fancy formatting to make it look like a date   
    $LastAgentToServCom = [datetime]::ParseExact("$($Key2Values.LastPropsVersion)","yyyyMMddHHmmss",$null)

    #Compile values into a hash table
    $Values = [ordered] @{
        Computername = $Key2Values.Computername
        HIPsVersion = $HIP.VERSION
        SecurityContentVersion = $HIP.ContentVersion
        SecurityContentCreated = $HIP.ContentCreated
        McAfeeAgentVersion = $Key3Values.Version
        LastSecurityUpdateCheck = $HIP_Settings.Client_LastPolicyEnforcementTime 
        LastAgentToServerCommunication = "{0:yyyy-MM-dd HH:mm:ss}" -f $LastAgentToServCom
        ScanEngineVersion32bit = "$($AVEngine.EngineVersion32Major).$($AVEngine.EngineVersion32Minor)"
        ScanEngineVersion64bit = "$($AVEngine.EngineVersion64Major).$($AVEngine.EngineVersion64Minor)"
        DATVersion = "$($AVEngine.AVDatVersion).$($AVEngine.AVDatVersionMinor)"
        DATCreatedOn = "{0:yyyy-MM-dd}" -f [datetime]$AVEngine.AVDatDate
    }

    #Add module names and versions to the hash table Values
    Get-ChildItem $Key4 | ForEach-Object {
        if ($_.GetValue('Product Name') -ne $null){
            $ProductName = $_.GetValue('Product Name') -replace '\s',''
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

    foreach ($Computer in $Computername){
        Invoke-Command -ComputerName $Computer -ScriptBlock { FetchHBSSValues }
    }

}