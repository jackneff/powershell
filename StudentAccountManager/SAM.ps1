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
#~~< SAM >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$SAM = New-Object System.Windows.Forms.Form
$SAM.ClientSize = New-Object System.Drawing.Size(444, 510)
$SAM.Text = "Student Account Manager"
#~~< StatusBar >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$StatusBar = New-Object System.Windows.Forms.StatusBar
$StatusBar.Dock = [System.Windows.Forms.DockStyle]::Bottom
$StatusBar.Location = New-Object System.Drawing.Point(0, 488)
$StatusBar.Size = New-Object System.Drawing.Size(444, 22)
$StatusBar.TabIndex = 6
$StatusBar.Text = ""
#~~< LinkLabel_DeselectAll >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$LinkLabel_DeselectAll = New-Object System.Windows.Forms.LinkLabel
$LinkLabel_DeselectAll.ImageAlign = [System.Drawing.ContentAlignment]::MiddleLeft
$LinkLabel_DeselectAll.Location = New-Object System.Drawing.Point(143, 13)
$LinkLabel_DeselectAll.Size = New-Object System.Drawing.Size(100, 23)
$LinkLabel_DeselectAll.TabIndex = 5
$LinkLabel_DeselectAll.TabStop = $true
$LinkLabel_DeselectAll.Text = "Deselect All"
$LinkLabel_DeselectAll.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
$LinkLabel_DeselectAll.add_LinkClicked({ LinkLabel_DeselectAllLinkClicked($LinkLabel_DeselectAll) })
#~~< Btn_RemoveArchive >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Btn_RemoveArchive = New-Object System.Windows.Forms.Button
$Btn_RemoveArchive.Location = New-Object System.Drawing.Point(269, 39)
$Btn_RemoveArchive.Size = New-Object System.Drawing.Size(150, 40)
$Btn_RemoveArchive.TabIndex = 4
$Btn_RemoveArchive.Text = "Archive/Delete"
$Btn_RemoveArchive.UseVisualStyleBackColor = $true
$Btn_RemoveArchive.add_Click({ Btn_RemoveArchiveClick($Btn_RemoveArchive) })
#~~< ListBox >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ListBox = New-Object System.Windows.Forms.ListBox
$ListBox.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 9.75, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ListBox.FormattingEnabled = $true
$ListBox.ItemHeight = 16
$ListBox.Location = New-Object System.Drawing.Point(25, 39)
$ListBox.SelectedIndex = -1
$ListBox.SelectionMode = [System.Windows.Forms.SelectionMode]::MultiExtended
$ListBox.Size = New-Object System.Drawing.Size(218, 420)
$ListBox.TabIndex = 0
$SAM.Controls.Add($StatusBar)
$SAM.Controls.Add($LinkLabel_DeselectAll)
$SAM.Controls.Add($Btn_RemoveArchive)
$SAM.Controls.Add($ListBox)

#endregion

#region Custom Code

#endregion

#region Event Loop

function Main {
    LoadListBox
    [System.Windows.Forms.Application]::EnableVisualStyles()
    [System.Windows.Forms.Application]::Run($SAM)

}

#endregion

#endregion

#region Event Handlers

function LinkLabel_DeselectAllLinkClicked( $object ) {
    $ListBox.SelectedItems.Clear()
}

function Btn_RemoveArchiveClick( $object ) {
    $Selected = $ListBox.SelectedItems
    $CountSelected = $Selected.Count
    $Choice = [System.Windows.Forms.MessageBox]::Show("You are about to delete $CountSelected accounts.  Do you wish to proceed?", "Warning",
        [System.Windows.Forms.MessageBoxButtons]::YesNoCancel,
        [System.Windows.Forms.MessageBoxIcon]::Warning)

    if ($Choice -eq "Yes") {
        foreach ($Name in $Selected) {
            $StatusBar.Text = "Moving $Name home directory"
            Move-Item -Path "\\$Severname\HOMEDIR$\$Name" -Destination "$Servername\Expired\Students" -Force
            $StatusBar.Text = "Deleting $Name account"
            Get-ADUser -Identity $Name | Remove-ADUser
            $StatusBar.Text = ""
        }
        while ($ListBox.SelectedItems -gt 0) {
            $ListBox.Items.Remove($ListBox.SelectedItems[0])
        }
        $StatusBar.Text = "Process Complete!"
    }
}

function LoadListBox {

    #$Base = "OU=Users,OU=Linganore,OU=HS,OU=Staff,OU=,DC=,DC=org"
    #$Students = Get-ADUser -SearchBase $Base -SearchScope OneLevel -filter * -Properties *
    foreach ($Student in $Students) {
        $ListBox.Items.Add($Student.Name)
    }
    $ListBox.Refresh()

}

Main # This call must remain below all other event functions

#endregion
