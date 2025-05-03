[xml]$MainPage = @"

<Window Name="Form1"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    Title="Form1" Height="300" Width="600" ResizeMode="NoResize" ShowInTaskbar="False">

    <Grid>
        <Button Name="Button1" Content="Button" HorizontalAlignment="Left" Margin="20,20,0,0" VerticalAlignment="Top" Height="30" Width="100"/>
        <TextBox Name="TB1" HorizontalAlignment="Left" Margin="20,80,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Height="42" Width="500"/>

    </Grid>
</Window>

"@

$Reader = (New-Object System.Xml.XmlNodeReader $MainPage)
$MainDialog = [Windows.Markup.XamlReader]::Load($Reader)
$Button1 = $MainDialog.FindName('Button1')
$Textbox1 = $MainDialog.FindName('TB1')

$Button1.Add_Click({
    $Textbox1.Text = "You clicked the button!"
})

$MainDialog.ShowDialog() | Out-Null


