$KeyPath = "HKLM:SOFTWARE\Wow6432Node\Network Associates\ePolicy Orchestrator\Application Plugins"
$Values = @()

Get-ChildItem $KeyPath | ForEach-Object {

        $hash = [ordered]@{
            Computername = $Computername 
            Product = $_.GetValue('Product Name')
            SoftwareID = $_.GetValue('Software ID')
            Version = $_.GetValue('Version')
        }

        $obj = New-Object PSObject -Property $hash
        $Values += $obj
}

Write-Output $Values | sort Product