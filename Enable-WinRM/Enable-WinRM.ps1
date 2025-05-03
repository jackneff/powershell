function Enable-WinRM {
    [CmdletBinding()]
    param([Parameter(Mandatory=$true,ValueFromPipeline=$true)]$Computername)

    foreach ($c in $Computername){
        & c:\pstools\psexec.exe \\$c -s c:\windows\system32\winrm.cmd quickconfig -quiet 2>&1>$null
    }
}