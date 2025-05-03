function BaselineScan {
    <#
    .SYNOPSIS
    Describe the function here
    .DESCRIPTION
    Describe the function in more detail
    .EXAMPLE
    Give an example of how to use it
    .EXAMPLE
    Give another example of how to use it
    .PARAMETER computername
    The computer name to query. Just one.
    .PARAMETER logname
    The name of a file to write failed computer names to. Defaults to errors.txt.
    #>

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = 'What computer would you like to target?')]
        [Alias('Host')]
        [ValidateLength(3, 30)]
        [string[]]$Computername,

        [Alias('r')]
        [ValidateLength(3, 75)]
        [string]$Report
    )

    BEGIN {

        #If path variable doesn't already have the MBSA directory, add it
        if (!($env:Path.Contains('C:\Program Files\Microsoft Baseline Security Analyzer 2'))) {
            $env:Path += ";C:\Program Files\Microsoft Baseline Security Analyzer 2\"
        }

        if (!((Test-Path "C:\Program Files\Microsoft Baseline Security Analyzer 2") -or 
            (test-path "C:\Program Files(x86)\Microsoft Baseline Security Analyzer 2"))) { 

            Write-Host "`nERROR: MBSA is not installed.  Install it and rerun the script." -ForegroundColor Red
            BREAK
        }

        if (!(Test-Path "swbaseline.csv")) {
            Write-Host "ERROR: Cannot find baseline reference file" -ForegroundColor Red
            BREAK
        }
        else {
            $BaselineReference = ipcsv "swbaseline.csv"
        }
    
        #This helps identify KB numbers inside text strings
        $KBPattern = 'KB\d{4,7}'    

    }

    PROCESS {

        $Microsoft = @()

        foreach ($computer in $Computername) {

            if (!(Test-Connection -ComputerName $computer -Count 1 -Quiet)) {
                Write-Host "Target machine not pingable!" -ForegroundColor Red
                BREAK
            }

            Write-Host "`nBaseline scan started on " $computer.ToUpper() -ForegroundColor Cyan
            Write-Host "-------------------------------------------"

            $cmd = "mbsacli.exe /target $computer /n ***"

            if (Test-Path "$env:TEMP\bscan_$computer.txt") { Remove-Item "$env:TEMP\bscan_$computer.txt" }

            Write-Host "`nScanning for missing Microsoft updates"
   
            iex $cmd 2> $null | Out-File "$env:TEMP\bscan_$computer.txt"

            if ($Report) { Copy-Item "$env:TEMP\bscan_$computer.txt" -Destination $Report -Recurse -Force }
            
            $MBSA_Results = gc "$env:TEMP\bscan_$computer.txt" | where { $_ -cmatch " Missing " }

            Write-Host "Scan complete parsing results"

            if ($MBSA_Results) {

                foreach ($line in $MBSA_Results) {
                    
                    if ($hash) { Clear-Variable hash }

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
                    if ($hash) { $Microsoft += (New-Object -Type PSObject -Property $hash) }
                }
            }
       
            Write-Host "`nMBSA scan complete."


            #######################################################################
            #######################################################################
            ####################    END MBSA START GWMI    ########################
            #######################################################################
            #######################################################################

            Write-Host "`nNow scanning Add/Remove Programs for non-baseline versions"

            $BaselineSWScan = gwmi win32_product -ComputerName $computer

            Write-Host "Program scan finished checking results"

            $nonMicrosoft = @()
            
            foreach ($a in $BaselineReference) {

                if ($hash) { Clear-Variable hash }

                foreach ($b in $BaselineSWScan) {

                    if ($a.Name -eq $b.Name) {

                        if ($a.Version -ne $b.Version) {

                            $hash = @{

                                "Name"            = $b.Name
                                "Version"         = $b.Version
                                "BaselineVersion" = $a.Version
                                
                            }
                        }#end if 2
                    }#end if 1
                }#end foreach 2

                if ($hash) { $nonMicrosoft += (New-Object -Type PSObject -Property $hash) }

            }#end foreach 1



            #######################################################################
            ########################     REPORTING      ###########################
            #######################################################################

            cls 
            Write-Host "Scan results for " $Computer.ToUpper() -ForegroundColor Cyan

            Write-Host "`n--------------------------"
            Write-Host "Missing Microsoft updates: "
            Write-Host "--------------------------"

            if ($Microsoft) {
                Write-Output $Microsoft | ft ID, KB, Severity, Description -AutoSize
            }
            else {
                Write-Host "`nNo microsoft updates required" -ForegroundColor Green
            }
     
            Write-Host "`n-------------------------------------------"
            Write-Host "Add/Remove Programs non-compliant software: "
            Write-Host "-------------------------------------------"

            if ($nonMicrosoft) {
                Write-Output $nonMicrosoft | ft Name, Version, BaselineVersion -AutoSize
            }
            else {
                Write-Host "All software is compliant" -ForegroundColor Green
            }

        }#end foreach
    }

    END {}
}