$Query.QueryString = 
"Select *
        FROM SMS_R_System INNER JOIN SMS_G_System_Computer_System
        ON SMS_R_System.Netbiosname = SMS_G_System_Computer_System.Name
        WHERE SMS_R_System.Netbiosname like '%$($Computer.Name)'
        "
$s = New-Object System.Management.ManagementObjectSearcher($Query)
$s.Scope.Path = "\\hostname\root\sms\site"
$o = $s.Get()