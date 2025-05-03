
#region Draw Forms

$PushMain = New-Object System.Windows.Forms.Form
$PushMain.ClientSize = New-Object System.Drawing.Size(475, 417)
$PushMain.Text = "Push"
$PushMain.FormBorderStyle = "FixedDialog"

    $group_Computers = New-Object System.Windows.Forms.GroupBox
    $group_Computers.Location = New-Object System.Drawing.Point(12, 12)
    $group_Computers.Size = New-Object System.Drawing.Size(446, 115)
    $group_Computers.TabIndex = 4
    $group_Computers.TabStop = $false
    $group_Computers.Text = "Computers"

        $tb_ComputerInput = New-Object System.Windows.Forms.TextBox
        $tb_ComputerInput.Location = New-Object System.Drawing.Point(18, 28)
        $tb_ComputerInput.Size = New-Object System.Drawing.Size(319, 23)
        $tb_ComputerInput.TabIndex = 0
        $tb_ComputerInput.Text = ""

        $btn_AddComputer = New-Object System.Windows.Forms.Button
        $btn_AddComputer.Location = New-Object System.Drawing.Point(343, 28)
        $btn_AddComputer.Size = New-Object System.Drawing.Size(75, 23)
        $btn_AddComputer.TabIndex = 1
        $btn_AddComputer.Text = "Add"
        $btn_AddComputer.UseVisualStyleBackColor = $true
        $btn_AddComputer.add_Click({Btn_AddComputerClick($btn_AddComputer)})

        $btn_ImportList = New-Object System.Windows.Forms.Button
        $btn_ImportList.Location = New-Object System.Drawing.Point(18, 65)
        $btn_ImportList.Size = New-Object System.Drawing.Size(102, 23)
        $btn_ImportList.TabIndex = 4
        $btn_ImportList.Text = "Import List"
        $btn_ImportList.UseVisualStyleBackColor = $true
        $btn_ImportList.add_Click({Btn_ImportListClick($btn_ImportList)})

        $btn_ViewList = New-Object System.Windows.Forms.Button
        $btn_ViewList.Location = New-Object System.Drawing.Point(126, 65)
        $btn_ViewList.Size = New-Object System.Drawing.Size(102, 23)
        $btn_ViewList.TabIndex = 3
        $btn_ViewList.Text = "View List"
        $btn_ViewList.UseVisualStyleBackColor = $true
        $btn_ViewList.add_Click({Btn_ViewListClick($btn_ViewList)})

        $btn_ClearList = New-Object System.Windows.Forms.Button
        $btn_ClearList.Location = New-Object System.Drawing.Point(234, 65)
        $btn_ClearList.Size = New-Object System.Drawing.Size(102, 23)
        $btn_ClearList.TabIndex = 6
        $btn_ClearList.Text = "Clear List"
        $btn_ClearList.UseVisualStyleBackColor = $true
        $btn_ClearList.add_Click({Btn_ClearListClick($btn_ClearList)})

    $group_Computers.Controls.Add($btn_ClearList)
    $group_Computers.Controls.Add($btn_ImportList)
    $group_Computers.Controls.Add($btn_AddComputer)
    $group_Computers.Controls.Add($btn_ViewList)
    $group_Computers.Controls.Add($tb_ComputerInput)

    $lbl_ComputersInList = New-Object System.Windows.Forms.Label
    $lbl_ComputersInList.Font = New-Object System.Drawing.Font("Tahoma", 8.25, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
    $lbl_ComputersInList.Location = New-Object System.Drawing.Point(280, 130)
    $lbl_ComputersInList.Size = New-Object System.Drawing.Size(170, 22)
    $lbl_ComputersInList.TabIndex = 5
    $lbl_ComputersInList.Text = "Computers In List:  0"
    $lbl_ComputersInList.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
    
    $group_Action = New-Object System.Windows.Forms.GroupBox
    $group_Action.Location = New-Object System.Drawing.Point(12, 155)
    $group_Action.Size = New-Object System.Drawing.Size(446, 225)
    $group_Action.TabIndex = 5
    $group_Action.TabStop = $false
    $group_Action.Text = "Action"

        $lbl_Script = New-Object System.Windows.Forms.Label
        $lbl_Script.Location = New-Object System.Drawing.Point(18, 36)
        $lbl_Script.Size = New-Object System.Drawing.Size(47, 23)
        $lbl_Script.TabIndex = 8
        $lbl_Script.Text = "Script:"

        $tb_ScriptPath = New-Object System.Windows.Forms.TextBox
        $tb_ScriptPath.Location = New-Object System.Drawing.Point(83, 33)
        $tb_ScriptPath.Size = New-Object System.Drawing.Size(254, 23)
        $tb_ScriptPath.TabIndex = 7
        $tb_ScriptPath.Text = ""

        $btn_BrowseScript = New-Object System.Windows.Forms.Button
        $btn_BrowseScript.Location = New-Object System.Drawing.Point(343, 33)
        $btn_BrowseScript.Size = New-Object System.Drawing.Size(75, 23)
        $btn_BrowseScript.TabIndex = 9
        $btn_BrowseScript.Text = "Browse"
        $btn_BrowseScript.UseVisualStyleBackColor = $true
        $btn_BrowseScript.add_Click({Btn_BrowseScriptClick($btn_BrowseScript)})

        $tb_ScriptDescription = New-Object System.Windows.Forms.RichTextBox
        $tb_ScriptDescription.Location = New-Object System.Drawing.Point(18, 81)
        $tb_ScriptDescription.ReadOnly = $true
        $tb_ScriptDescription.ScrollBars = [System.Windows.Forms.RichTextBoxScrollBars]::None
        $tb_ScriptDescription.Size = New-Object System.Drawing.Size(396, 72)
        $tb_ScriptDescription.TabIndex = 11
        $tb_ScriptDescription.Text = ""

    $group_Action.Controls.Add($tb_ScriptDescription)
    $group_Action.Controls.Add($btn_BrowseScript)
    $group_Action.Controls.Add($btn_Clear)
    $group_Action.Controls.Add($lbl_Script)
    $group_Action.Controls.Add($btn_RunAction)
    $group_Action.Controls.Add($tb_ScriptPath)

    $btn_Clear = New-Object System.Windows.Forms.Button
    $btn_Clear.Font = New-Object System.Drawing.Font("Tahoma", 8.25, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
    $btn_Clear.Location = New-Object System.Drawing.Point(235, 169)
    $btn_Clear.Size = New-Object System.Drawing.Size(86, 42)
    $btn_Clear.TabIndex = 8
    $btn_Clear.Text = "Clear"
    $btn_Clear.UseVisualStyleBackColor = $true
    $btn_Clear.add_Click({Btn_ClearClick($btn_Clear)})

    $btn_RunAction = New-Object System.Windows.Forms.Button
    $btn_RunAction.Font = New-Object System.Drawing.Font("Tahoma", 8.25, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
    $btn_RunAction.Location = New-Object System.Drawing.Point(327, 170)
    $btn_RunAction.Size = New-Object System.Drawing.Size(86, 41)
    $btn_RunAction.TabIndex = 6
    $btn_RunAction.Text = "Run"
    $btn_RunAction.UseVisualStyleBackColor = $true
    $btn_RunAction.add_Click({Btn_RunActionClick($btn_RunAction)})

    $StatusBar = New-Object System.Windows.Forms.StatusBar
    $StatusBar.Dock = [System.Windows.Forms.DockStyle]::Bottom
    $StatusBar.Location = New-Object System.Drawing.Point(0, 393)
    $StatusBar.Size = New-Object System.Drawing.Size(475, 24)
    $StatusBar.TabIndex = 9
    $StatusBar.Text = ""

$PushMain.Controls.Add($StatusBar)
$PushMain.Controls.Add($lbl_ComputersInList)
$PushMain.Controls.Add($group_Action)
$PushMain.Controls.Add($group_Computers)


$ComputerList = New-Object System.Windows.Forms.Form
$ComputerList.ClientSize = New-Object System.Drawing.Size(235, 500)
$ComputerList.Text = "Target List View"
$ComputerList.FormBorderStyle = "FixedDialog"

    $btn_PingComputers = New-Object System.Windows.Forms.Button
    $btn_PingComputers.Location = New-Object System.Drawing.Point(10, 20)
    $btn_PingComputers.Size = New-Object System.Drawing.Size(65, 23)
    $btn_PingComputers.TabIndex = 2
    $btn_PingComputers.Text = "Ping"
    $btn_PingComputers.UseVisualStyleBackColor = $true
    $btn_PingComputers.add_Click({Btn_PingComputersClick($btn_PingComputers)})

    $btn_RemoveComputer = New-Object System.Windows.Forms.Button
    $btn_RemoveComputer.Location = New-Object System.Drawing.Point(80, 20)
    $btn_RemoveComputer.Size = New-Object System.Drawing.Size(65, 23)
    $btn_RemoveComputer.TabIndex = 2
    $btn_RemoveComputer.Text = "Remove"
    $btn_RemoveComputer.UseVisualStyleBackColor = $true
    $btn_RemoveComputer.add_Click({Btn_RemoveComputerClick($btn_RemoveComputer)})

    $btn_DeselectAll = New-Object System.Windows.Forms.Button
    $btn_DeselectAll.Location = New-Object System.Drawing.Point(150, 20)
    $btn_DeselectAll.Size = New-Object System.Drawing.Size(80, 23)
    $btn_DeselectAll.TabIndex = 2
    $btn_DeselectAll.Text = "Deselect All"
    $btn_DeselectAll.UseVisualStyleBackColor = $true
    $btn_DeselectAll.add_Click({Btn_DeselectAllClick($btn_DeselectAll)})

    $ListBox1 = New-Object System.Windows.Forms.ListBox
    $ListBox1.FormattingEnabled = $true
    $ListBox1.Location = New-Object System.Drawing.Point(12, 49)
    $ListBox1.SelectedIndex = -1
    $ListBox1.SelectionMode = "MultiExtended"
    $ListBox1.Size = New-Object System.Drawing.Size(210, 450)
    $ListBox1.TabIndex = 0

$ComputerList.Controls.Add($btn_PingComputers)
$ComputerList.Controls.Add($btn_RemoveComputer)
$ComputerList.Controls.Add($btn_DeselectAll)
$ComputerList.Controls.Add($ListBox1)

#endregion

#region Functions

function PushMain{
	[System.Windows.Forms.Application]::EnableVisualStyles()
	[System.Windows.Forms.Application]::Run($PushMain)
    [System.Collections.ArrayList]$Global:TargetList = @()        
}

function Btn_AddComputerClick( $object ){

    $value = $tb_ComputerInput.Text

    if ($value.Length -lt 5){
        MsgBox "Entry is below character limit"
    } else {
        if ($value -match ":"){
            Get-Content $value | ForEach-Object { $ListBox1.Items.Add($_) }
            UpdateComputerListCount
            $tb_ComputerInput.Text = ""
        } else {
            $ListBox1.Items.Add($value)
            UpdateComputerListCount
            $tb_ComputerInput.Text = ""
        }
    } 
}

function Btn_ImportListClick( $object ){
   $tb_ComputerInput.Text = FileBrowser
}

function Btn_ViewListClick( $object ){
    $ComputerList.ShowDialog()
}

function Btn_ClearListClick( $object ){
    $ListBox1.Items.Clear()
    UpdateComputerListCount
}

function Btn_BrowseScriptClick( $object ){
    $Path = FolderBrowser
    $tb_ScriptPath.Text = ""
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

function Btn_ClearClick( $object ){
    $tb_ComputerInput.Text = ""
    $tb_ScriptPath.Text = ""
    $tb_ScriptDescription.Text = ""
}

function Btn_RunActionClick( $object ){
    $Computers = $ListBox1.Items
    foreach ($c in $Computers){
        New-Item -Path "\\$c\c$\techsrvs" -ItemType Directory
        Copy-Item -Path "$($tb_ScriptPath.Text)\*" -Destination "\\$c\c$\techsrvs"
        Invoke-Command -ComputerName $c -FilePath "c:\techsrvs\program.ps1" -AsJob
    }
}

function Btn_RemoveComputerClick {
    while ($ListBox1.SelectedItems.Count -gt 0){
        $ListBox1.Items.Remove($ListBox1.SelectedItems[0])
    }
    UpdateComputerListCount
}

function Btn_PingComputersClick( $object ){
    $Computers = $ListBox1.Items
    $Ping = New-Object System.Net.NetworkInformation.Ping
    $failed = @()
    $ErrorActionPreference = "Stop"
    foreach ($c in $Computers){
        try { 
            $Ping.Send($c)
        }
        catch {
            $failed += $c 
        }
    }
    $ErrorActionPreference = "Continue"
    if ($failed){
        $failed | ForEach-Object {
            $id = $ListBox1.FindString($_)
            $ListBox1.SetSelected($id,$true)
        }
        $ListBox1.Refresh()
        $Choice = [System.Windows.Forms.MessageBox]::Show("The highlighted computers failed to ping.  Would you like to remove them?","?",4)
        if ($Choice -eq "Yes"){
            Btn_RemoveComputerClick
        }
    }
}

function Btn_DeselectAllClick {
    $ListBox1.SelectedItems.Clear()
}

#endregion

#region Helper Functions

function MsgBox( $object ){
    [System.Windows.Forms.MessageBox]::Show("$object") 
}

function FolderBrowser {
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

function UpdateComputerListCount {
    $lbl_ComputersInList.Text = "Computers In List: $($ListBox1.Items.Count)"
}

#endregion

PushMain # This call must remain below all other event functions
