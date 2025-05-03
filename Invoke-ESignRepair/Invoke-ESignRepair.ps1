$scripts = "\\techshare\Scripts"

."\\$scripts\Get-InstalledSoftware.ps1"
."\\$scripts\Deploy-Package.ps1"
."\\$scripts\Get-PingStatus.ps1"

function Invoke-ESignRepair {

    [CmdletBinding()]
    param ([Parameter(Mandatory = $true, ValuefromPipeline = $true)]$Computername)

    foreach ($Computer in $Computername) {
        $Ping = Get-PingStatus -Computername $Computer
        if ($Ping.Status -eq "Up") {
            Write-Output "..Looking for e-Sign software"
            $eSign = Get-InstalledSoftware -Computername $Computer -Filter "e-Sign"
            if ($eSign) {
                Write-Host "..e-Sign found starting Re-installation process`n..Please wait this can take up to 60 seconds to complete"
                $results = $eSign.Reinstall(5)
                if ($results.ReturnValue -eq 0) {
                    Write-Host "..Resintall successful!!"
                }
                else {
                    Write-Host "..Reinstall may not be successful" -ForegroundColor Red
                }
            }
            else {
                Write-Host "..Looking for ApproveIt"
                $approveIT = Get-InstalledSoftware -Computername $Computer -Filter "ApproveIt"
                if ($approveIT) {
                    Write-Host "..Uninstalling ApproveIt"
                    $results = $approveIT.Uninstall()
                    if ($results.ReturnValue -eq 0) {
                        Write-Host "..Installing Silanis e-Sign"
                        Deploy-Package -Computers $Computer -Repository SoftwareDist -Package e-Sign -NoMetrics | Out-Null
                        Write-Host "..e-Sign install initiated, should complete in a few seconds"
                    }
                }
                else {
                    Write-Host "ApproveIt not found"
                    Write-Host "Installing Silanis e-Sign"
                    Deploy-Package -Computers $Computer -Repository SoftwareDist -Package e-Sign -NoMetrics | Out-Null
                    Write-Host "..e-Sign install initiated, should complete in a few seconds"
                }
            }
        }
        else {
            Write-Output "..$Computer failed ping test"
        }
    }
}