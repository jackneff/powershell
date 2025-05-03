

#region ScriptForm Designer


$Form1 = New-Object System.Windows.Forms.Form
$Form1.ClientSize = New-Object System.Drawing.Size(495, 452)
$Form1.Text = "CS Student Account Delete"

    $Lbl_UserName = New-Object System.Windows.Forms.Label
    $Lbl_UserName.Font = New-Object System.Drawing.Font("Tahoma", 8.25, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
    $Lbl_UserName.Location = New-Object System.Drawing.Point(38, 9)
    $Lbl_UserName.Size = New-Object System.Drawing.Size(422, 23)
    $Lbl_UserName.TabIndex = 9
    $Lbl_UserName.Text = ""
    $Lbl_UserName.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter

    $Lbl_NameCount = New-Object System.Windows.Forms.Label
    $Lbl_NameCount.Font = New-Object System.Drawing.Font("Tahoma", 8.25, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
    $Lbl_NameCount.Location = New-Object System.Drawing.Point(197, 326)
    $Lbl_NameCount.Size = New-Object System.Drawing.Size(104, 55)
    $Lbl_NameCount.TabIndex = 10
    $Lbl_NameCount.Text = ""
    $Lbl_NameCount.TextAlign = [System.Drawing.ContentAlignment]::BottomCenter

    $Lbl_StudentAccounts = New-Object System.Windows.Forms.Label
    $Lbl_StudentAccounts.Location = New-Object System.Drawing.Point(38, 36)
    $Lbl_StudentAccounts.Size = New-Object System.Drawing.Size(153, 23)
    $Lbl_StudentAccounts.TabIndex = 7
    $Lbl_StudentAccounts.Text = "Student Accounts"
    $Lbl_StudentAccounts.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter

    $ListBox1 = New-Object System.Windows.Forms.ListBox
    $ListBox1.AccessibleDescription = "Hold CTRL to select multiple items"
    $ListBox1.FormattingEnabled = $true
    $ListBox1.Location = New-Object System.Drawing.Point(38, 65)
    $ListBox1.SelectedIndex = -1
    $ListBox1.SelectionMode = [System.Windows.Forms.SelectionMode]::MultiExtended
    $ListBox1.Size = New-Object System.Drawing.Size(153, 316)
    $ListBox1.TabIndex = 0

    $ListBox2 = New-Object System.Windows.Forms.ListBox
    $ListBox2.FormattingEnabled = $true
    $ListBox2.Location = New-Object System.Drawing.Point(307, 65)
    $ListBox2.SelectedIndex = -1
    $ListBox2.SelectionMode = [System.Windows.Forms.SelectionMode]::MultiExtended
    $ListBox2.Size = New-Object System.Drawing.Size(153, 316)
    $ListBox2.TabIndex = 1

    $Lbl_ToBeDeleted = New-Object System.Windows.Forms.Label
    $Lbl_ToBeDeleted.Location = New-Object System.Drawing.Point(307, 36)
    $Lbl_ToBeDeleted.Size = New-Object System.Drawing.Size(153, 23)
    $Lbl_ToBeDeleted.TabIndex = 8
    $Lbl_ToBeDeleted.Text = "To Be Deleted"
    $Lbl_ToBeDeleted.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter

    $Btn_Add = New-Object System.Windows.Forms.Button
    $Btn_Add.Location = New-Object System.Drawing.Point(197, 157)
    $Btn_Add.Size = New-Object System.Drawing.Size(104, 32)
    $Btn_Add.TabIndex = 2
    $Btn_Add.Text = "Add >>"
    $Btn_Add.UseVisualStyleBackColor = $true
    $Btn_Add.add_Click({Button_AddName($Btn_Add)})

    $Btn_Remove = New-Object System.Windows.Forms.Button
    $Btn_Remove.Location = New-Object System.Drawing.Point(197, 195)
    $Btn_Remove.Size = New-Object System.Drawing.Size(104, 32)
    $Btn_Remove.TabIndex = 3
    $Btn_Remove.Text = "<< Remove"
    $Btn_Remove.UseVisualStyleBackColor = $true
    $Btn_Remove.add_Click({Button_RemoveName($Btn_Remove)})

    $Btn_DeleteAccounts = New-Object System.Windows.Forms.Button
    $Btn_DeleteAccounts.Location = New-Object System.Drawing.Point(377, 387)
    $Btn_DeleteAccounts.Size = New-Object System.Drawing.Size(83, 32)
    $Btn_DeleteAccounts.TabIndex = 5
    $Btn_DeleteAccounts.Text = "Delete"
    $Btn_DeleteAccounts.UseVisualStyleBackColor = $true
    $Btn_DeleteAccounts.add_Click({Button_DeleteAccounts($Btn_DeleteAccounts)})

    $StatusBar = New-Object System.Windows.Forms.StatusBar
    $StatusBar.Dock = [System.Windows.Forms.DockStyle]::Bottom
    $StatusBar.Location = New-Object System.Drawing.Point(0, 430)
    $StatusBar.Size = New-Object System.Drawing.Size(495, 22)
    $StatusBar.TabIndex = 6
    $StatusBar.Text = ""

$Form1.Controls.Add($Lbl_NameCount)
$Form1.Controls.Add($Lbl_UserName)
$Form1.Controls.Add($Lbl_ToBeDeleted)
$Form1.Controls.Add($Lbl_StudentAccounts)
$Form1.Controls.Add($StatusBar)
$Form1.Controls.Add($Btn_DeleteAccounts)
$Form1.Controls.Add($Btn_Remove)
$Form1.Controls.Add($Btn_Add)
$Form1.Controls.Add($ListBox2)
$Form1.Controls.Add($ListBox1)
$Form1.add_Load({Form1Load($Form1)})

#endregion


#region Event Handlers

function Form1Load($object){
    $Lbl_UserName.Text = "RUNNING AS: $env:USERNAME @ $SchoolName"
    $StatusBar.Text="Retrieving student accounts"

    $User = Get-ADUser -Identity $env:USERNAME
    $SchoolName = ($User.DistinguishedName).Split(",") | Select-Object -Index 2 | ForEach-Object { $_.Replace("OU=","") }
    $StudentOU = "OU=Students,OU=$SchoolName,OU=Schools,DC=cs,DC=fcps,DC=org"
    $Global:StudentAccounts = Get-ADUser -Filter * -SearchBase $StudentOU -SearchScope OneLevel -Properties * | sort CN

    ForEach ($Student in $StudentAccounts) { $ListBox1.Items.Add($Student.CN) }
    
    $StatusBar.Text = ""
}

function Button_DeleteAccounts($object){

    $TimeStamp = Get-Date -Format yyyyMMddmmss
    $Log = "Log_DeleteStudentAccounts_$TimeStamp.txt"
    "Computer Science User Deletion Script" >> $Log
    "Initiated by $env:USERNAME" >> $Log
    Get-Date >> $Log
    "$($ListBox2.SelectedItems.Count) student accounts marked for deletion" >> $Log
    "==========Beginning account deletions=========" >> $Log

    $ArchiveDir = "D:\Expired\Students\$(Get-Date -f YYYY)"
    if (-not(Test-Path $ArchiveDir)){
            New-Item -Path $ArchiveDir -ItemType Directory | Out-Null
        }

    ForEach ($Name in $ListBox2.SelectedItems){
        $StudentAccount = $Global:StudentAccounts | Where-Object { $_.CN -eq $Name }
        $UserHomeDir = "D:\Shared\HomeDir\Students\$($StudentAccount.GivenName).$($StudentAccount.Surname)"
        
        "$Name selected for deletion" >> $Log    

        if (Test-Path $SPath){
            Move-Item -Path $SPath -Destination $DPath -Force | Out-Null
            "Successfully archived $UserHomeDir"
        } else {
            "User home path ($UserHomeDir) doesn't exist"
        }

        $StudentAccount | Remove-ADUser
    }#end ForEach loop
}

function Button_RemoveName($object){
    $ListBox2.SelectedItems | ForEach-Object { $ListBox1.Items.Add($_) | Out-Null }
    for ($i = ($ListBox2.SelectedItems.Count - 1); $i -ge 0; $i--){
        $ListBox2.Items.RemoveAt($ListBox2.SelectedIndices[$i])
    }
    $Lbl_NameCount.Text = "$($ListBox2.Items.Count) items selected"
}

function Button_AddName($object){
    $ListBox1.SelectedItems | ForEach-Object { $ListBox2.Items.Add($_) | Out-Null }
    for ($i = ($ListBox1.SelectedItems.Count - 1); $i -ge 0; $i--){
        $ListBox1.Items.RemoveAt($ListBox1.SelectedIndices[$i])
    }
    $Lbl_NameCount.Text = "$($ListBox2.Items.Count) items selected"
}

function ArchiveStudentHomeDir($Name){
    $SPath = ""
    $DPath = ""
    
    Move-Item -Path $SPath -Destination $DPath -Force
}


$Form1.ShowDialog()

#endregion
