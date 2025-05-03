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
#~~< PowerTools >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$PowerTools = New-Object System.Windows.Forms.Form
$PowerTools.BackgroundImageLayout = [System.Windows.Forms.ImageLayout]::None
$PowerTools.ClientSize = New-Object System.Drawing.Size(1017, 545)
$PowerTools.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$PowerTools.MaximizeBox = $false
$PowerTools.Text = "PowerTools v1.0"
$PowerTools.BackColor = [System.Drawing.SystemColors]::AppWorkspace
#~~< GroupBoxTools >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$GroupBoxTools = New-Object System.Windows.Forms.GroupBox
$GroupBoxTools.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$GroupBoxTools.Location = New-Object System.Drawing.Point(708, 320)
$GroupBoxTools.Size = New-Object System.Drawing.Size(303, 213)
$GroupBoxTools.TabIndex = 8
$GroupBoxTools.TabStop = $false
$GroupBoxTools.Text = "Tools"
#~~< ButtonGPUpdate >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonGPUpdate = New-Object System.Windows.Forms.Button
$ButtonGPUpdate.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonGPUpdate.Location = New-Object System.Drawing.Point(20, 123)
$ButtonGPUpdate.Size = New-Object System.Drawing.Size(129, 28)
$ButtonGPUpdate.TabIndex = 18
$ButtonGPUpdate.Text = "GPUpdate"
$ButtonGPUpdate.UseVisualStyleBackColor = $true
$ButtonGPUpdate.add_Click({ gpupdate($ButtonGPUpdate) })
#~~< ButtonRDP >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonRDP = New-Object System.Windows.Forms.Button
$ButtonRDP.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonRDP.Location = New-Object System.Drawing.Point(155, 55)
$ButtonRDP.Size = New-Object System.Drawing.Size(129, 28)
$ButtonRDP.TabIndex = 17
$ButtonRDP.Text = "RDP"
$ButtonRDP.UseVisualStyleBackColor = $true
$ButtonRDP.add_Click({ rdp($ButtonRDP) })
#~~< ButtonDameware >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonDameware = New-Object System.Windows.Forms.Button
$ButtonDameware.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonDameware.Location = New-Object System.Drawing.Point(20, 55)
$ButtonDameware.Size = New-Object System.Drawing.Size(129, 28)
$ButtonDameware.TabIndex = 16
$ButtonDameware.Text = "Dameware"
$ButtonDameware.UseVisualStyleBackColor = $true
$ButtonDameware.add_Click({ dameware($ButtonDameware) })
#~~< ButtonManage >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonManage = New-Object System.Windows.Forms.Button
$ButtonManage.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonManage.Location = New-Object System.Drawing.Point(155, 21)
$ButtonManage.Size = New-Object System.Drawing.Size(129, 28)
$ButtonManage.TabIndex = 14
$ButtonManage.Text = "Manage"
$ButtonManage.UseVisualStyleBackColor = $true
$ButtonManage.add_Click({ manage($ButtonManage) })
#~~< ButtonRepairSCCM >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonRepairSCCM = New-Object System.Windows.Forms.Button
$ButtonRepairSCCM.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonRepairSCCM.Location = New-Object System.Drawing.Point(155, 89)
$ButtonRepairSCCM.Size = New-Object System.Drawing.Size(129, 28)
$ButtonRepairSCCM.TabIndex = 9
$ButtonRepairSCCM.Text = "RepairSCCM"
$ButtonRepairSCCM.UseVisualStyleBackColor = $true
$ButtonRepairSCCM.add_Click({ repairSCCM($ButtonRepairSCCM) })
#~~< ButtonUpdateMcAfee >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonUpdateMcAfee = New-Object System.Windows.Forms.Button
$ButtonUpdateMcAfee.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonUpdateMcAfee.Location = New-Object System.Drawing.Point(20, 89)
$ButtonUpdateMcAfee.Size = New-Object System.Drawing.Size(129, 28)
$ButtonUpdateMcAfee.TabIndex = 10
$ButtonUpdateMcAfee.Text = "UpdateMcAfee"
$ButtonUpdateMcAfee.UseVisualStyleBackColor = $true
$ButtonUpdateMcAfee.add_Click({ updateMcafee($ButtonUpdateMcAfee) })
#~~< ButtonLogoff >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonLogoff = New-Object System.Windows.Forms.Button
$ButtonLogoff.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonLogoff.Location = New-Object System.Drawing.Point(20, 157)
$ButtonLogoff.Size = New-Object System.Drawing.Size(129, 28)
$ButtonLogoff.TabIndex = 7
$ButtonLogoff.Text = "Logoff"
$ButtonLogoff.UseVisualStyleBackColor = $true
$ButtonLogoff.ForeColor = [System.Drawing.Color]::Red
$ButtonLogoff.add_Click({ logoff($ButtonLogoff) })
#~~< ButtonRestart >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonRestart = New-Object System.Windows.Forms.Button
$ButtonRestart.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonRestart.Location = New-Object System.Drawing.Point(155, 157)
$ButtonRestart.Size = New-Object System.Drawing.Size(129, 28)
$ButtonRestart.TabIndex = 8
$ButtonRestart.Text = "Restart"
$ButtonRestart.UseVisualStyleBackColor = $true
$ButtonRestart.ForeColor = [System.Drawing.Color]::Red
$ButtonRestart.add_Click({ restart($ButtonRestart) })
#~~< ButtonSCForceOption >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonSCForceOption = New-Object System.Windows.Forms.Button
$ButtonSCForceOption.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonSCForceOption.Location = New-Object System.Drawing.Point(20, 21)
$ButtonSCForceOption.Size = New-Object System.Drawing.Size(129, 28)
$ButtonSCForceOption.TabIndex = 4
$ButtonSCForceOption.Text = "SCForceOption"
$ButtonSCForceOption.UseVisualStyleBackColor = $true
$ButtonSCForceOption.add_Click({ scforceoption($ButtonSCForceOption) })
$GroupBoxTools.Controls.Add($ButtonGPUpdate)
$GroupBoxTools.Controls.Add($ButtonRDP)
$GroupBoxTools.Controls.Add($ButtonDameware)
$GroupBoxTools.Controls.Add($ButtonManage)
$GroupBoxTools.Controls.Add($ButtonRepairSCCM)
$GroupBoxTools.Controls.Add($ButtonUpdateMcAfee)
$GroupBoxTools.Controls.Add($ButtonLogoff)
$GroupBoxTools.Controls.Add($ButtonRestart)
$GroupBoxTools.Controls.Add($ButtonSCForceOption)
#~~< LabelSearch >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$LabelSearch = New-Object System.Windows.Forms.Label
$LabelSearch.Anchor = [System.Windows.Forms.AnchorStyles]::Right
$LabelSearch.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$LabelSearch.Location = New-Object System.Drawing.Point(666, 48)
$LabelSearch.Size = New-Object System.Drawing.Size(56, 26)
$LabelSearch.TabIndex = 6
$LabelSearch.Text = "Search"
$LabelSearch.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
#~~< ButtonSearchUsers >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonSearchUsers = New-Object System.Windows.Forms.Button
$ButtonSearchUsers.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonSearchUsers.Location = New-Object System.Drawing.Point(863, 48)
$ButtonSearchUsers.Size = New-Object System.Drawing.Size(129, 28)
$ButtonSearchUsers.TabIndex = 5
$ButtonSearchUsers.Text = "Users"
$ButtonSearchUsers.UseVisualStyleBackColor = $true
$ButtonSearchUsers.add_MouseClick({ searchUsers($ButtonSearchUsers) })
#~~< GroupBoxInformation >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$GroupBoxInformation = New-Object System.Windows.Forms.GroupBox
$GroupBoxInformation.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$GroupBoxInformation.Location = New-Object System.Drawing.Point(708, 82)
$GroupBoxInformation.Size = New-Object System.Drawing.Size(303, 232)
$GroupBoxInformation.TabIndex = 5
$GroupBoxInformation.TabStop = $false
$GroupBoxInformation.Text = "Information"
#~~< ButtonBitlockerKey >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonBitlockerKey = New-Object System.Windows.Forms.Button
$ButtonBitlockerKey.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonBitlockerKey.Location = New-Object System.Drawing.Point(20, 191)
$ButtonBitlockerKey.Size = New-Object System.Drawing.Size(129, 28)
$ButtonBitlockerKey.TabIndex = 17
$ButtonBitlockerKey.Text = "Bitlocker Key"
$ButtonBitlockerKey.UseVisualStyleBackColor = $true
$ButtonBitlockerKey.add_Click({ bitlockerKey($ButtonBitlockerKey) })
#~~< ButtonProcesses >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonProcesses = New-Object System.Windows.Forms.Button
$ButtonProcesses.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonProcesses.Location = New-Object System.Drawing.Point(155, 89)
$ButtonProcesses.Size = New-Object System.Drawing.Size(129, 28)
$ButtonProcesses.TabIndex = 16
$ButtonProcesses.Text = "Processes"
$ButtonProcesses.UseVisualStyleBackColor = $true
$ButtonProcesses.add_Click({ processes($ButtonProcesses) })
#~~< ButtonServices >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonServices = New-Object System.Windows.Forms.Button
$ButtonServices.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonServices.Location = New-Object System.Drawing.Point(20, 89)
$ButtonServices.Size = New-Object System.Drawing.Size(129, 28)
$ButtonServices.TabIndex = 15
$ButtonServices.Text = "Services"
$ButtonServices.UseVisualStyleBackColor = $true
$ButtonServices.add_Click({ services($ButtonServices) })
#~~< ButtonHardware >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonHardware = New-Object System.Windows.Forms.Button
$ButtonHardware.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonHardware.Location = New-Object System.Drawing.Point(155, 157)
$ButtonHardware.Size = New-Object System.Drawing.Size(129, 28)
$ButtonHardware.TabIndex = 14
$ButtonHardware.Text = "Hardware"
$ButtonHardware.UseVisualStyleBackColor = $true
$ButtonHardware.add_Click({ hardware($ButtonHardware) })
#~~< ButtonEvents >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonEvents = New-Object System.Windows.Forms.Button
$ButtonEvents.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonEvents.Location = New-Object System.Drawing.Point(20, 157)
$ButtonEvents.Size = New-Object System.Drawing.Size(129, 28)
$ButtonEvents.TabIndex = 15
$ButtonEvents.Text = "Uptime"
$ButtonEvents.UseVisualStyleBackColor = $true
$ButtonEvents.add_Click({ uptime($ButtonEvents) })
#~~< ButtonPrinters >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonPrinters = New-Object System.Windows.Forms.Button
$ButtonPrinters.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonPrinters.Location = New-Object System.Drawing.Point(155, 123)
$ButtonPrinters.Size = New-Object System.Drawing.Size(129, 28)
$ButtonPrinters.TabIndex = 13
$ButtonPrinters.Text = "Printers"
$ButtonPrinters.UseVisualStyleBackColor = $true
$ButtonPrinters.add_Click({ printers($ButtonPrinters) })
#~~< ButtonNetwork >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonNetwork = New-Object System.Windows.Forms.Button
$ButtonNetwork.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonNetwork.Location = New-Object System.Drawing.Point(20, 123)
$ButtonNetwork.Size = New-Object System.Drawing.Size(129, 28)
$ButtonNetwork.TabIndex = 6
$ButtonNetwork.Text = "Network"
$ButtonNetwork.UseVisualStyleBackColor = $true
$ButtonNetwork.add_Click({ network($ButtonNetwork) })
#~~< ButtonListProfiles >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonListProfiles = New-Object System.Windows.Forms.Button
$ButtonListProfiles.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonListProfiles.Location = New-Object System.Drawing.Point(155, 55)
$ButtonListProfiles.Size = New-Object System.Drawing.Size(129, 28)
$ButtonListProfiles.TabIndex = 5
$ButtonListProfiles.Text = "Profiles"
$ButtonListProfiles.UseVisualStyleBackColor = $true
$ButtonListProfiles.add_Click({ listprofiles($ButtonListProfiles) })
#~~< ButtonListSoftware >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonListSoftware = New-Object System.Windows.Forms.Button
$ButtonListSoftware.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonListSoftware.Location = New-Object System.Drawing.Point(20, 55)
$ButtonListSoftware.Size = New-Object System.Drawing.Size(129, 28)
$ButtonListSoftware.TabIndex = 2
$ButtonListSoftware.Text = "Applications"
$ButtonListSoftware.UseVisualStyleBackColor = $true
$ButtonListSoftware.add_Click({ listsoftware($ButtonListSoftware) })
#~~< ButtonLoggedOn >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonLoggedOn = New-Object System.Windows.Forms.Button
$ButtonLoggedOn.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonLoggedOn.Location = New-Object System.Drawing.Point(155, 21)
$ButtonLoggedOn.Size = New-Object System.Drawing.Size(129, 28)
$ButtonLoggedOn.TabIndex = 1
$ButtonLoggedOn.Text = "Logged On"
$ButtonLoggedOn.UseVisualStyleBackColor = $true
$ButtonLoggedOn.add_Click({ loggedon($ButtonLoggedOn) })
#~~< ButtonPing >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonPing = New-Object System.Windows.Forms.Button
$ButtonPing.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonPing.Location = New-Object System.Drawing.Point(20, 21)
$ButtonPing.Size = New-Object System.Drawing.Size(129, 28)
$ButtonPing.TabIndex = 0
$ButtonPing.Text = "Ping"
$ButtonPing.UseVisualStyleBackColor = $true
$ButtonPing.add_Click({ ping($ButtonPing) })
$GroupBoxInformation.Controls.Add($ButtonBitlockerKey)
$GroupBoxInformation.Controls.Add($ButtonProcesses)
$GroupBoxInformation.Controls.Add($ButtonServices)
$GroupBoxInformation.Controls.Add($ButtonHardware)
$GroupBoxInformation.Controls.Add($ButtonEvents)
$GroupBoxInformation.Controls.Add($ButtonPrinters)
$GroupBoxInformation.Controls.Add($ButtonNetwork)
$GroupBoxInformation.Controls.Add($ButtonListProfiles)
$GroupBoxInformation.Controls.Add($ButtonListSoftware)
$GroupBoxInformation.Controls.Add($ButtonLoggedOn)
$GroupBoxInformation.Controls.Add($ButtonPing)
#~~< ButtonClear >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonClear = New-Object System.Windows.Forms.Button
$ButtonClear.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonClear.Location = New-Object System.Drawing.Point(558, 501)
$ButtonClear.Size = New-Object System.Drawing.Size(144, 32)
$ButtonClear.TabIndex = 4
$ButtonClear.Text = "Clear"
$ButtonClear.UseVisualStyleBackColor = $true
$ButtonClear.add_Click({ clearform($ButtonClear) })
#~~< ButtonSearchComputers >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonSearchComputers = New-Object System.Windows.Forms.Button
$ButtonSearchComputers.Font = New-Object System.Drawing.Font("Verdana", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$ButtonSearchComputers.Location = New-Object System.Drawing.Point(728, 48)
$ButtonSearchComputers.Size = New-Object System.Drawing.Size(129, 28)
$ButtonSearchComputers.TabIndex = 3
$ButtonSearchComputers.Text = "Computers"
$ButtonSearchComputers.UseVisualStyleBackColor = $true
$ButtonSearchComputers.add_Click({ searchComputers($ButtonSearchComputers) })
#~~< OutputMain >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$OutputMain = New-Object System.Windows.Forms.TextBox
$OutputMain.Font = New-Object System.Drawing.Font("Courier New", 9.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$OutputMain.Location = New-Object System.Drawing.Point(15, 92)
$OutputMain.Multiline = $true
$OutputMain.ScrollBars = [System.Windows.Forms.ScrollBars]::Vertical
$OutputMain.Size = New-Object System.Drawing.Size(687, 403)
$OutputMain.TabIndex = 3
$OutputMain.Text = ""
#~~< InputMain >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$InputMain = New-Object System.Windows.Forms.TextBox
$InputMain.Font = New-Object System.Drawing.Font("Verdana", 10.8, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$InputMain.Location = New-Object System.Drawing.Point(60, 45)
$InputMain.Size = New-Object System.Drawing.Size(420, 29)
$InputMain.TabIndex = 1
$InputMain.Text = ""
#~~< LabelInput >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$LabelInput = New-Object System.Windows.Forms.Label
$LabelInput.Font = New-Object System.Drawing.Font("Courier New", 12.0, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$LabelInput.Location = New-Object System.Drawing.Point(15, 45)
$LabelInput.Size = New-Object System.Drawing.Size(39, 24)
$LabelInput.TabIndex = 0
$LabelInput.Text = ">>"
$LabelInput.TextAlign = [System.Drawing.ContentAlignment]::TopRight
$LabelInput.ForeColor = [System.Drawing.Color]::LawnGreen
$LabelInput.add_Click({ Label1Click($LabelInput) })
#~~< MainMenu1 >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$MainMenu1 = New-Object System.Windows.Forms.MenuStrip
$MainMenu1.Location = New-Object System.Drawing.Point(0, 0)
$MainMenu1.Size = New-Object System.Drawing.Size(1017, 28)
$MainMenu1.TabIndex = 7
$MainMenu1.Text = "MainMenu1"
#~~< ToolStripMenuItem1 >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ToolStripMenuItem1 = New-Object System.Windows.Forms.ToolStripMenuItem
$ToolStripMenuItem1.Size = New-Object System.Drawing.Size(44, 24)
$ToolStripMenuItem1.Text = "File"
$ToolStripMenuItem1.add_Click({ ToolStripMenuItem1Click($ToolStripMenuItem1) })
#~~< ToolStripMenuItem3 >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ToolStripMenuItem3 = New-Object System.Windows.Forms.ToolStripMenuItem
$ToolStripMenuItem3.Size = New-Object System.Drawing.Size(72, 24)
$ToolStripMenuItem3.Text = "Reports"
#~~< HotListsToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$HotListsToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$HotListsToolStripMenuItem.Size = New-Object System.Drawing.Size(152, 24)
$HotListsToolStripMenuItem.Text = "Watch Lists"
#~~< MyHotListToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$MyHotListToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$MyHotListToolStripMenuItem.Size = New-Object System.Drawing.Size(178, 24)
$MyHotListToolStripMenuItem.Text = "My Watch List"
$MyHotListToolStripMenuItem.add_Click({ ReportsWatchlistsMy($MyHotListToolStripMenuItem) })
#~~< PatchHotlistToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$PatchHotlistToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$PatchHotlistToolStripMenuItem.Size = New-Object System.Drawing.Size(178, 24)
$PatchHotlistToolStripMenuItem.Text = "Watch List"
$PatchHotlistToolStripMenuItem.add_Click({ ReportsWatchlistsITDept($PatchHotlistToolStripMenuItem) })
$HotListsToolStripMenuItem.DropDownItems.AddRange([System.Windows.Forms.ToolStripItem[]](@($MyHotListToolStripMenuItem, $PatchHotlistToolStripMenuItem)))
#~~< DomainReportToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$DomainReportToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$DomainReportToolStripMenuItem.Size = New-Object System.Drawing.Size(152, 24)
$DomainReportToolStripMenuItem.Text = "ADUC"
#~~< OverallToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$OverallToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$OverallToolStripMenuItem.Size = New-Object System.Drawing.Size(188, 24)
$OverallToolStripMenuItem.Text = "Snapshot Report"
$OverallToolStripMenuItem.add_Click({ ReportsADSnapshotReport($OverallToolStripMenuItem) })
#~~< LockedComputersToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$LockedComputersToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$LockedComputersToolStripMenuItem.Size = New-Object System.Drawing.Size(188, 24)
$LockedComputersToolStripMenuItem.Text = "Locked Users"
$LockedComputersToolStripMenuItem.add_Click({ ReportsADLockedUsers($LockedComputersToolStripMenuItem) })
#~~< StaleUsersToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$StaleUsersToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$StaleUsersToolStripMenuItem.Size = New-Object System.Drawing.Size(188, 24)
$StaleUsersToolStripMenuItem.Text = "Stale Users"
$StaleUsersToolStripMenuItem.add_Click({ ReportsADStaleUsers($StaleUsersToolStripMenuItem) })
#~~< StaleComputersToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$StaleComputersToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$StaleComputersToolStripMenuItem.Size = New-Object System.Drawing.Size(188, 24)
$StaleComputersToolStripMenuItem.Text = "Stale Computers"
$StaleComputersToolStripMenuItem.add_Click({ ReportsADStaleComputers($StaleComputersToolStripMenuItem) })
$DomainReportToolStripMenuItem.DropDownItems.AddRange([System.Windows.Forms.ToolStripItem[]](@($OverallToolStripMenuItem, $LockedComputersToolStripMenuItem, $StaleUsersToolStripMenuItem, $StaleComputersToolStripMenuItem)))
#~~< SCCMToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$SCCMToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$SCCMToolStripMenuItem.Size = New-Object System.Drawing.Size(152, 24)
$SCCMToolStripMenuItem.Text = "SCCM"
#~~< MainMenuToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$MainMenuToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$MainMenuToolStripMenuItem.Size = New-Object System.Drawing.Size(260, 24)
$MainMenuToolStripMenuItem.Text = "Main Menu"
$MainMenuToolStripMenuItem.add_Click({ ReportsSMSMain($MainMenuToolStripMenuItem) })
#~~< SoftwareReportToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$SoftwareReportToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$SoftwareReportToolStripMenuItem.Size = New-Object System.Drawing.Size(260, 24)
$SoftwareReportToolStripMenuItem.Text = "Inactive Clients Detail"
$SoftwareReportToolStripMenuItem.add_Click({ ReportsSMSInactiveClients($SoftwareReportToolStripMenuItem) })
#~~< AllNonclientsToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$AllNonclientsToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$AllNonclientsToolStripMenuItem.Size = New-Object System.Drawing.Size(260, 24)
$AllNonclientsToolStripMenuItem.Text = "All Subnets by Subnet Mask"
$AllNonclientsToolStripMenuItem.add_Click({ ReportsSMSAllSubnets($AllNonclientsToolStripMenuItem) })
#~~< ClientsWUpdatesPendingToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ClientsWUpdatesPendingToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$ClientsWUpdatesPendingToolStripMenuItem.Size = New-Object System.Drawing.Size(260, 24)
$ClientsWUpdatesPendingToolStripMenuItem.Text = "Common Patch Software"
$ClientsWUpdatesPendingToolStripMenuItem.add_Click({ ReportsSMSCommonPatchSoftware($ClientsWUpdatesPendingToolStripMenuItem) })
$SCCMToolStripMenuItem.DropDownItems.AddRange([System.Windows.Forms.ToolStripItem[]](@($MainMenuToolStripMenuItem, $SoftwareReportToolStripMenuItem, $AllNonclientsToolStripMenuItem, $ClientsWUpdatesPendingToolStripMenuItem)))
$ToolStripMenuItem3.DropDownItems.AddRange([System.Windows.Forms.ToolStripItem[]](@($HotListsToolStripMenuItem, $DomainReportToolStripMenuItem, $SCCMToolStripMenuItem)))
#~~< LinksToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$LinksToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$LinksToolStripMenuItem.Size = New-Object System.Drawing.Size(53, 24)
$LinksToolStripMenuItem.Text = "Links"
#~~< ArmyPublicationsFormsToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$PublicationsFormsToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$PublicationsFormsToolStripMenuItem.Size = New-Object System.Drawing.Size(311, 24)
$PublicationsFormsToolStripMenuItem.Text = "Army Publications and Forms"
$PublicationsFormsToolStripMenuItem.add_Click({ LinksArmyPublications($PublicationsFormsToolStripMenuItem) })
#~~< SWListToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$SWListToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$SWListToolStripMenuItem.Size = New-Object System.Drawing.Size(311, 24)
$SWListToolStripMenuItem.Text = "CoN List"
$SWListToolStripMenuItem.add_Click({ LinksConList($SWListToolStripMenuItem) })
#~~< PatchRepositoryToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$PatchRepositoryToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$PatchRepositoryToolStripMenuItem.Size = New-Object System.Drawing.Size(311, 24)
$PatchRepositoryToolStripMenuItem.Text = "DoD Patch Repository"
$PatchRepositoryToolStripMenuItem.add_Click({ LinksDoDPatchRepository($PatchRepositoryToolStripMenuItem) })
#~~< KnowledgeBaseToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$KnowledgeBaseToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$KnowledgeBaseToolStripMenuItem.Size = New-Object System.Drawing.Size(311, 24)
$KnowledgeBaseToolStripMenuItem.Text = "Knowledge Base"
$KnowledgeBaseToolStripMenuItem.add_Click({ LinksKnowledgeBase($KnowledgeBaseToolStripMenuItem) })
#~~< PKIRecoveryToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$PKIRecoveryToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$PKIRecoveryToolStripMenuItem.Size = New-Object System.Drawing.Size(311, 24)
$PKIRecoveryToolStripMenuItem.Text = "PKI Recovery"
$PKIRecoveryToolStripMenuItem.add_Click({ LinksPKIRecovery($PKIRecoveryToolStripMenuItem) })
#~~< ITDeptMasterTrackerToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ITDeptMasterTrackerToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$ITDeptMasterTrackerToolStripMenuItem.Size = New-Object System.Drawing.Size(311, 24)
$ITDeptMasterTrackerToolStripMenuItem.Text = "Master Tracker"
$ITDeptMasterTrackerToolStripMenuItem.add_Click({ LinksITDeptMasterTracker($ITDeptMasterTrackerToolStripMenuItem) })
#~~< RemedyToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$RemedyToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$RemedyToolStripMenuItem.Size = New-Object System.Drawing.Size(311, 24)
$RemedyToolStripMenuItem.Text = "Remedy"
$RemedyToolStripMenuItem.add_Click({ LinksRemedy($RemedyToolStripMenuItem) })
#~~< SoftwareDistToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$SoftwareDistToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$SoftwareDistToolStripMenuItem.Size = New-Object System.Drawing.Size(311, 24)
$SoftwareDistToolStripMenuItem.Text = "SoftwareDist"
$SoftwareDistToolStripMenuItem.add_Click({ LinksSoftwareDist($SoftwareDistToolStripMenuItem) })
#~~< SCCMReportsToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$SCCMReportsToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$SCCMReportsToolStripMenuItem.Size = New-Object System.Drawing.Size(311, 24)
$SCCMReportsToolStripMenuItem.Text = "SCCM Reports"
$SCCMReportsToolStripMenuItem.add_Click({ LinksSCCMReports($SCCMReportsToolStripMenuItem) })
#~~< TechShareToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$TechShareToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$TechShareToolStripMenuItem.Size = New-Object System.Drawing.Size(311, 24)
$TechShareToolStripMenuItem.Text = "TechShare"
$TechShareToolStripMenuItem.add_Click({ LinksTechshare($TechShareToolStripMenuItem) })
#~~< VPNManagementConsoleToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$VPNManagementConsoleToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$VPNManagementConsoleToolStripMenuItem.Size = New-Object System.Drawing.Size(311, 24)
$VPNManagementConsoleToolStripMenuItem.Text = "VPN Management Console"
$VPNManagementConsoleToolStripMenuItem.add_Click({ LinksVPNManagement($VPNManagementConsoleToolStripMenuItem) })
$LinksToolStripMenuItem.DropDownItems.AddRange([System.Windows.Forms.ToolStripItem[]](@($REMOVED, $REMOVED, $REMOVED, $REMOVED, $KnowledgeBaseToolStripMenuItem, $PKIRecoveryToolStripMenuItem, $ITDeptMasterTrackerToolStripMenuItem, $RemedyToolStripMenuItem, $SoftwareDistToolStripMenuItem, $SCCMReportsToolStripMenuItem, $SecureAccessFileExchangeSAFEToolStripMenuItem, $TechShareToolStripMenuItem, $VPNManagementConsoleToolStripMenuItem)))
#~~< HelpToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$HelpToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$HelpToolStripMenuItem.Size = New-Object System.Drawing.Size(53, 24)
$HelpToolStripMenuItem.Text = "Help"
#~~< AboutToolStripMenuItem >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$AboutToolStripMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
$AboutToolStripMenuItem.Size = New-Object System.Drawing.Size(119, 24)
$AboutToolStripMenuItem.Text = "About"
$AboutToolStripMenuItem.add_Click({ about($AboutToolStripMenuItem) })
$HelpToolStripMenuItem.DropDownItems.AddRange([System.Windows.Forms.ToolStripItem[]](@($AboutToolStripMenuItem)))
$MainMenu1.Items.AddRange([System.Windows.Forms.ToolStripItem[]](@($ToolStripMenuItem1, $ToolStripMenuItem3, $LinksToolStripMenuItem, $HelpToolStripMenuItem)))
$PowerTools.Controls.Add($GroupBoxTools)
$PowerTools.Controls.Add($LabelSearch)
$PowerTools.Controls.Add($ButtonSearchUsers)
$PowerTools.Controls.Add($GroupBoxInformation)
$PowerTools.Controls.Add($ButtonClear)
$PowerTools.Controls.Add($ButtonSearchComputers)
$PowerTools.Controls.Add($OutputMain)
$PowerTools.Controls.Add($InputMain)
$PowerTools.Controls.Add($LabelInput)
$PowerTools.Controls.Add($MainMenu1)

#endregion

#region Custom Code

#endregion

#region Event Loop

function Main {
	[System.Windows.Forms.Application]::EnableVisualStyles()
	[System.Windows.Forms.Application]::Run($PowerTools)
}

#endregion

#endregion

#region Event Handlers

#region Global Variables

ipmo 'C:\Windows\System32\WindowsPowerShell\v1.0\Modules\ActiveDirectory'
ipmo '\\techshare$\applications\scripts\windowspowershell\modules\psremoteregistry'
$global:ReportDataCached = $false

$global:SCCMServer = 'sccm_server'
$global:SCCMNamespace = "root\sms\site"

$nl = [System.Environment]::NewLine

#endregion

#region Buttons
###########################################################
####################### BUTTONS ###########################
###########################################################

function searchUsers( $object ) {
	$string = $InputMain.Text
	$users = Get-ADUser -filter "Displayname -like '*$string*' -or Office -like '*$string*' -or OfficePhone -like '*$string*'"`
		-SearchBase "OU" -properties *
	$count = $users.count
		
	$hash = foreach ($user in $users) {
		$sam = $user.sAMAccountName
		$query = "Select SMS_R_System.Name from SMS_R_System where SMS_R_System.LastLogonUserName like '%$sam%'"
		$computers = gwmi -Namespace $global:SCCMNamespace -ComputerName $global:SCCMServer -Query $Query
		@{
			"1 DisplayName"  = $user.Displayname;
			"2 Username"     = $user.sAMAccountName;
			"3 Computers"    = $computers.Name;
			"4 EmailAddress" = $user.EmailAddress;
			"5 Office"       = $user.Office;
			"6 Phone"        = $user.OfficePhone;
			"7 Company"      = $user.Company;
			"8 Description"  = $user.Description;
			"9 EDIPI"        = $user.UserPrincipalName
		}
	}
		
	$OutputMain.Text += " $count items found $nl"
	$OutputMain.Text += "-------------------------"
			
	foreach ($obj in $hash) {
		$OutputMain.Text += $obj.GetEnumerator() | sort Name | ft -AutoSize | Out-String
	}
}

function searchComputers($object) {
	$string = $InputMain.Text
	$computers = Get-ADComputer -filter "Name -like '*$string*' -or Description -like '*$string*'" -SearchBase "OU" -properties *
	$count = $computers.count
	$hash = foreach ($c in $computers) {
		@{ 
			"1 Hostname"      = $c.Name;
			"2 Description"   = $c.Description;
			"3 OS"            = $c.OperatingSystem;
			"4 IP"            = $c.Ipv4Address;
			"5 LastLogonDate" = $c.LastLogonDate;
			"6 Enabled"       = $c.Enabled;
			"7 Lockedout"     = $c.Lockedout
		}
	}
		
	$OutputMain.Text += " $count items found $nl"
	$OutputMain.Text += "-------------------------"
		
	foreach ($obj in $hash) {
		$OutputMain.Text += $obj.GetEnumerator() | sort Name | ft -AutoSize | Out-String
	}
}

function ping($object) {
	$input = $InputMain.Text.ToUpper()
	if (Test-ConITDepttion $InputMain.Text -Count 1 -Quiet) {
		$OutputMain.AppendText("$input is currently ONLINE")
	}
	else { 
		$OutputMain.AppendText("$input is currently OFFLINE")
	}
	$OutputMain.AppendText($nl)
}

function loggedon($object) {
	$computer = $InputMain.Text
	if (Test-ConITDepttion -ComputerName $computer -Count 1 -Quiet) {
		$user = (gwmi -class win32_computersystem -ComputerName $computer).Username
		if ($user -ne $null) {
			$OutputMain.Text += $user
		}
		else {
			$OutputMain.Text += "Computer is currently vacant"
		}
	}
	else {
		$OutputMain.Text += "$computer is offline!"
	}
	$OutputMain.AppendText($nl)
}

function scforceoption( $object ) {
	$computer = $InputMain.Text.ToUpper()
	if (Test-ConITDepttion -ComputerName $computer -Count 1 -Quiet) {
		$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $computer) 
		$regKey = $reg.OpenSubKey("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\policies\\system", $true) 
		$regKey.SetValue("SCForceOption", "0", [Microsoft.Win32.RegistryValueKind]::Dword)
		$OutputMain.Text += "Flipped the flag on $computer"
		$OutputMain.AppendText($nl)
	}
	else { 
		$OutputMain.Text += "Can't ping machine or it doesn't exist."
		$OutputMain.AppendText($nl)
		
	}
}

function listsoftware($object) {
	$computer = $InputMain.Text
	$OutputMain.AppendText("Fetching software list, please wait...")
	sleep 1
	$software = gwmi -ComputerName $computer win32_product | select Name, Version, InstallDate | sort Name |
	Out-GridView -Title "Applications list: $computer"
	$OutputMain.AppendText($nl)
}

function listprofiles( $object ) {
	$computer = $InputMain.Text
	if (Test-ConITDepttion -ComputerName $computer -Count 1 -Quiet) {
		$profiles = gci "\\$computer\c$\users" | select Name, LastWriteTime | 
		sort LastWriteTime -Descending | ft -AutoSize | Out-String
		$OutputMain.Text += $profiles
	}
	else {
		$OutputMain.Text += " $computer is offline !"
	}
	$OutputMain.AppendText($nl)
}

function network( $object ) {
	$computer = $InputMain.Text
	if (Test-ConITDepttion -ComputerName $computer -Count 1 -Quiet) {
		$nics = gwmi win32_networkadapterconfiguration -ComputerName $computer | ? { $_.IPAddress -ne $null }
		$hash = foreach ($nic in $nics) {
			@{
				"1 Description"  = $nic.Description;
				"2 IPAddress"    = $nic.IPAddress;
				"3 Subnet"       = $nic.IPSubnet;
				"4 Gateway"      = $nic.DefaultIPGateway;
				"5 DNS"          = $nic.DNSServerSearchOrder;
				"5 DHCP Enabled" = $nic.DHCPEnabled;
				"6 MAC Address"  = $nic.MACAddress
			}
		}
				
		foreach ($obj in $hash) {
			$OutputMain.Text += $obj.GetEnumerator() | sort Name | ft -AutoSize | Out-String
		}
	}
	else {
		$OutputMain.Text += " $computer is offline "
	}
	$OutputMain.AppendText($nl)
}

function repairSCCM( $object ) {
	$computer = $InputMain.Text
	if (Test-ConITDepttion -ComputerName $computer -Count 1 -Quiet) {
		try {
			([wmiclass] "\\$computer\root\ccm:sms_client").RepairClient()
		}
		catch {
			$errFlag = $true
			$OutputMain.Text += "SCCM Repair failed"
		}
							
		if (-not($errFlag)) {
			$OutputMain.Text += "SCCM repair command sent to client"
		}
	}
	else {
		$OutputMain.Text += " $computer is offline!"
	}
	$OutputMain.AppendText($nl)
}

function rdp( $object ) {
	$computer = $InputMain.Text
	if (Test-ConITDepttion -ComputerName $computer -Count 1 -Quiet) {
		mstsc.exe /v:$computer /f
	}
	else {
		$OutputMain.Text += " $computer not found or is offline !"
		$OutputMain.AppendText($nl)
	}
}

function dameware( $object ) {
	$computer = $InputMain.Text
	if (Test-ConITDepttion -ComputerName $computer -Count 1 -Quiet) {
		$args = "-c -m:$computer"
		Start-Process "C:\Program Files\DameWare\DameWare Mini Remote Control 7.5\dwrcc.exe" -ArgumentList $args
	}
	else {
		$OutputMain.Text += " $computer not found or is offline !"
		$OutputMain.AppendText($nl)
	}
}

function services($object) {
	$computer = $InputMain.Text
	if (Test-ConITDepttion -ComputerName $computer -Count 1 -Quiet) {
		services.msc /computer:$computer
	}
	else {
		$OutputMain.Text += " $computer not found or is offline !"
		$OutputMain.AppendText($nl)
	}
}

function manage($object) {
	$computer = $InputMain.Text
	if (Test-ConITDepttion -ComputerName $computer -Count 1 -Quiet) {
		compmgmt.msc /computer:$computer
	}
	else {
		$OutputMain.Text += "$computer not found or is offline!"
		$OutputMain.AppendText($nl)
	} 
}

function hardware( $object ) {
	$computer = $InputMain.Text
	if (Test-ConITDepttion -ComputerName $computer -Count 1 -Quiet) {
		$computersystem = gwmi -class win32_computersystem -ComputerName $computer
		$cdrom = gwmi -class win32_cdromdrive -ComputerName $computer
		$hdd = gwmi -class win32_diskdrive -ComputerName $computer
		$bios = gwmi -class win32_bios -ComputerName $computer
		$mem = gwmi -class win32_physicalmemory -ComputerName $computer
		$proc = gwmi -class win32_processor -ComputerName $computer
		$nic = gwmi -class win32_networkadapterconfiguration -ComputerName $computer | ? { $_.ipenabled }
		$mon = gwmi -class win32_desktopmonitor -ComputerName $computer
		$video = gwmi -class win32_videocontroller -ComputerName $computer | ? { $_.adaptercompatibility -notlike "*Dameware*" }

		$hardware = @{
			"System Name"         = $computersystem.name
			"System Manufacturer" = $computersystem.manufacturer
			"System Model"        = $computersystem.model
			"BIOS Manufacturer"   = $bios.manufacturer
			"BIOS Version"        = $bios.smbiosbiosversion
			"Processor"           = $proc.name
			"Memory Amount (GB)"  = $mem.capacity / 1gb
			"Memory Manufacturer" = $mem.manufacturer
			"Memory Speed"        = $mem.speed
			"Video Manufacturer"  = $video.adaptercompatibility
			"Video Model"         = $video.caption
			"Video Driver Ver"    = $video.driverversion
			"Number Monitors"     = $mon.count
			"Network Adapter"     = $nic.Description
		}

		$OutputMain.Text += $hardware | sort Name | Out-GridView -Title "Hardware List: $computer" 
	}

	else {
		$OutputMain.Text += "$computer not found or is offline!"
	}

	$OutputMain.AppendText($nl) 
}

function printers($object) {
	$computer = $InputMain.Text
	if (Test-ConITDepttion -ComputerName $computer -Count 1 -Quiet) {
		#Get local printers and print them to screen
		$locPrinters = gwmi -computername $computer -class win32_printer | select Name, Portname
		$OutputMain.Text += "Local printers: $nl"
		foreach ($printer in $locPrinters) {
			$OutputMain.Text += " " + $printer.Name + "(" + $printer.Portname + ")", $nl
		}		
		$OutputMain.AppendText($nl)

		$user = gwmi -ComputerName $computer -Class win32_computersystem | select username

		if ($user.username.length -gt 3) {	
			#Get network printers and print them to screen
			$netPrinters = @( )
			$uname = $user.username
			$arrusername = $uname.split("\")
			$username = $arrusername[1]
			$sid = Get-ADUser -identity $username | select sid
			$usid = $sid.sid
			$pKeys = Get-RegKey -ComputerName $computer -Hive "Users" -Key "$usid\Printers\ConITDepttions" -Recurse  			
						
			$OutputMain.Text += "Network printers: $nl"
			
			foreach ($pKey in $pKeys) {  
				[string]$printerKey = $pKey.key  
				$arrPrinterKey = $printerKey.Split("\")  
				$PrinterNamePiece = $arrPrinterKey[3]  
				$arrPrinterParts = $PrinterNamePiece.Split(",")  
				$printServer = $arrPrinterParts[2]  
				$PrinterName = $arrPrinterParts[3]  
				$PrinterUnc = "\\$printServer\$PrinterName"
				$OutputMain.Text += " " #indents text
				$OutputMain.Text += $PrinterUnc
				$OutputMain.AppendText($nl)
			}
		}
		else {
			$OutputMain.Text += "Noone is logged onto $computer so network printers can not be enumerated $nl"
		}
	}
	else {
		$OutputMain.Text += " $computer not found or is offline !"
	}
	
	$OutputMain.AppendText($nl)
}

function processes( $object ) {
	$computer = $InputMain.Text
	if (Test-ConITDepttion -ComputerName $computer -Count 1 -Quiet) {
		$proc = Get-Process -ComputerName $computer | select ProcessName, ID, CPU, VM | 
		sort VM -Descending | Out-GridView -Title "Processes: $computer"
	}
	else {
		$OutputMain.Text += " $computer not found or is offline !"
		$OutputMain.AppendText($nl)
	}
}

function gpupdate( $object ) {
	$computer = $InputMain.Text
	if (Test-ConITDepttion -ComputerName $computer -Count 1 -Quiet) {
		$OutputMain.Text += "Updating group policy on $computer.$nl"
		$OutputMain.Text += "This my take a minute or two hang tight..."
		$s = New-PSSession -ComputerName $computer
		Enter-PSSession $s
		Invoke-Command -Session $s -ScriptBlock { gpupdate /force }
		Remove-PSSession $s
		$OutputMain.Text += "Done.$nl"
	}
	else {
		$OutputMain.Text += " $computer not found or is offline !"
	}

	$OutputMain.AppendText($nl)
}

function uptime( $object ) {
	$computer = $InputMain.Text
	if (Test-ConITDepttion -ComputerName $computer -Count 1 -Quiet) {
		$lastlogon = Get-ADComputer -Identity $computer -Properties * | select lastlogondate
		$lastboottime = (gwmi win32_operatingsystem -ComputerName $computer).LastBootUpTime
		$sysuptime = (Get-Date) - [System.Management.ManagementDateTimeconverter]::ToDateTime($lastboottime)
		$OutputMain.Text += $computer.ToUpper() + " Uptime: " + $nl
		$OutputMain.Text += "      Days: " + $sysuptime.Days, $nl
		$OutputMain.Text += "     Hours: " + $sysuptime.Hours, $nl
		$OutputMain.Text += "   Minutes: " + $sysuptime.Minutes, $nl
		$OutputMain.Text += "   Seconds: " + $sysuptime.Seconds, $nl
		#$OutputMain.Text += "Last Logon: " + $lastlogon.LastLogonDate,$nl
	}
	else {
		$OutputMain.Text += "$computer not found or is offline!"
		$OutputMain.AppendText($nl)
	} 
}

function restart( $object ) {
	$computer = $InputMain.Text
	if (Test-ConITDepttion -ComputerName $computer -Count 1 -Quiet) {
		[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
		$choice = [Microsoft.VisualBasic.Interaction]::MsgBox("Are you sure?", 'YesNoCancel,Question', "Warning!!!")
				
		if ($choice -eq "Yes") {
			(gwmi win32_operatingsystem -ComputerName $computer -ea SilentlyContinue).Win32Shutdown(2)
			$OutputMain.Text += "Restart command sent"
		}
		else {
			$OutputMain.Text += "Command aborted"
		}
	}
	else {
		$OutputMain.Text += " $computer is offline !"			
	}
		
	$OutputMain.AppendText($nl)
}

function logoff($object) {
	$computer = $InputMain.Text
	if (Test-ConITDepttion -ComputerName $computer -Count 1 -Quiet) {
		[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
		$choice = [Microsoft.VisualBasic.Interaction]::MsgBox("Are you sure?", 'YesNoCancel,Question', "Warning!!!")
				
		if ($choice -eq "Yes") {
			(gwmi win32_operatingsystem -ComputerName $computer -ea SilentlyContinue).Win32Shutdown(4)
			$OutputMain.Text += "Logoff command sent"
		}
		else {
			$OutputMain.Text += "Command aborted"
		}
	}
	else {
		$OutputMain.Text += " $computer is offline !"			
	}
		
	$OutputMain.AppendText($nl)
}

function updateMcafee( $object ) {
	$computer = $InputMain.Text
	if (Test-ConITDepttion -ComputerName $computer -Count 1 -Quiet) {
		Invoke-Command -ComputerName $computer -ScriptBlock { Start-Process "c:\program files (x86)\mcafee\virusscan enterprise\mcupdate.exe" -ArgumentList '/update' } 
		$OutputMain.Text += "Update command sent$nl" 
		$OutputMain.Text += "Waiting 10 seconds to collect and send props..."
		sleep 20
		Invoke-Command -ComputerName $computer -ScriptBlock { Start-Process "c:\program files (x86)\mcafee\common framework\cmdagent.exe" -ArgumentList '/p' }
		$OutputMain.Text += "Done.$nl"
		$OutputMain.Text += "McAfee Update finished."
	}
	else {
		$OutputMain.Text += " $computer is offline!"
	}
	$OutputMain.AppendText($nl)
}

function bitlockerKey( $object ) {
	$computer = $InputMain.Text
	$OutputMain.Text += "Fetching bitlocker key please wait...$nl"
	sleep 1
	$bitlockerKey = Get-ADObject -filter * -SearchBase "OU" -Properties msfve-recoverypassword | 
	where { $_.distinguishedname -match $computer -and $_.objectclass -eq "msFVE-RecoveryInformation" } | select -ExpandProperty msfve-recoverypassword
	$OutputMain.Text += "Recovery Key: $bitlockerKey"
	$OutputMain.AppendText($nl)
}

function clearForm($object) {
	$OutputMain.Clear()
}

#endregion

#region Reports
###########################################################
####################### REPORTS ###########################
###########################################################

function CacheReportData() {

	$OutputMain.Text += "Please hold while report data is being cached..."
	sleep 1
	$global:adUsers = Get-ADUser -filter * -SearchBase "OU" -properties *
	$global:adComputers = Get-ADComputer -filter * -SearchBase "OU" -properties *
    
	$global:ReportDataCached = $true
	$OutputMain.Text += "Done."
	$OutputMain.AppendText($nl)
}

function ReportsADSnapshotReport( $object ) {
	if (-not($global:ReportDataCached)) { CacheReportData }
  
	$OutputMain.Text += "Total ADComputers: " + $global:adComputers.count + $nl
	$OutputMain.Text += "Total ADUsers:     " + $global:adUsers.count
}

function ReportsADLockedUsers( $object ) {
	if (-not($global:ReportDataCached)) { CacheReportData }

	$lockedUsers = $global:adUsers | ? { $_.lockedout -eq $true }
	$lockedUsers | select Name, Description, LastLogonDate | Out-GridView -Title "Locked AD User Accounts"
}

function ReportsADStaleUsers( $object ) {
	if (-not($global:ReportDataCached)) { CacheReportData }

	$staleUsers = @()
	foreach ($user in $global:adUsers) {
		[DateTime]$dt = $user.lastLogonDate
		$currDate = Get-Date
		$staleTime = $currDate - $dt
		if ($staleTime.Days -gt 30) {
			$staleUsers += $user
		}  
	}
	$staleUsers | select Name, Description, LastLogonDate | Out-GridView -Title "Stale AD User Accounts"
}

function ReportsADStaleComputers( $object ) {
	if (-not($global:ReportDataCached)) { CacheReportData }

	$staleComputers = @()
	foreach ($computer in $global:adComputers) {
		[DateTime]$dt = $computer.lastLogonDate
		$currDate = Get-Date
		$staleTime = $currDate - $dt
		if ($staleTime.Days -gt 30) {
			$staleComputers += $computer
		}  
	}
	$staleComputers | select Name, Description, LastLogonDate | Out-GridView -Title "Stale AD Computer Accounts"
}

function ReportsSMSMain( $object ) {
	Start-Process 'http://sccm_server/smsreporting/'
}

function ReportsSMSInactiveClients( $object ) {
	Start-Process 'http://sccm_server/smsreporting/Report.asp?ReportID=474&Site=104&Perct=100'
}

function ReportsSMSAllSubnets( $object ) {
	Start-Process 'http://sccm_server/smsreporting/Report.asp?ReportID=36'
}

function ReportsSMSCommonPatchSoftware( $object ) {
	Start-Process 'http://sccm_server/smsreporting/Report.asp?ReportID=455&CollID=SMS00001'
}

function ReportsWatchlistsMy( $object ) {
	$WatchlistFileLoc = 'C:\WatchLists\mywatchlist.txt'
	if (-not(Test-Path $WatchlistFileLoc)) {
		$OutputMain.Text += "Your watchlist file doesn't exist! $nl"
		$OutputMain.Text += "Place it in the following location: $WatchlistFileLoc $nl"
	}
	else {
		$computers = gc $WatchlistFileLoc
		$results = @{}
		foreach ($computer in $computers) {
			$dt = 0
			if (Test-ConITDepttion $computer -Count 1 -Quiet) {
				$userLoggedon = gwmi win32_computersystem -ComputerName $computer | select username
				if ($userLoggedon.username.length -gt 3) {
					[string]$name = $userLoggedon.username
					$arr = $name.split("\")
					$username = $arr[1]
					$lastLogonTime = (Get-ADUser -Identity $username -Properties *).lastLogon
					$dt = [DateTime]::FromFileTime($lastLogonTime)
					$currentdt = Get-Date
					$duration = $currentdt - $dt
				}
				$obj = New-Object System.Object
				$obj | Add-Member -type NoteProperty -Name Computer -Value $computer
				$obj | Add-Member -type NoteProperty -Name User -Value $userLoggedon.username
				$obj | Add-Member -type NoteProperty -Name LogonTime -Value $dt.DateTime
				$obj | Add-Member -type NoteProperty -Name DurationInMinutes -Value $duration.Minutes
				$results += $obj
			}
		}
		if ($results.count -gt 0) { $results | Out-GridView -Title "My Watch List" }
		else { $OutputMain.Text += "None of the machines in your watchlist are online." }
	}

}

function ReportsWatchlists( $object ) {
	$WatchlistFileLoc = '\\techshare\allpublic\watchlist.txt'
	if (-not(Test-Path $WatchlistFileLoc)) {
		$OutputMain.Text += "Watchlist file doesn't exist! $nl"
		$OutputMain.Text += "Place it in the following location: $WatchlistFileLoc $nl"
	}
	else {
		$computers = gc $WatchlistFileLoc
		$results = @{}
		foreach ($computer in $computers) {
			$dt = 0
			if (Test-ConITDepttion $computer -Count 1 -Quiet) {
				$userLoggedon = gwmi win32_computersystem -ComputerName $computer | select username
				if ($userLoggedon.username.length -gt 3) {
					[string]$name = $userLoggedon.username
					$arr = $name.split("\")
					$username = $arr[1]
					$lastLogonTime = (Get-ADUser -Identity $username -Properties *).lastLogon
					$dt = [DateTime]::FromFileTime($lastLogonTime)
					$currentdt = Get-Date
					$duration = $currentdt - $dt
				}
				$obj = New-Object System.Object
				$obj | Add-Member -type NoteProperty -Name Computer -Value $computer
				$obj | Add-Member -type NoteProperty -Name User -Value $userLoggedon.username
				$obj | Add-Member -type NoteProperty -Name LogonTime -Value $dt.DateTime
				$obj | Add-Member -type NoteProperty -Name DurationInMinutes -Value $duration.Minutes
				$results += $obj
			}
		}
		if ($results.count -gt 0) { $results | Out-GridView -Title "Watch List" }
		else { $OutputMain.Text += "None of the machines in your watchlist are online." }
	}
}

#endregion

#region Links
###########################################################
######################## LINKS ############################
###########################################################

function LinksSoftwareDist( $object ) {
	Start-Process '\\techshare\allpublic\SoftwareDist'
}

function LinksSCCMReports( $object ) {
	Start-Process 'http://sccm_server/smsreporting'
}

#endregion

#region About
###########################################################
######################## ABOUT ############################
###########################################################

function about( $object ) {
	$about = "Creator: Jack Neff $nl"
	$about += "Version: 1.0 Beta $nl"
	$about += "Release Date: 11/12/2013 $nl"
	[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
	[Microsoft.VisualBasic.Interaction]::MsgBox($about, 'Information', "About Helpdesk Tools")
}
#endregion


Main # This call must remain below all other event functions

#endregion
