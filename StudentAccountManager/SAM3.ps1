
#region Buid Form

[xml]$XAML= @'
<Window
  xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
  xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
  Title="Comp-Sci Student Account Manager" Height="600" Width="460" ResizeMode="NoResize" 
  WindowStartupLocation="Manual" Left="50" Top="20">
  <Grid>
    <StackPanel Name="LeftPanel" VerticalAlignment="Top" HorizontalAlignment="Left" Width="260" Margin="20,20,0,0">
      <ComboBox Name="SelectSchool" Text="Select School" Width="250" Height="25" HorizontalAlignment="Left"
        IsEditable="True" IsReadOnly="True" BorderThickness="2" />
      <Button Name="DeselectAll" HorizontalAlignment="Right" VerticalAlignment="Bottom" Margin="0,10,10,5"
        Background="Transparent" Foreground="#FF2451CD" Content="Deselect All" BorderBrush="Transparent" />
      <ListBox Name="ListAccounts" Width="250" Height="450" Margin="0,0,10,0" BorderThickness="2" SelectionMode="Multiple" />
    </StackPanel>
    <StackPanel Name="RightPanel" VerticalAlignment="Top" HorizontalAlignment="Left" Width="200" Margin="265,80,0,0">
      <Button Name="ViewProfile" Content="View Profile" Width="150" Height="35" />
      <Button Name="DeleteProfile" Content="Delete Profile(s)" Width="150" Height="35" Margin="0,20" />
    </StackPanel>
    <StatusBar Background="Gray" VerticalAlignment="Bottom" HorizontalAlignment="Stretch" Height="25" Padding="5,0,5,0">
      <TextBlock HorizontalAlignment="Left" VerticalAlignment="Center" Foreground="White" />
    </StatusBar>
  </Grid>
</Window>
'@

$Reader = (New-Object System.Xml.XmlNodeReader $XAML)
$UserInterFace = [Windows.Markup.XamlReader]::Load($Reader)

$Combo_SelectSchool = $UserInterFace.FindName('SelectSchool')
$Btn_DeselectAll = $UserInterFace.FindName('DeselectAll')
$ListBox_Students  = $UserInterFace.FindName('ListAccounts')
$Btn_ViewProfile = $UserInterFace.FindName('ViewProfile')
$Btn_DeleteProfile = $UserInterFace.FindName('DeleteProfile')

#endregion

#region Add Event Handlers

$Combo_SelectSchool.Add_SelectionChanged({
    $ListBox_Students.Items.Clear()
    $BaseOU ='OU'

    $StudentAccts = Get-ADUser -SearchBase $BaseOU -SearchScope OneLevel -Filter * -Properties *
    $StudentAccts | ForEach-Object { $ListBox_Students.Items.Add($_.CN) | Out-Null }
})

$Btn_DeselectAll.Add_Click({ $ListBox_Students.SelectedItems.Clear() })

$Btn_ViewProfile.Add_Click({
    if ($ListBox_Students.Items.Count -gt 1){
        [System.Windows.Forms.MessageBox]::Show("You may only view one profile at a time")
    } else {
        #TODO:  Show dialog for signle user.  Will need another XAML form.
    }
})

$Btn_DeleteProfile.Add_Click({

    $Selected = $ListBox_Students.SelectedItems
    $CountSelected = $Selected.Count
    $Choice = [System.Windows.Forms.MessageBox]::Show("You are about to delete $CountSelected accounts.  Do you wish to proceed?","Warning",
    [System.Windows.Forms.MessageBoxButtons]::YesNoCancel,
    [System.Windows.Forms.MessageBoxIcon]::Warning)

    if ($Choice -eq "Yes"){
        foreach ($Name in $Selected){
            $StatusBar.Text = "Moving $Name home directory"
            Move-Item -Path "\\$Severname\HOMEDIR$\$Name" -Destination "$Servername\Expired\Students" -Force
            $StatusBar.Text = "Deleting $Name account"
            Get-ADUser -Identity $Name | Remove-ADUser
            $StatusBar.Text = ""
        }
        while($ListBox.SelectedItems -gt 0){
            $ListBox.Items.Remove($ListBox.SelectedItems[0])
        }
        [System.Windows.Forms.MessageBox]::Show("Process Complete!")
    }
})

#endregion


$SchoolNames = 'Brunswick','Catoctin','Frederick','Linganore','Middletown','Oakdale','Thomas_Johnson','Tuscarora','Urbana','Walkersville'


function Main {

    $SchoolNames | ForEach-Object { $Combo_SelectSchool.Items.Add("$_") | Out-Null }
    $UserInterFace.ShowDialog() | Out-Null

}


Function Get-StudentAccounts ($SchoolName) {
    
    $Root="OU"
    $Searcher = New-Object System.DirectoryServices.DirectorySearcher
    $Searcher.Filter = "(objectCategory=User)"
    $Searcher.SearchRoot = New-Object System.DirectoryServices.DirectoryEntry("LDAP://$Root")
    $Searcher.SearchScope = "OneLevel"
    "CN" | ForEach-Object { $Searcher.PropertiesToLoad.Add($_) }
    $Results = $Searcher.FindAll()

    $ListBox_Students.Items.Clear()

    foreach ($Result in $Results) {
        $ListBox_Students.Items.Add($Result.CN)
    }
}

function View-Profile {

}
    

Main
