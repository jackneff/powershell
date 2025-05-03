$KeyPaths = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*","HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"

$Software = $KeyPaths | %{ Get-ItemProperty $_ | where {$_.Displayname} | select Displayname,DisplayVersion,InstallDate,UninstallString }

Write-Output $Software