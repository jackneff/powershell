$EAPref = $ErrorActionPreference
$ErrorActionPreference = "SilentlyContinue"
$C = $env:COMPUTERNAME

Write-Host "$C`: Preparing to uninstall SCCM Client"

Write-Host "$C`: Stopping services"
& sc stop ccmsetup
& sc delete ccmsetup

Write-Host "$C`: Removing certificates"
Remove-Item 'HKLM:\SOFTWARE\Microsoft\SystemCertificates\SMS\Certificates\*’ -Force

Write-Host "$C`: Removing files"
Remove-Item -Path $env:windir\ccm -Recurse -Force
Remove-Item -Path $env:windir\system32\ccm -Recurse -Force
Remove-Item -Path $env:windir\ccmcache -Recurse -Force
Remove-Item -Path $env:windir\ccmsetup -Recurse -Force
Remove-Item -Path $env:windir\system32\ccmsetup -Recurse -Force
Remove-Item -Path $env:windir\smscfg.ini -Force
Remove-Item -Path $env:windir\sms*.mif -Force

Write-Host "$C`: Removing registry keys"
$RegRoot = "HKLM:\Software\Microsoft"
Remove-Item -Path "$RegRoot\ccm" -Recurse -Force
Remove-Item -Path "$RegRoot\ccmsetup" -Recurse -Force
Remove-Item -Path "$RegRoot\sms" -Recurse -Force

Write-Host "$C`: Removing WMI namespaces"
Get-WmiObject -Query "SELECT * FROM __Namespace WHERE Name='CCM'" -Namespace "root" | Remove-WmiObject
Get-WmiObject -Query "SELECT * FROM __Namespace WHERE Name='SMS'" -Namespace "root\cimv2" | Remove-WmiObject

Write-Host "$C`: Repairing WMI"
$Path = 'C:\Windows\System32\wbem'
Stop-Service -Name Winmgmt -Force 
Remove-Item "$Path\repository" -Recurse -Force
& wmiprvse /regserver
Start-Service -Name Winmgmt
Get-ChildItem $Path -Filter *.dll | ForEach-Object { & regsvr32.exe /s $_.FullName } | Out-Null
Get-ChildItem $Path -Filter *.mof | ForEach-Object { & mofcomp.exe $_.FullName } | Out-Null
Get-ChildItem $Path -Filter *.mfl | ForEach-Object { & mofcomp.exe $_.FullName } | Out-Null
& mofcomp.exe 'C:\Program Files\Microsoft Policy Platform\ExtendedStatus.mof' | Out-Null

Write-Host "$C`: Uninstall complete!"

$ErrorActionPreference = $EAPref