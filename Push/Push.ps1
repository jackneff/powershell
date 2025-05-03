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
#~~< PushMain >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$PushMain = New-Object System.Windows.Forms.Form
$PushMain.ClientSize = New-Object System.Drawing.Size(475, 462)
$PushMain.Text = "Push"
#~~< StatusBar >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$StatusBar = New-Object System.Windows.Forms.StatusBar
$StatusBar.Dock = [System.Windows.Forms.DockStyle]::Bottom
$StatusBar.Location = New-Object System.Drawing.Point(0, 434)
$StatusBar.Size = New-Object System.Drawing.Size(475, 28)
$StatusBar.TabIndex = 9
$StatusBar.Text = ""
#~~< btn_Clear >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$btn_Clear = New-Object System.Windows.Forms.Button
$btn_Clear.Font = New-Object System.Drawing.Font("Tahoma", 8.25, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$btn_Clear.Location = New-Object System.Drawing.Point(280, 379)
$btn_Clear.Size = New-Object System.Drawing.Size(86, 42)
$btn_Clear.TabIndex = 8
$btn_Clear.Text = "Clear"
$btn_Clear.UseVisualStyleBackColor = $true
$btn_Clear.add_Click({Btn_ClearClick($btn_Clear)})
#~~< cb_ViewReport >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$cb_ViewReport = New-Object System.Windows.Forms.CheckBox
$cb_ViewReport.Location = New-Object System.Drawing.Point(12, 380)
$cb_ViewReport.Size = New-Object System.Drawing.Size(104, 24)
$cb_ViewReport.TabIndex = 7
$cb_ViewReport.Text = "View Report"
$cb_ViewReport.UseVisualStyleBackColor = $true
#~~< btn_RunAction >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$btn_RunAction = New-Object System.Windows.Forms.Button
$btn_RunAction.Font = New-Object System.Drawing.Font("Tahoma", 8.25, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$btn_RunAction.Location = New-Object System.Drawing.Point(372, 380)
$btn_RunAction.Size = New-Object System.Drawing.Size(86, 41)
$btn_RunAction.TabIndex = 6
$btn_RunAction.Text = "Run Action"
$btn_RunAction.UseVisualStyleBackColor = $true
$btn_RunAction.add_Click({Btn_RunActionClick($btn_RunAction)})
#~~< group_Action >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$group_Action = New-Object System.Windows.Forms.GroupBox
$group_Action.Location = New-Object System.Drawing.Point(12, 126)
$group_Action.Size = New-Object System.Drawing.Size(446, 249)
$group_Action.TabIndex = 5
$group_Action.TabStop = $false
$group_Action.Text = "Action"
#~~< tb_ScriptDescription >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$tb_ScriptDescription = New-Object System.Windows.Forms.RichTextBox
$tb_ScriptDescription.Location = New-Object System.Drawing.Point(21, 147)
$tb_ScriptDescription.ReadOnly = $true
$tb_ScriptDescription.ScrollBars = [System.Windows.Forms.RichTextBoxScrollBars]::None
$tb_ScriptDescription.Size = New-Object System.Drawing.Size(396, 89)
$tb_ScriptDescription.TabIndex = 11
$tb_ScriptDescription.Text = ""
#~~< cb_Shutdown >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$cb_Shutdown = New-Object System.Windows.Forms.CheckBox
$cb_Shutdown.Location = New-Object System.Drawing.Point(340, 62)
$cb_Shutdown.Size = New-Object System.Drawing.Size(104, 24)
$cb_Shutdown.TabIndex = 10
$cb_Shutdown.Text = "Shutdown"
$cb_Shutdown.UseVisualStyleBackColor = $true
#~~< btn_BrowseScript >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$btn_BrowseScript = New-Object System.Windows.Forms.Button
$btn_BrowseScript.Location = New-Object System.Drawing.Point(343, 111)
$btn_BrowseScript.Size = New-Object System.Drawing.Size(75, 23)
$btn_BrowseScript.TabIndex = 9
$btn_BrowseScript.Text = "Browse"
$btn_BrowseScript.UseVisualStyleBackColor = $true
$btn_BrowseScript.add_Click({Btn_BrowseScriptClick($btn_BrowseScript)})
#~~< lbl_Script >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$lbl_Script = New-Object System.Windows.Forms.Label
$lbl_Script.Location = New-Object System.Drawing.Point(18, 114)
$lbl_Script.Size = New-Object System.Drawing.Size(40, 23)
$lbl_Script.TabIndex = 8
$lbl_Script.Text = "Script:"
#~~< tb_ScriptPath >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$tb_ScriptPath = New-Object System.Windows.Forms.TextBox
$tb_ScriptPath.Location = New-Object System.Drawing.Point(58, 111)
$tb_ScriptPath.Size = New-Object System.Drawing.Size(279, 20)
$tb_ScriptPath.TabIndex = 7
$tb_ScriptPath.Text = ""
#~~< cb_GPUpdate >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$cb_GPUpdate = New-Object System.Windows.Forms.CheckBox
$cb_GPUpdate.Location = New-Object System.Drawing.Point(340, 19)
$cb_GPUpdate.Size = New-Object System.Drawing.Size(100, 24)
$cb_GPUpdate.TabIndex = 6
$cb_GPUpdate.Text = "GP Update"
$cb_GPUpdate.UseVisualStyleBackColor = $true
#~~< cb_EnableWinRM >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$cb_EnableWinRM = New-Object System.Windows.Forms.CheckBox
$cb_EnableWinRM.Location = New-Object System.Drawing.Point(18, 63)
$cb_EnableWinRM.Size = New-Object System.Drawing.Size(104, 24)
$cb_EnableWinRM.TabIndex = 5
$cb_EnableWinRM.Text = "Enable WinRM"
$cb_EnableWinRM.UseVisualStyleBackColor = $true
#~~< cb_Restart >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$cb_Restart = New-Object System.Windows.Forms.CheckBox
$cb_Restart.Location = New-Object System.Drawing.Point(252, 63)
$cb_Restart.Size = New-Object System.Drawing.Size(104, 24)
$cb_Restart.TabIndex = 4
$cb_Restart.Text = "Restart"
$cb_Restart.UseVisualStyleBackColor = $true
#~~< cb_SystemCleanup >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$cb_SystemCleanup = New-Object System.Windows.Forms.CheckBox
$cb_SystemCleanup.Location = New-Object System.Drawing.Point(128, 63)
$cb_SystemCleanup.Size = New-Object System.Drawing.Size(118, 24)
$cb_SystemCleanup.TabIndex = 3
$cb_SystemCleanup.Text = "System Cleanup"
$cb_SystemCleanup.UseVisualStyleBackColor = $true
#~~< cb_Upitme >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$cb_Upitme = New-Object System.Windows.Forms.CheckBox
$cb_Upitme.Location = New-Object System.Drawing.Point(252, 20)
$cb_Upitme.Size = New-Object System.Drawing.Size(104, 24)
$cb_Upitme.TabIndex = 2
$cb_Upitme.Text = "Uptime"
$cb_Upitme.UseVisualStyleBackColor = $true
#~~< cb_LoggedOnUser >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$cb_LoggedOnUser = New-Object System.Windows.Forms.CheckBox
$cb_LoggedOnUser.Location = New-Object System.Drawing.Point(128, 20)
$cb_LoggedOnUser.Size = New-Object System.Drawing.Size(118, 24)
$cb_LoggedOnUser.TabIndex = 1
$cb_LoggedOnUser.Text = "Logged On User"
$cb_LoggedOnUser.UseVisualStyleBackColor = $true
#~~< cb_PingSweep >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$cb_PingSweep = New-Object System.Windows.Forms.CheckBox
$cb_PingSweep.Location = New-Object System.Drawing.Point(18, 20)
$cb_PingSweep.Size = New-Object System.Drawing.Size(104, 24)
$cb_PingSweep.TabIndex = 0
$cb_PingSweep.Text = "Ping Sweep"
$cb_PingSweep.UseVisualStyleBackColor = $true
$group_Action.Controls.Add($tb_ScriptDescription)
$group_Action.Controls.Add($cb_Shutdown)
$group_Action.Controls.Add($btn_BrowseScript)
$group_Action.Controls.Add($lbl_Script)
$group_Action.Controls.Add($tb_ScriptPath)
$group_Action.Controls.Add($cb_GPUpdate)
$group_Action.Controls.Add($cb_EnableWinRM)
$group_Action.Controls.Add($cb_Restart)
$group_Action.Controls.Add($cb_SystemCleanup)
$group_Action.Controls.Add($cb_Upitme)
$group_Action.Controls.Add($cb_LoggedOnUser)
$group_Action.Controls.Add($cb_PingSweep)
#~~< group_Targets >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$group_Targets = New-Object System.Windows.Forms.GroupBox
$group_Targets.Location = New-Object System.Drawing.Point(12, 12)
$group_Targets.Size = New-Object System.Drawing.Size(440, 95)
$group_Targets.TabIndex = 4
$group_Targets.TabStop = $false
$group_Targets.Text = "Targets"
#~~< btn_ClearList >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$btn_ClearList = New-Object System.Windows.Forms.Button
$btn_ClearList.Location = New-Object System.Drawing.Point(181, 55)
$btn_ClearList.Size = New-Object System.Drawing.Size(75, 23)
$btn_ClearList.TabIndex = 6
$btn_ClearList.Text = "Clear List"
$btn_ClearList.UseVisualStyleBackColor = $true
$btn_ClearList.add_Click({Btn_ClearListClick($btn_ClearList)})
#~~< lbl_TargetsLoaded >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$lbl_TargetsLoaded = New-Object System.Windows.Forms.Label
$lbl_TargetsLoaded.Font = New-Object System.Drawing.Font("Tahoma", 8.25, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$lbl_TargetsLoaded.Location = New-Object System.Drawing.Point(273, 55)
$lbl_TargetsLoaded.Size = New-Object System.Drawing.Size(145, 22)
$lbl_TargetsLoaded.TabIndex = 5
$lbl_TargetsLoaded.Text = "Targets Loaded:  0"
$lbl_TargetsLoaded.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
#~~< btn_ImportList >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$btn_ImportList = New-Object System.Windows.Forms.Button
$btn_ImportList.Location = New-Object System.Drawing.Point(18, 55)
$btn_ImportList.Size = New-Object System.Drawing.Size(75, 23)
$btn_ImportList.TabIndex = 4
$btn_ImportList.Text = "Import List"
$btn_ImportList.UseVisualStyleBackColor = $true
$btn_ImportList.add_Click({Btn_ImportListClick($btn_ImportList)})
#~~< btn_AddTarget >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$btn_AddTarget = New-Object System.Windows.Forms.Button
$btn_AddTarget.Location = New-Object System.Drawing.Point(343, 25)
$btn_AddTarget.Size = New-Object System.Drawing.Size(75, 23)
$btn_AddTarget.TabIndex = 1
$btn_AddTarget.Text = "Add"
$btn_AddTarget.UseVisualStyleBackColor = $true
$btn_AddTarget.add_Click({Btn_AddTargetClick($btn_AddTarget)})
#~~< btn_ViewList >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$btn_ViewList = New-Object System.Windows.Forms.Button
$btn_ViewList.Location = New-Object System.Drawing.Point(99, 55)
$btn_ViewList.Size = New-Object System.Drawing.Size(75, 23)
$btn_ViewList.TabIndex = 3
$btn_ViewList.Text = "View List"
$btn_ViewList.UseVisualStyleBackColor = $true
$btn_ViewList.add_Click({Btn_ViewListClick($btn_ViewList)})
#~~< tb_TargetInput >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$tb_TargetInput = New-Object System.Windows.Forms.TextBox
$tb_TargetInput.Location = New-Object System.Drawing.Point(18, 28)
$tb_TargetInput.Size = New-Object System.Drawing.Size(319, 20)
$tb_TargetInput.TabIndex = 0
$tb_TargetInput.Text = ""
$group_Targets.Controls.Add($btn_ClearList)
$group_Targets.Controls.Add($lbl_TargetsLoaded)
$group_Targets.Controls.Add($btn_ImportList)
$group_Targets.Controls.Add($btn_AddTarget)
$group_Targets.Controls.Add($btn_ViewList)
$group_Targets.Controls.Add($tb_TargetInput)
$PushMain.Controls.Add($StatusBar)
$PushMain.Controls.Add($btn_Clear)
$PushMain.Controls.Add($cb_ViewReport)
$PushMain.Controls.Add($btn_RunAction)
$PushMain.Controls.Add($group_Action)
$PushMain.Controls.Add($group_Targets)

#~~< TargetListView >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$TargetListView = New-Object System.Windows.Forms.Form
$TargetListView.ClientSize = New-Object System.Drawing.Size(235, 584)
$TargetListView.Text = "Target List View"
#~~< btn_RemoveTarget >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$btn_RemoveTarget = New-Object System.Windows.Forms.Button
$btn_RemoveTarget.Location = New-Object System.Drawing.Point(10, 20)
$btn_RemoveTarget.Size = New-Object System.Drawing.Size(75, 23)
$btn_RemoveTarget.TabIndex = 2
$btn_RemoveTarget.Text = "Remove"
$btn_RemoveTarget.UseVisualStyleBackColor = $true
$btn_RemoveTarget.add_Click({Btn_RemoveTargetClick($btn_RemoveTarget)})
#~~< CheckedListBox1 >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$CheckedListBox1 = New-Object System.Windows.Forms.CheckedListBox
$CheckedListBox1.FormattingEnabled = $true
$CheckedListBox1.Location = New-Object System.Drawing.Point(12, 49)
$CheckedListBox1.SelectedIndex = -1
$CheckedListBox1.Size = New-Object System.Drawing.Size(210, 514)
$CheckedListBox1.TabIndex = 0
$TargetListView.Controls.Add($btn_RemoveTarget)
$TargetListView.Controls.Add($CheckedListBox1)


#endregion

#region Custom Code

#endregion

#region Event Loop

function Main{
	[System.Windows.Forms.Application]::EnableVisualStyles()
	[System.Windows.Forms.Application]::Run($PushMain)
    [System.Collections.ArrayList]$Global:TargetList = @()        
}

#endregion

#endregion

#region Event Handlers

function MsgBox( $object ){
    [System.Windows.Forms.MessageBox]::Show("$object") 
}

function FolderBrowser {
    [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $browse = New-Object System.Windows.Forms.FolderBrowserDialog
    $browse.RootFolder = [System.Environment+SpecialFolder]'MyComputer'
    $browse.ShowNewFolderButton = $false
    $browse.Description = "Choose a directory"

    $loop = $true
    while($loop){
        if ($browse.ShowDialog() -eq "OK"){
            $loop = $false
        } else {
            return
        }
    }
    $browse.SelectedPath
    $browse.Dispose()
}

function FileBrowser {
    $browse = New-Object System.Windows.Forms.OpenFileDialog
    $loop = $true
    while($loop){
        if ($browse.ShowDialog() -eq "OK"){
            $loop = $false
        } else {
            return
        }
    }
    $browse.FileName
    $browse.Dispose()
}

function Btn_ClearClick( $object ){

}

function Btn_RunActionClick( $object ){

}

function Btn_BrowseScriptClick( $object ){
    $Path = FolderBrowser

    $tb_ScriptPath.Text = $Path

    #Show warning if script file not found
    if (-not(Test-Path $Path\program.ps1)){
        msgBox "Error: Folder does not contain a program.ps1 file"
        $tb_ScriptPath.Text = ""
        $tb_ScriptDescription.Text = ""
    } else {

        #Popluate script description box
        if (Test-Path -Path "$Path\descripton.txt"){
            $tb_ScriptDescription.Text = Get-Content "$Path\description.txt"
        } else {
            $tb_ScriptDescription.Text = "No Description. Use at your own risk."
        }
    }
}

function Btn_ClearListClick( $object ){

}

function Btn_ImportListClick( $object ){
   $tb_TargetInput.Text = FileBrowser
}

function Btn_AddTargetClick( $object ){
    $Global:TargetList += $tb_TargetInput.Text
    $tb_TargetInput.Text = ""
    $LCount = $Global:TargetList.Count
    $lbl_TargetsLoaded.Text = "Targets Loaded: $LCount"
}

function Btn_ViewListClick( $object ){
    $CheckedListBox1.DataSource = $Global:TargetList
    $TargetListView.ShowDialog()
}

Main # This call must remain below all other event functions

#endregion
