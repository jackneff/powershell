Add-Type -AssemblyName PresentationFramework

[xml]$XAML = @"
<Window 
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="School Account Report Generator" Height="385.74" Width="547.184" ResizeMode="NoResize" WindowStartupLocation="CenterScreen">
    <Grid>
        <Label Name="Lbl_SchoolName" Content="School Name:" HorizontalAlignment="Left" Margin="30,58,0,0" VerticalAlignment="Top"/>
        <ComboBox Name="SchoolName" HorizontalAlignment="Left" Margin="177,62,0,0" VerticalAlignment="Top" Width="151"/>
        <Label Name="Lbl_SchoolLevel" Content="Level:" HorizontalAlignment="Left" Margin="30,20,0,0" VerticalAlignment="Top"/>
        <ComboBox Name="SchoolLevel" HorizontalAlignment="Left" Margin="177,24,0,0" VerticalAlignment="Top" Width="69">
            <ComboBoxItem Content="ES" />
            <ComboBoxItem Content="HSMS" />
        </ComboBox>
        <Label Name="Lbl_Options" Content="Filter:" HorizontalAlignment="Left" Margin="30,96,0,0" VerticalAlignment="Top"/>
        <CheckBox Name="AddFolderSizes" Content="Include Home Directory Sizes (Increases Runtime!)" HorizontalAlignment="Left" Margin="177,147,0,0" VerticalAlignment="Top" />
        <ComboBox Name="Filter" HorizontalAlignment="Left" Margin="177,100,0,0" VerticalAlignment="Top" Width="120" IsSynchronizedWithCurrentItem="True">
            <ComboBoxItem Content="Staff" />
            <ComboBoxItem Content="Student" />
            <ComboBoxItem Content="Both" />
        </ComboBox>
        <Label Name="Lbl_SaveLocaiton" Content="Save To:" HorizontalAlignment="Left" Margin="20,191,0,0" VerticalAlignment="Top"/>
        <TextBox Name="SavePath" HorizontalAlignment="Left" Height="23" Margin="79,195,0,0" TextWrapping="Wrap" Text="C:\users\desktop" VerticalAlignment="Top" Width="336"/>
        <Button Name="BrowseFolder" Content="Browse..." HorizontalAlignment="Left" Margin="434,195,0,0" VerticalAlignment="Top" Width="75"/>
        <Button Name="Reset" Content="Reset" HorizontalAlignment="Left" Margin="290,252,0,0" VerticalAlignment="Top" Width="103" Height="42"/>
        <Button Name="Run" Content="Generate Report" HorizontalAlignment="Left" Margin="408,252,0,0" VerticalAlignment="Top" Width="101" Height="42"/>
        <StatusBar HorizontalAlignment="Left" Height="35" Margin="0,323,-20,0" VerticalAlignment="Top" Width="561">
            <Label Name="Status" Content="Hello" />
        </StatusBar>
    </Grid>
</Window>
"@

$Reader = (New-Object System.Xml.XmlNodeReader $XAML)
$UI = [Windows.Markup.XamlReader]::Load($Reader)
$XAML.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name ($_.Name) -Value $UI.FindName($_.Name) }

$Status.Content = "A"
$UI.ShowDialog()