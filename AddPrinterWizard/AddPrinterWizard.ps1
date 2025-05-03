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
#~~< MainForm >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$MainForm = New-Object System.Windows.Forms.Form
$MainForm.ClientSize = New-Object System.Drawing.Size(422, 225)
$MainForm.Text = "Add Printer Wizard"
#~~< btn_ClearForm >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$btn_ClearForm = New-Object System.Windows.Forms.Button
$btn_ClearForm.Location = New-Object System.Drawing.Point(308, 177)
$btn_ClearForm.Size = New-Object System.Drawing.Size(84, 33)
$btn_ClearForm.TabIndex = 16
$btn_ClearForm.Text = "Clear"
$btn_ClearForm.UseVisualStyleBackColor = $true
$btn_ClearForm.add_Click({ClearForm($btn_ClearForm)})
#~~< btn_AddPrinterSubmit >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$btn_AddPrinterSubmit = New-Object System.Windows.Forms.Button
$btn_AddPrinterSubmit.Location = New-Object System.Drawing.Point(218, 177)
$btn_AddPrinterSubmit.Size = New-Object System.Drawing.Size(84, 33)
$btn_AddPrinterSubmit.TabIndex = 15
$btn_AddPrinterSubmit.Text = "Add Printer"
$btn_AddPrinterSubmit.UseVisualStyleBackColor = $true
$btn_AddPrinterSubmit.add_Click({AddPrinterSubmit($btn_AddPrinterSubmit)})
#~~< lbl_ExampleComment >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$lbl_ExampleComment = New-Object System.Windows.Forms.Label
$lbl_ExampleComment.Font = New-Object System.Drawing.Font("Tahoma", 8.25, [System.Drawing.FontStyle]::Italic, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$lbl_ExampleComment.Location = New-Object System.Drawing.Point(280, 126)
$lbl_ExampleComment.Size = New-Object System.Drawing.Size(131, 23)
$lbl_ExampleComment.TabIndex = 14
$lbl_ExampleComment.Text = "Ex: Front Office Rm 123"
#~~< lbl_ExamplePrinterName >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$lbl_ExamplePrinterName = New-Object System.Windows.Forms.Label
$lbl_ExamplePrinterName.Font = New-Object System.Drawing.Font("Tahoma", 8.25, [System.Drawing.FontStyle]::Italic, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$lbl_ExamplePrinterName.Location = New-Object System.Drawing.Point(280, 43)
$lbl_ExamplePrinterName.Size = New-Object System.Drawing.Size(131, 23)
$lbl_ExamplePrinterName.TabIndex = 13
$lbl_ExamplePrinterName.Text = "Ex: TJMS-144-H4505"
#~~< lbl_Comment >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$lbl_Comment = New-Object System.Windows.Forms.Label
$lbl_Comment.Location = New-Object System.Drawing.Point(14, 151)
$lbl_Comment.Size = New-Object System.Drawing.Size(74, 23)
$lbl_Comment.TabIndex = 12
$lbl_Comment.Text = "Comment"
#~~< tb_Comment >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$tb_Comment = New-Object System.Windows.Forms.TextBox
$tb_Comment.Font = New-Object System.Drawing.Font("Tahoma", 8.25, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$tb_Comment.Location = New-Object System.Drawing.Point(94, 150)
$tb_Comment.Size = New-Object System.Drawing.Size(298, 21)
$tb_Comment.TabIndex = 11
$tb_Comment.Text = ""
$tb_Comment.UseWaitCursor = $false
#~~< lbl_Location >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$lbl_Location = New-Object System.Windows.Forms.Label
$lbl_Location.Location = New-Object System.Drawing.Point(14, 124)
$lbl_Location.Size = New-Object System.Drawing.Size(74, 23)
$lbl_Location.TabIndex = 10
$lbl_Location.Text = "Location"
#~~< tb_Location >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$tb_Location = New-Object System.Windows.Forms.TextBox
$tb_Location.Font = New-Object System.Drawing.Font("Tahoma", 8.25, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$tb_Location.Location = New-Object System.Drawing.Point(94, 123)
$tb_Location.Size = New-Object System.Drawing.Size(180, 21)
$tb_Location.TabIndex = 9
$tb_Location.Text = ""
$tb_Location.UseWaitCursor = $false
#~~< btn_AddDriver >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$btn_AddDriver = New-Object System.Windows.Forms.Button
$btn_AddDriver.Location = New-Object System.Drawing.Point(348, 94)
$btn_AddDriver.Size = New-Object System.Drawing.Size(44, 22)
$btn_AddDriver.TabIndex = 8
$btn_AddDriver.Text = "+"
$btn_AddDriver.UseVisualStyleBackColor = $true
$btn_AddDriver.add_Click({btn_AddDriver($btn_AddDriver)})
#~~< cbox_driver >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$cbox_driver = New-Object System.Windows.Forms.ComboBox
$cbox_driver.FormattingEnabled = $true
$cbox_driver.Location = New-Object System.Drawing.Point(94, 96)
$cbox_driver.SelectedIndex = -1
$cbox_driver.Size = New-Object System.Drawing.Size(248, 21)
$cbox_driver.TabIndex = 7
$cbox_driver.Text = ""
FetchDriverNames
#~~< lbl_Driver >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$lbl_Driver = New-Object System.Windows.Forms.Label
$lbl_Driver.Location = New-Object System.Drawing.Point(14, 99)
$lbl_Driver.Size = New-Object System.Drawing.Size(74, 23)
$lbl_Driver.TabIndex = 6
$lbl_Driver.Text = "Driver"
#~~< cbox_Port >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$cbox_Port = New-Object System.Windows.Forms.ComboBox
$cbox_Port.FormattingEnabled = $true
$cbox_Port.Location = New-Object System.Drawing.Point(94, 69)
$cbox_Port.SelectedIndex = -1
$cbox_Port.Size = New-Object System.Drawing.Size(130, 21)
$cbox_Port.TabIndex = 5
$cbox_Port.Text = ""
FetchPrinterPorts
#~~< btn_AddPort >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$btn_AddPort = New-Object System.Windows.Forms.Button
$btn_AddPort.Location = New-Object System.Drawing.Point(230, 69)
$btn_AddPort.Size = New-Object System.Drawing.Size(44, 22)
$btn_AddPort.TabIndex = 4
$btn_AddPort.Text = "+"
$btn_AddPort.UseVisualStyleBackColor = $true
$btn_AddPort.add_Click({btn_AddPort($btn_AddPort)})
#~~< lbl_Port >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$lbl_Port = New-Object System.Windows.Forms.Label
$lbl_Port.Location = New-Object System.Drawing.Point(14, 72)
$lbl_Port.Size = New-Object System.Drawing.Size(74, 23)
$lbl_Port.TabIndex = 3
$lbl_Port.Text = "Port"
#~~< lbl_PrinterName >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$lbl_PrinterName = New-Object System.Windows.Forms.Label
$lbl_PrinterName.Location = New-Object System.Drawing.Point(14, 41)
$lbl_PrinterName.Size = New-Object System.Drawing.Size(74, 23)
$lbl_PrinterName.TabIndex = 1
$lbl_PrinterName.Text = "Printer Name"
#~~< tb_PrinterName >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$tb_PrinterName = New-Object System.Windows.Forms.TextBox
$tb_PrinterName.Font = New-Object System.Drawing.Font("Tahoma", 8.25, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$tb_PrinterName.Location = New-Object System.Drawing.Point(94, 40)
$tb_PrinterName.Size = New-Object System.Drawing.Size(180, 21)
$tb_PrinterName.TabIndex = 0
$tb_PrinterName.Text = ""
$tb_PrinterName.UseWaitCursor = $false
$MainForm.Controls.Add($btn_ClearForm)
$MainForm.Controls.Add($btn_AddPrinterSubmit)
$MainForm.Controls.Add($lbl_ExampleComment)
$MainForm.Controls.Add($lbl_ExamplePrinterName)
$MainForm.Controls.Add($lbl_Comment)
$MainForm.Controls.Add($tb_Comment)
$MainForm.Controls.Add($lbl_Location)
$MainForm.Controls.Add($tb_Location)
$MainForm.Controls.Add($btn_AddDriver)
$MainForm.Controls.Add($cbox_driver)
$MainForm.Controls.Add($lbl_Driver)
$MainForm.Controls.Add($cbox_Port)
$MainForm.Controls.Add($btn_AddPort)
$MainForm.Controls.Add($lbl_Port)
$MainForm.Controls.Add($lbl_PrinterName)
$MainForm.Controls.Add($tb_PrinterName)

#endregion

#region Custom Code

#endregion

#region Event Loop

function Main{
	[System.Windows.Forms.Application]::EnableVisualStyles()
	[System.Windows.Forms.Application]::Run($MainForm)
}

#endregion

#endregion

#region Event Handlers

function FetchPrinterPorts {
    $PrinterPorts = Get-WmiObject -Class Win32_TCPIPPrinterPort | Select Name | Sort Name | ForEach-Object {
        $tmpArr = ($_.Name.Split(","))
        $cbox_Port.Items.Add($tmpArr[0])   
    }
}

function FetchDriverNames {
    $DriverNames = Get-WmiObject -Class Win32_PrinterDriver | Select Name | Sort Name | ForEach-Object {
        $tmpArr = ($_.Name.Split(","))
        $cbox_driver.Items.Add($tmpArr[0])   
    }
}

function btn_AddPort( $object ){
    [System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
    $IPAddress = [Microsoft.VisualBasic.Interaction]::InputBox("Enter an IP Address", "Create TCP/IP Printer Port", "")
    $wShell = New-Object -ComObject Wscript.Shell

    try {
        $port = [wmiclass]"Win32_TcpIpPrinterPort"
        $newPort = $port.CreateInstance()
        $newport.Name= "IP_$IPAddress"
        $newport.SNMPEnabled=$false
        $newport.Protocol=1
        $newport.HostAddress= $IPAddress
        $newport.Put()
        $wShell.Popup("Creating TCP/IP Port was successful!")
        $cbox_Port.Items.Clear()
        FetchPrinterPorts
        $cbox_Port.Refresh()
    } 
    catch {
        $wShell.Popup("Creating TCP/IP Port failed!")
    }

}

function btn_AddDriver( $object ){
    $Answer = [System.Windows.Forms.MessageBox]::Show("Adding a new driver requires you to close the Add Printer Wizard.  Do you wish to proceed?" , "" , 4)
    if ($Answer -eq "Yes"){
        Invoke-Expression "Rundll32 printui.dll,PrintUIEntry /id"
        $MainForm.Close()
    } else {
        #Do nothing
    }
}

function ClearForm( $object ){
   $tb_PrinterName.Clear()
   $tb_Location.Clear()
   $tb_Comment.Clear()
   $cbox_Driver.ResetText()
   $cbox_Port.ResetText()
}

function CreatePrinter {
    Param (
    [string]$PrinterName,
    [string]$DriverName,
    [string]$PortName,
    [string]$Location,
    [string]$Comment
    )

    $print = [WMICLASS]"Win32_Printer"
    $newprinter = $print.createInstance()
    $newprinter.Drivername = $DriverName
    $newprinter.PortName = "$PortName"
    $newprinter.Shared = $true
    $newprinter.Sharename = $PrinterName
    $newprinter.Location = $Location
    $newprinter.Comment = $Comment
    $newprinter.DeviceID = $PrinterName
    $newprinter.Put()
}

function AddPrinterSubmit( $object ){
    #Do some error checking

    $wShell = New-Object -ComObject Wscript.Shell
    $wShell.Popup("$($tb_PrinterName.text),$($cbox_driver.Text),$($cbox_port.Text),$($tb_Location.text),$($tb_Comment.Text)")

    try {
        CreatePrinter -PrinterName $($tb_PrinterName.Text) -DriverName $($cbox_driver.Text) -PortName $($cbox_Port.Text) -Location $($tb_Location.Text) -Comment $($tb_Comment.Text)
        $wShell.Popup("Creating New Printer was successful!")
        ClearForm
    }
    catch {
        $wShell.Popup("Creating New Printer failed!")
    }
}

Main # This call must remain below all other event functions

#endregion
