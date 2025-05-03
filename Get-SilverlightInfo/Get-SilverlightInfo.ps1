$computers = gc C:\temp\silverlight_onlinenow.txt

$arr = @()

foreach ($computer in $computers) {
    
    $obj = New-Object PSObject

    if (Test-Connection -ComputerName $computer -Count 1 -Quiet) { 
        $temp = gwmi win32_product -ComputerName $computer | where { $_.name -eq "Microsoft Silverlight" } | select PSComputerName, Name, Version

        $obj | Add-Member -type NoteProperty -Name ComputerName -Value $computer
        $obj | Add-Member -type NoteProperty -Name Online -Value "Yes"
        $obj | Add-Member -type NoteProperty -Name Product -Value $temp.Name
        $obj | Add-Member -type NoteProperty -Name Version -Value $temp.Version

    }
    else {
        
        $obj | Add-Member -type NoteProperty -Name ComputerName -Value $computer
        $obj | Add-Member -type NoteProperty -Name Online -Value "No"
        $obj | Add-Member -type NoteProperty -Name Product -Value "N/A"
        $obj | Add-Member -type NoteProperty -Name Version -Value "N/A"
    }

    $arr += $obj
}


$arr | Export-Csv c:\temp\silverlight_report4.csv -NoTypeInformation