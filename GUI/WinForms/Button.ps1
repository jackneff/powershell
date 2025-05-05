[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

#~~< Form1 >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Form1 = New-Object System.Windows.Forms.Form
$Form1.Text = "Form1"
#~~< Button1 >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Button1 = New-Object System.Windows.Forms.Button
$Button1.Location = New-Object System.Drawing.Point(80, 54)
$Button1.Size = New-Object System.Drawing.Size(114, 76)
$Button1.TabIndex = 0
$Button1.Text = "Button1"
$Button1.UseVisualStyleBackColor = $true
$Button1.add_Click({ Button1Click($Button1) })
$Form1.Controls.Add($Button1)

function Main {
    [System.Windows.Forms.Application]::EnableVisualStyles()
    [System.Windows.Forms.Application]::Run($Form1)
}

function Button1Click( $object ) {
    # Uses show-command to open a cmdlet as GUI
    # GUIs launching GUIs
    Show-Command Get-Service
}

Main
