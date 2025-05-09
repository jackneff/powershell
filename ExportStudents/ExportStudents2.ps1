Import-Module ActiveDirectory

#region Form Creation

[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

$UI = New-Object PSObject -Property @{
    "Form1" = New-Object System.Windows.Forms.Form
    "Form2" = New-Object System.Windows.Forms.Form
}

#Form 1
$UI.Form1 = New-Object System.Windows.Forms.Form
$UI.Form1.ClientSize = New-Object System.Drawing.Size(225, 314)
$UI.Form1.Text = "Export Students"

$Form1_Label1 = New-Object System.Windows.Forms.Label
$Form1_Label1.Location = New-Object System.Drawing.Point(13, 13)
$Form1_Label1.Size = New-Object System.Drawing.Size(201, 23)
$Form1_Label1.TabIndex = 0
$Form1_Label1.Text = "Please choose one:"

$Form1_Button1 = New-Object System.Windows.Forms.Button
$Form1_Button1.Location = New-Object System.Drawing.Point(13, 52)
$Form1_Button1.Size = New-Object System.Drawing.Size(201, 68)
$Form1_Button1.TabIndex = 1
$Form1_Button1.Text = "Elementary"
$Form1_Button1.UseVisualStyleBackColor = $true
$Form1_Button1.add_Click({ Button1Click($Form1_Button1) })

$Form1_Button2 = New-Object System.Windows.Forms.Button
$Form1_Button2.Location = New-Object System.Drawing.Point(12, 126)
$Form1_Button2.Size = New-Object System.Drawing.Size(201, 68)
$Form1_Button2.TabIndex = 2
$Form1_Button2.Text = "Middle"
$Form1_Button2.UseVisualStyleBackColor = $true
$Form1_Button2.add_Click({ Button2Click($Form1_Button2) })

$Form1_Button3 = New-Object System.Windows.Forms.Button
$Form1_Button3.Location = New-Object System.Drawing.Point(12, 200)
$Form1_Button3.Size = New-Object System.Drawing.Size(201, 68)
$Form1_Button3.TabIndex = 3
$Form1_Button3.Text = "High"
$Form1_Button3.UseVisualStyleBackColor = $true
$Form1_Button3.add_Click({ Button3Click($Form1_Button3) })

$Form1_StatusBar1 = New-Object System.Windows.Forms.StatusBar
$Form1_StatusBar1.Dock = [System.Windows.Forms.DockStyle]::Bottom
$Form1_StatusBar1.Location = New-Object System.Drawing.Point(0, 292)
$Form1_StatusBar1.Size = New-Object System.Drawing.Size(225, 22)
$Form1_StatusBar1.TabIndex = 4
    
$UI.Form1.Controls.Add($Form1_Label1)
$UI.Form1.Controls.Add($Form1_Button1)
$UI.Form1.Controls.Add($Form1_Button2)
$UI.Form1.Controls.Add($Form1_Button3)
$UI.Form1.Controls.Add($Form1_StatusBar1)

#Form2
$UI.Form2 = New-Object System.Windows.Forms.Form
$UI.Form2.ClientSize = New-Object System.Drawing.Size(225, 335)
$UI.Form2.Text = "Export Students"

$Form2_Label1 = New-Object System.Windows.Forms.Label
$Form2_Label1.Location = New-Object System.Drawing.Point(13, 13)
$Form2_Label1.Size = New-Object System.Drawing.Size(201, 23)
$Form2_Label1.TabIndex = 0
$Form2_Label1.Text = "Please choose one:"

$Form2_Listbox1 = New-Object System.Windows.Forms.ListBox
$Form2_Listbox1.FormattingEnabled = $true
$Form2_Listbox1.Location = New-Object System.Drawing.Point(12, 37)
$Form2_Listbox1.SelectedIndex = -1
$Form2_Listbox1.Size = New-Object System.Drawing.Size(200, 212)
$Form2_Listbox1.TabIndex = 1

$Form2_Button1 = New-Object System.Windows.Forms.Button
$Form2_Button1.Location = New-Object System.Drawing.Point(12, 260)
$Form2_Button1.Size = New-Object System.Drawing.Size(201, 42)
$Form2_Button1.TabIndex = 2
$Form2_Button1.Text = "Select"
$Form2_Button1.UseVisualStyleBackColor = $true
$Form2_Button1.add_Click({ ButtonSelectClick($Form2_Button1) })

$Form2_StatusBar1 = New-Object System.Windows.Forms.StatusBar
$Form2_StatusBar1.Dock = [System.Windows.Forms.DockStyle]::Bottom
$Form2_StatusBar1.Location = New-Object System.Drawing.Point(0, 300)
$Form2_StatusBar1.Size = New-Object System.Drawing.Size(225, 22)
$Form2_StatusBar1.TabIndex = 3

$UI.Form2.Controls.Add($Form2_Listbox1)
$UI.Form2.Controls.Add($Form2_Button1)
$UI.Form2.Controls.Add($Form2_Label1)
$UI.Form2.Controls.Add($Form2_StatusBar1)

#endregion


#region Functions

function SelectSchool {

    switch ($Global:Grade) {
        'ES' {
            $Global:Server = "hostname"
            $Global:BaseOU = "OU"
            $SchoolNames = Get-ADOrganizationalUnit -Server $Global:Server -SearchBase $Global:BaseOU -SearchScope OneLevel -Filter * | 
            ForEach-Object { $arr = $_.DistinguishedName.ToString().Split(","); $arr[0].Replace("OU=", "") }
            $SchoolNames | ForEach-Object { $Form2_Listbox1.Items.Add("$_") }
            $UI.Form1.Hide()
            $UI.Form2.ShowDialog()

        }
        'MS' {
            $Global:Server = "hostname"
            $Global:BaseOU = "OU"
            $SchoolNames = Get-ADOrganizationalUnit -Server $Global:Server -SearchBase $Global:BaseOU -SearchScope OneLevel -Filter * | 
            ForEach-Object { $arr = $_.DistinguishedName.ToString().Split(","); $arr[0].Replace("OU=", "") }
            $SchoolNames | ForEach-Object { $Form2_Listbox1.Items.Add("$_") }
            $UI.Form1.Hide()
            $UI.Form2.ShowDialog()
        }
        'HS' {
            $Global:Server = "hostname"
            $Global:BaseOU = "OU"
            $SchoolNames = Get-ADOrganizationalUnit -Server $Global:Server -SearchBase $Global:BaseOU -SearchScope OneLevel -Filter * | 
            ForEach-Object { $arr = $_.DistinguishedName.ToString().Split(","); $arr[0].Replace("OU=", "") }
            $SchoolNames | ForEach-Object { $Form2_Listbox1.Items.Add("$_") }
            $UI.Form1.Hide()
            $UI.Form2.ShowDialog()
        }       
    }#end switch
}

function Button1Click( $object ) {
    $Form1_StatusBar1.Text = "Finding schools please wait..."
    $Global:Grade = 'ES'
    SelectSchool
}

function Button2Click( $object ) {
    $Form1_StatusBar1.Text = "Finding schools please wait..."
    $Global:Grade = 'MS'
    SelectSchool
}

function Button3Click( $object ) {
    $Form1_StatusBar1.Text = "Finding schools please wait..."
    $Global:Grade = 'HS'
    SelectSchool
}

function ButtonSelectClick ( $object ) {
    $Form2_StatusBar1.Text = "Compiling list please wait..."
    $SchoolName = $Form2_Listbox1.SelectedItem
    $BaseOU = "OU=Users,OU=$SchoolName," + $Global:BaseOU
    $dt = Get-Date -Format "yyyyMMddHHmmss"
    $SavePath = "$($env:UserProfile)\Desktop\Students_$($SchoolName)_$dt.csv"

    #Uncomment for debugging purposes only
    #[System.Windows.Forms.MessageBox]::Show("$BaseOU,$SavePath,$FileName")

    try {
        $StudentAccounts = Get-ADUser -Server $Global:Server -SearchBase $BaseOU -SearchScope OneLevel -Filter * -Properties *
        $StudentAccounts | Select-Object SAMAccountName, SN, GivenName, Initials, EmployeeID | Sort-Object SAMAccountName | Export-Csv -Path $SavePath -NoTypeInformation
        $ItWorked = $true
    } 
    catch {
        $ItWorked = $false
    }

    if ($ItWorked) {
        [System.Windows.Forms.MessageBox]::Show("Report successful!")
        $UI.Form2.Close()
    }
    else {
        [System.Windows.Forms.MessageBox]::Show("Report failed!")
    }
}

#endregion

$UI.Form1.ShowDialog()
