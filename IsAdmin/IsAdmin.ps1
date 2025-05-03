#IsAdmin looks to see if you're running the current script as administrator.  
#If not, it calls Show-RunAsMessage to ask the user if the would like to escalate.

Function Show-RunAsMessage {
    Param($Message)

    $title = "Warning"
    $button = [System.Windows.Forms.MessageBoxButtons]::YesNo
    $icon = [Windows.Forms.MessageBoxIcon]::Warning
    [windows.forms.messagebox]::Show($message, $title, $button, $icon)
}

Add-Type -AssemblyName PresentationFramework
Add-Type –assemblyName Microsoft.VisualBasic
Add-Type –assemblyName System.Windows.Forms

$scriptPath = "Place the path of your script file here."

If ($PSVersionTable.PSVersion.Major -ge 3) {
    If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]"Administrator")) {

        If ((Show-RunAsMessage -Message "You need to run this tool as an administrator.`n Do you want to start it as an administrator?") -eq "YES" -and $Host.Runspace.ApartmentState -eq "STA") {
            Start-Process -File PowerShell.exe -Argument "-STA -noprofile -file $scriptPath" -Verb Runas
            break 
        }
        else {
            $ShowMessage = $True
        }
    }
}
else {
    Show-Error -Message "Please Install Windows Management Framework 3.0"
    Break
}
