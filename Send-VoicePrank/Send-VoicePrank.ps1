
function VoicePrank{
    param(
        [Parameter(Position=1)][string]$ComputerName='localhost',
        [Parameter(Position=2)][string]$Message='Test',
        [Parameter(Position=3)][int]$Volume=100,
        [Parameter(Position=4)][int]$Rate=-2
    )

    if (-not(Test-Path "c:\pstools\psexec.exe")){ 
        Write-Host "Error!  C:\PSTools\PSExec.exe missing."
        Write-Host "PSExec is required for this prank.  Download PSExec from sysinternals website"
        return
    }
    
    $code = "Set voice = CreateObject(`"SAPI.SpVoice`")`r`n"
    $code += "voice.Rate = $Rate`r`n"
    $code += "voice.Volume = $Volume`r`n"
    $code += "voice.Speak `"$Message`"`r`n"

    $FolderPath = "\\$ComputerName\c$\vp"

    if (-not(Test-Path $FolderPath)){ New-Item -Path $FolderPath -ItemType Directory -Force }
    
    Set-Content -Path "\\$ComputerName\c$\vp\vp.vbs" -Value $code -Force

    if ($ComputerName -eq 'localhost'){
            & C:\vp\vp.vbs
    } else {
        Invoke-Expression "c:\pstools\psexec.exe \\$ComputerName cscript.exe c:\vp\vp.vbs -i -h"
    }

}


