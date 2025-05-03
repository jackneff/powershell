#region Script Settings
#<ScriptSettings xmlns="http://tempuri.org/ScriptSettings.xsd">
#  <ScriptPackager>
#    <process>powershell.exe</process>
#    <arguments />
#    <extractdir>%TEMP%</extractdir>
#    <files />
#    <usedefaulticon>true</usedefaulticon>
#    <showinsystray>false</showinsystray>
#    <altcreds>false</altcreds>
#    <efs>true</efs>
#    <ntfs>true</ntfs>
#    <local>false</local>
#    <abortonfail>true</abortonfail>
#    <product />
#    <version>1.0.0.1</version>
#    <versionstring />
#    <comments />
#    <company />
#    <includeinterpreter>false</includeinterpreter>
#    <forcecomregistration>false</forcecomregistration>
#    <consolemode>false</consolemode>
#    <EnableChangelog>false</EnableChangelog>
#    <AutoBackup>false</AutoBackup>
#    <snapinforce>false</snapinforce>
#    <snapinshowprogress>false</snapinshowprogress>
#    <snapinautoadd>2</snapinautoadd>
#    <snapinpermanentpath />
#    <cpumode>1</cpumode>
#    <hidepsconsole>false</hidepsconsole>
#  </ScriptPackager>
#</ScriptSettings>
#endregion

#region ScriptForm Designer

#region Constructor

[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

#endregion

#region Post-Constructor Custom Code

#endregion

#region Form Creation
#Warning: It is recommended that changes inside this region be handled using the ScriptForm Designer.
#When working with the ScriptForm designer this region and any changes within may be overwritten.
#~~< Form1 >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Form1 = New-Object System.Windows.Forms.Form
$Form1.ClientSize = New-Object System.Drawing.Size(342, 523)
$Form1.Text = "Comp-Sci Student Acount Delete"
#~~< Label2 >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Label2 = New-Object System.Windows.Forms.Label
$Label2.Font = New-Object System.Drawing.Font("Tahoma", 8.25, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$Label2.Location = New-Object System.Drawing.Point(26, 4)
$Label2.Size = New-Object System.Drawing.Size(287, 21)
$Label2.TabIndex = 7
$Label2.Text = "Running as:  "
$Label2.TextAlign = [System.Drawing.ContentAlignment]::TopRight
#~~< StatusBar1 >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$StatusBar1 = New-Object System.Windows.Forms.StatusBar
$StatusBar1.Dock = [System.Windows.Forms.DockStyle]::Bottom
$StatusBar1.Location = New-Object System.Drawing.Point(0, 501)
$StatusBar1.Size = New-Object System.Drawing.Size(342, 22)
$StatusBar1.TabIndex = 6
$StatusBar1.Text = "StatusBar1"
#~~< Label1 >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Label1 = New-Object System.Windows.Forms.Label
$Label1.Location = New-Object System.Drawing.Point(25, 25)
$Label1.Size = New-Object System.Drawing.Size(100, 23)
$Label1.TabIndex = 5
$Label1.Text = "Student Accounts:"
$Label1.TextAlign = [System.Drawing.ContentAlignment]::BottomLeft
#~~< DataGrid1 >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$DataGrid1 = New-Object System.Windows.Forms.DataGrid
$DataGrid1.DataMember = ""
$DataGrid1.Location = New-Object System.Drawing.Point(25, 60)
$DataGrid1.Size = New-Object System.Drawing.Size(289, 374)
$DataGrid1.TabIndex = 4
$DataGrid1.HeaderForeColor = [System.Drawing.SystemColors]::ControlText
#~~< components >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$components = New-Object System.ComponentModel.Container
#~~< ToolTip1 >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ToolTip1 = New-Object System.Windows.Forms.ToolTip($components)
$ToolTip1.add_Popup({ToolTip1OnPopup($ToolTip1)})
$ToolTip1.SetToolTip($DataGrid1, "Hold CTRL button for multiple selection")
#~~< Button1 >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Button1 = New-Object System.Windows.Forms.Button
$Button1.Location = New-Object System.Drawing.Point(25, 449)
$Button1.Size = New-Object System.Drawing.Size(289, 38)
$Button1.TabIndex = 3
$Button1.Text = "Remove"
$Button1.UseVisualStyleBackColor = $true
$Form1.Controls.Add($Label2)
$Form1.Controls.Add($StatusBar1)
$Form1.Controls.Add($Label1)
$Form1.Controls.Add($DataGrid1)
$Form1.Controls.Add($Button1)

#endregion

#region Custom Code

#endregion

#region Event Loop

function Main{
	[System.Windows.Forms.Application]::EnableVisualStyles()
	[System.Windows.Forms.Application]::Run($Form1)
}

#endregion

#endregion

#region Event Handlers

function ToolTip1OnPopup( $object ){

}

Main # This call must remain below all other event functions

#endregion

$schoolsOU = "OU=Schools,DC=cs,DC=fcps,DC=org"
$schoolName = ""
$studentsOU = "OU=Students,OU=$schoolName," + $schoolsOU   