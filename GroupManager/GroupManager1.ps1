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
$Form1.ClientSize = New-Object System.Drawing.Size(284, 424)
$Form1.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedToolWindow
$Form1.Text = "Group Manager"
#~~< Btn_Remove >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Btn_Remove = New-Object System.Windows.Forms.Button
$Btn_Remove.Location = New-Object System.Drawing.Point(119, 364)
$Btn_Remove.Size = New-Object System.Drawing.Size(142, 23)
$Btn_Remove.TabIndex = 6
$Btn_Remove.Text = "Remove Selected"
$Btn_Remove.UseVisualStyleBackColor = $true
$Btn_Remove.add_Click({RemoveMember($Btn_Remove)})
#~~< Btn_AddMember >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Btn_AddMember = New-Object System.Windows.Forms.Button
$Btn_AddMember.Location = New-Object System.Drawing.Point(209, 78)
$Btn_AddMember.Size = New-Object System.Drawing.Size(52, 23)
$Btn_AddMember.TabIndex = 5
$Btn_AddMember.Text = "Add+"
$Btn_AddMember.UseVisualStyleBackColor = $true
$Btn_AddMember.add_Click({AddMember($Btn_AddMember)})
#~~< Lbl_Members >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Lbl_Members = New-Object System.Windows.Forms.Label
$Lbl_Members.Location = New-Object System.Drawing.Point(25, 78)
$Lbl_Members.Size = New-Object System.Drawing.Size(100, 23)
$Lbl_Members.TabIndex = 4
$Lbl_Members.Text = "Members:"
$Lbl_Members.TextAlign = [System.Drawing.ContentAlignment]::BottomLeft
#~~< StatusBar >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$StatusBar = New-Object System.Windows.Forms.StatusBar
$StatusBar.Dock = [System.Windows.Forms.DockStyle]::Bottom
$StatusBar.Location = New-Object System.Drawing.Point(0, 402)
$StatusBar.Size = New-Object System.Drawing.Size(284, 22)
$StatusBar.TabIndex = 3
$StatusBar.Text = ""
#~~< ListBox1 >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ListBox1 = New-Object System.Windows.Forms.ListBox
$ListBox1.FormattingEnabled = $true
$ListBox1.Location = New-Object System.Drawing.Point(25, 111)
$ListBox1.ScrollAlwaysVisible = $true
$ListBox1.SelectedIndex = -1
$ListBox1.SelectionMode = [System.Windows.Forms.SelectionMode]::MultiExtended
$ListBox1.Size = New-Object System.Drawing.Size(236, 238)
$ListBox1.TabIndex = 2
#~~< Lbl_ManagedGroups >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Lbl_ManagedGroups = New-Object System.Windows.Forms.Label
$Lbl_ManagedGroups.Location = New-Object System.Drawing.Point(25, 12)
$Lbl_ManagedGroups.Size = New-Object System.Drawing.Size(236, 23)
$Lbl_ManagedGroups.TabIndex = 1
$Lbl_ManagedGroups.Text = "Managed Groups:"
$Lbl_ManagedGroups.TextAlign = [System.Drawing.ContentAlignment]::BottomLeft
#~~< Combo_Groups >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Combo_Groups = New-Object System.Windows.Forms.ComboBox
$Combo_Groups.FormattingEnabled = $true
$Combo_Groups.Location = New-Object System.Drawing.Point(25, 41)
$Combo_Groups.Size = New-Object System.Drawing.Size(236, 21)
$Combo_Groups.TabIndex = 0
$Combo_Groups.Text = ""
$Combo_Groups.Items.AddRange([System.Object[]](@("Group1", "Group2")))
$Combo_Groups.SelectedIndex = -1
$Combo_Groups.add_SelectedIndexChanged({Get-GroupMembers($Combo_Groups)})
$Form1.Controls.Add($Btn_Remove)
$Form1.Controls.Add($Btn_AddMember)
$Form1.Controls.Add($Lbl_Members)
$Form1.Controls.Add($StatusBar)
$Form1.Controls.Add($ListBox1)
$Form1.Controls.Add($Lbl_ManagedGroups)
$Form1.Controls.Add($Combo_Groups)

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

function RemoveMember( $object ){

}

function AddMember( $object ){

}

function Get-GroupMembers( $object ){

}


Main # This call must remain below all other event functions

#endregion
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

