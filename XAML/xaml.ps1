Add-Type -Assembly PresentationFramework

[xml]$XAML_ConnectDialog = @"
<Window Name="Form_ConnectDialog"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="Connect" Height="176" Width="328" ResizeMode="NoResize" ShowInTaskbar="False">
    <Grid>
        <Grid.Background>
            <LinearGradientBrush EndPoint="0.5,1" MappingMode="RelativeToBoundingBox" StartPoint="0.5,0">
                <GradientStop Color="#FFB4B4B4" Offset="1"/>
                <GradientStop Color="White" Offset="0.603"/>
            </LinearGradientBrush>
        </Grid.Background>
        <TextBlock TextWrapping="Wrap" Text="Enter the hostname or IP address of the remote host to connect to." Margin="10,0,10,91"/>
        <Label Content="Connect To:" HorizontalAlignment="Left" Height="27" VerticalAlignment="Top" Width="76" Margin="10,47,0,0"/>
        <Button Name="Btn_ConnectDialog_Connect" Content="Connect" Height="20" Margin="194,88,26,20" IsDefault="True"/>
        <TextBox Name="Txt_ConnectDialog_Input" HorizontalAlignment="Left" Height="23" Margin="91,51,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="208"/>
    </Grid>
</Window>
"@

$XML_Node_Reader_ConnectDialog = (New-Object System.Xml.XmlNodeReader $XAML_ConnectDialog)
$ConnectDialog = [Windows.Markup.XamlReader]::Load($XML_Node_Reader_ConnectDialog)
$Btn_ConnectDialog_Connect = $ConnectDialog.FindName('Btn_ConnectDialog_Connect')
$Txt_ConnectDialog_Input = $ConnectDialog.FindName('Txt_ConnectDialog_Input')


$Btn_ConnectDialog_Connect.Add_Click({
    $ConnectDialog.Hide()
    $script:var = $Txt_ConnectDialog_Input.Text.ToString()
})

$ConnectDialog.ShowDialog() | Out-Null
write-host $var