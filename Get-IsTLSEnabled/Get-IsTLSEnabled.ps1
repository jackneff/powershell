function Get-IsTLSEnabled {
    $KeyPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client\'
    $TLS12 = Get-ItemProperty $KeyPath
    if (Test-Path -Path $KeyPath) {
        $TLS12Enabled = if ($TLS12.DisabledByDefault -ne 0 -or $TLS12.Enabled -eq 0) { $False } else { $True }
        return $TLS12Enabled
    }
    else {
        Write-Error "Reg key not found"
    }
}