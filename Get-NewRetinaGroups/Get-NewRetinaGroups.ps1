function Get-NewRetinaGroups {

    param
    (
        [Parameter(Mandatory = $True,
            HelpMessage = 'Where do you want to save the text files?')]
        [Alias('SaveTo')]
        [Alias('Export')]
        [string[]]$Path
    )

    if (Test-Path $Path) {

        ipmo "\\techshare\computers.ps1"

        $c = Get-NAEComputers | select Name | sort Name

        $total = $c.count

        [int]$range = $total / 7

        $i = 1
        $g = 1

        foreach ($computer in $c) {
            if ($i -ne $range) {
                $computer.Name | Out-File -FilePath $Path\Group$g.rti -Append
                $i++
            }
            else {
                $i = 1
                $g++
            }
        }

        Write-Host "Finished.  Total of $total computers with $range computers per group."
    
    }
    else {
        Write-Host "Path does not exist!" -ForegroundColor Red
    }
}