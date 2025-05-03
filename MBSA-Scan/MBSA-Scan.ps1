
#If path variable doesn't already have the MBSA directory, add it
if (!($env:Path.Contains('C:\Program Files\Microsoft Baseline Security Analyzer 2'))) {
    $env:Path += "`;C:\Program Files\Microsoft Baseline Security Analyzer 2\"
}


$target = "MACHINENAME"

#This helps identify KB numbers inside text strings
$KBPattern = 'KB\d{4,7}'

$cmd = "mbsacli.exe /target $target /n ***"

$mbsa_results = iex $cmd 2> $null

#2>$null EXPLAINED: 
#Some native commands throw a banner when they start.  Powershell
#interprets it as an error.  By adding the 2> $null it pipes the error message
#into the bitbin and still allows stdout to come through.  Very cool.

$results = @()

foreach ($line in $missing) {

    #Break the line into parts
    $arr = $line.split("|")

    #Extract the KB number from the description field
    $desc = $arr[3].trim()
    $kb = if ($desc -match $KBPattern) { $matches[0] }

    #Put it all back together in a hash table
    $hash = @{
        "ID"          = $arr[1].trim()
        "Status"      = $arr[2].trim()
        "KB"          = $kb
        "Severity"    = $arr[4].trim()
        "Description" = $desc
        
    }

    #Turn the hash into an object and load it into an object array
    $results += (New-Object -Type PSObject -Property $hash)
}

Write-Output $results | ft ID, KB, Status, Severity, Description -AutoSize


