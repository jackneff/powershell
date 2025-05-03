function JavaToU45 {
    param ($computer)
    $instance = gwmi -ComputerName $computer -Class win32_product | where { $_.name -like "java*" }

    if ($instance.version -ne "7.0.450") {

        #Get rid of it
        $instance.uninstall()

        #Then install Java 7 update 45
        Copy-Item -path '\\host\ConfigMgr\SMSPKG\1040020B' -destination "\\$computer\c$\TEMP" -Recurse
        Set-Content "\\$computer\c$\TEMP\install.bat" -value 'c:\TEMP\javaRE7.exe /s'
        Invoke-Command -ComputerName $computer -ScriptBlock { Start-Process 'c:\TEMP\install.bat' -Wait }
        Remove-Item "\\$computer\c$\TEMP" -Recurse
    }
    else {
        Write-Output "$computer java version already at $($instance.version)"
    }
}

JavaToU45