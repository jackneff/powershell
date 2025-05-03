$global:SearchString = "Adobe Flash"
$Version = "14.0.0.125"
$IntDir = "C:\TEMP"

function FetchKeys {
        Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall | 
        Get-ItemProperty | where { $_.DisplayName -match $SearchString }
}

#This loop will run the msi uninstall for all instances of Flash
FetchKeys $SearchString | ForEach-Object {
        $uninst = $_.UninstallString
        & cmd /c $uninst /quiet /norestart
}

#Loop thru again to get any remaining old keys and delete them
FetchKeys $SearchString | ForEach-Object {
        Remove-Item -Path $_.PSPath -Recurse -Force
}

Start-Sleep -Seconds 20

#Install latest version of flash
& cmd /c "c:\temp\Adobe_FlashPlayer_14.0.0.125.EXE /s /a /p /inv1"
