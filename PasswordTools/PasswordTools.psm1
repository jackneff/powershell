function Get-SecureCredential {

    param($KeyFile, $User, $SecurePw)

    $Key = Get-Content $KeyFile
    $Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, ($SecurePw | ConvertTo-SecureString -Key $Key)

    return $Cred

}

function New-EncryptionKeyFile {

    param([ValidateSet(16, 24, 32)]$Bytes)

    if (!$Bytes) { $Bytes = 32 }

    $Key = New-Object Byte[] $Bytes
    [Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($Key)
    
    return $Key

}

function New-SecurePW {

    param($KeyFile, $ClearTextPw)

    $Key = Get-Content -Path $KeyFile
    $Pass = $ClearTextPw | ConvertTo-SecureString -AsPlainText -Force
    $Pass | ConvertFrom-SecureString -Key $Key
    Write-Output $Pass

}