#region Form Building

[xml]$MainForm = @'

<Window 
  xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" 
  xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" 
  Width="885" Height="600" ResizeMode="CanMinimize" Title="PowerTools v2.0" WindowStartupLocation="CenterScreen">
   <Grid>
      <Grid.RowDefinitions>
         <RowDefinition Height="70"/>
         <RowDefinition Height="250"/>
         <RowDefinition Height="280"/>
      </Grid.RowDefinitions>
      <Grid.ColumnDefinitions>
         <ColumnDefinition Width="220"/>
         <ColumnDefinition Width="220"/>
         <ColumnDefinition Width="220"/>
         <ColumnDefinition Width="220"/>
      </Grid.ColumnDefinitions>
      <StackPanel Grid.Column="0" Grid.ColumnSpan="4" Grid.Row="0" Background="#FF49415C" Orientation="Horizontal">
         <TextBox Name="Input1" Width="250" Height="28" HorizontalAlignment="Left" Margin="60,0,20,0" VerticalAlignment="Center" FontSize="14" TextAlignment="Left" Text="localhost"/>
         <Button Name="Search" Width="70" Height="24" VerticalAlignment="Center" Content="Search"/>
      </StackPanel>
      <TextBlock Name="MainTitle" Grid.Column="1" Grid.ColumnSpan="3" Grid.Row="0" VerticalAlignment="Center" FontSize="30" Foreground="White" Padding="0,0,30,0" Text="Power Tools v2.0" TextAlignment="Right"/>
      <StackPanel Name="Mid1" Grid.Column="0" Grid.Row="1">
         <Button Name="WhosLoggedOn" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,10,0,5" VerticalAlignment="Top" Content="Whos Logged On" Padding="2"/>
         <Button Name="SystemInfo" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="System Info" Padding="2"/>
         <Button Name="RemoteControl" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="Remote Control" Padding="2"/>
         <Button Name="RemoteDesktop" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="Remote Desktop" Padding="2"/>
         <Button Name="LogoffUser" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="Logoff User" Padding="2"/>
         <Button Name="Restart" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="Restart" Padding="2"/>
      </StackPanel>
      <StackPanel Name="Mid2" Grid.Column="1" Grid.Row="1">
         <Button Name="Ping" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,10,0,5" VerticalAlignment="Top" Content="Ping" Padding="2"/>
         <Button Name="TraceRoute" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="Trace Route" Padding="2"/>
         <Button Name="IPSettings" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="IP Settings" Padding="2"/>
         <Button Name="IPConfigRenew" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="Renew IP" Padding="2"/>
         <Button Name="GPUpdate" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="Refresh Group Policy" Padding="2"/>
         <Button Name="GPResult" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="View Applied Policies" Padding="2"/>
      </StackPanel>
      <StackPanel Name="Mid3" Grid.Column="2" Grid.Row="1">
         <Button Name="Manage" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,10,0,5" VerticalAlignment="Top" Content="Manage" Padding="2"/>
         <Button Name="Regedit" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="Reg Edit" Padding="2"/>
         <Button Name="EnableWinRM" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="Enable WinRM" Padding="2"/>
         <Button Name="WindowsLogs" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="Windows Logs" Padding="2"/>
         <Button Name="OpenCShare" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="Open C$" Padding="2"/>
         <Button Name="OpenShell" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="Open Shell" Padding="2"/>
      </StackPanel>
      <StackPanel Name="Mid4" Grid.Column="3" Grid.Row="1">
         <Button Name="Uptime" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,10,0,5" VerticalAlignment="Top" Content="System Uptime" Padding="2"/>
         <Button Name="Applications" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="Applications" Padding="2"/>
         <Button Name="ConfMgrHealthCheck" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="Check ConfMgr Health" Padding="2"/>
         <Button Name="ConfMgrActions" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="Trigger ConfMgr Actions" Padding="2"/>
         <Button Name="ConfMgrRepair" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="Repair ConfMgr" Padding="2"/>
         <Button Name="RepairWMI" Width="200" Height="30" HorizontalAlignment="Center" Margin="0,5" VerticalAlignment="Top" Content="Repair WMI" Padding="2"/>
      </StackPanel>
      <StackPanel Name="TextBoxControls" Grid.Column="2" Grid.ColumnSpan="2" Grid.Row="2" HorizontalAlignment="Right" Margin="0,0,15,0" VerticalAlignment="Top" Orientation="Horizontal">
         <Label Name="Clear" Width="50" Foreground="Blue">
            <Underline>Clear</Underline>
         </Label>
         <Label Name="Export" Width="50" Foreground="Blue">
            <Underline>Export</Underline>
         </Label>
      </StackPanel>
      <StackPanel Name="Bottom" Grid.Column="0" Grid.ColumnSpan="4" Grid.Row="3">
         <ScrollViewer>
           <TextBox Name="DisplayBox" Width="855" Height="200" HorizontalAlignment="Left" Margin="10,25,0,10" BorderBrush="Gray" BorderThickness="2"
             ScrollViewer.HorizontalScrollBarVisibility="Auto" VerticalScrollBarVisibility="Auto"/>
         </ScrollViewer>
      </StackPanel>
   </Grid>
</Window>

'@

#region

#region Import Form Controls

$Reader = (New-Object System.Xml.XmlNodeReader $MainForm)
$UserInterFace = [Windows.Markup.XamlReader]::Load($Reader)

#Main Input
$Input1 = $UserInterFace.FindName('Input1')
$Output1 = $UserInterFace.FindName('DisplayBox')

#Buttons Col1
$Btn_WhosLoggedOn = $UserInterFace.FindName('WhosLoggedOn')
$Btn_SystemInfo = $UserInterFace.FindName('SystemInfo')
$Btn_RemoteControl = $UserInterFace.FindName('RemoteControl')
$Btn_RemoteDesktop = $UserInterFace.FindName('RemoteDesktop')
$Btn_LogoffUser = $UserInterFace.FindName('LogoffUser')
$Btn_Restart = $UserInterFace.FindName('Restart')

#Buttons Col2
$Btn_Ping = $UserInterFace.FindName('Ping')
$Btn_TraceRoute = $UserInterFace.FindName('TraceRoute')
$Btn_IPSettings = $UserInterFace.FindName('IPSettings')
$Btn_IPConfigRenew = $UserInterFace.FindName('IPRenew')
$Btn_GPUpdate = $UserInterFace.FindName('GPUpdate')
$Btn_GPResult = $UserInterFace.FindName('GPResult')

#Buttons Col3
$Btn_Manage = $UserInterFace.FindName('Manage')
$Btn_Regedit = $UserInterFace.FindName('Regedit')
$Btn_EnableWinRM = $UserInterFace.FindName('EnableWinRM')
$Btn_WindowsLogs = $UserInterFace.FindName('WindowsLogs')
$Btn_OpenCShare = $UserInterFace.FindName('OpenCShare')
$Btn_OpenShell = $UserInterFace.FindName('OpenShell')

#Button Col4
$Btn_Uptime = $UserInterFace.FindName('Uptime')
$Btn_Applications = $UserInterFace.FindName('Applications')
$Btn_ConfMgrHealthCheck = $UserInterFace.FindName('ConfMgrHealthCheck')
$Btn_ConfMgrActions = $UserInterFace.FindName('ConfMgrActions')
$Btn_ConfMgrRepair = $UserInterFace.FindName('ConfMgrRepair')
$Btn_RepairWMI = $UserInterFace.FindName('RepairWMI')

#endregion

#region Button Event Handlers

$ErrorActionPreference = "Stop"
$nl = [System.Environment]::NewLine

$Btn_WhosLoggedOn.Add_Click({
    try {
        $User = Get-WmiObject -Class Win32_Computersystem -ComputerName $($Input1.Text) | select -ExpandProperty Username
        if ($User -ne $null){
            $Output1.AppendText($nl)
            $Output1.Text += "WhosLoggedOn[$($Input1.Text)]::: $User"
        } else {
            $Output1.AppendText($nl)
            $Output1.Text += "WhosLoggedOn[$($Input1.Text)]::: Vacant"
        }
    }
    catch {
        $Output1.AppendText($nl)
        $Output1.Text += "WhosLoggedOn[$($Input1.Text)]::: Failed"
    }
})

$Btn_SystemInfo.Add_Click({
    try {
        $System = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $($Input1.Text) | select Name,Description,Domain,Manufacturer,Model,SystemType,Username
        $Enclosure = Get-WmiObject -Class Win32_SystemEnclosure -ComputerName $($Input1.Text) | Select-Object SerialNumber
        $OS = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $($Input1.Text) | Select-Object Caption,OSArchitecture,Description,SerialNumber,@{n='Memory';e={$_.TotalVirtualMemorySize/1GB -as [int]}}
        $Processor = Get-WmiObject -Class Win32_Processor -ComputerName $($Input1.Text) | Select-Object Name
        $Memory = Get-WMIObject -class Win32_PhysicalMemory -ComputerName $($Input1.Text) | Measure-Object -Property capacity -Sum | select @{N="Total"; E={[math]::round(($_.Sum / 1GB),2)}}

        $obj = New-Object -Type PSObject -Property @{
            "Computername"=$System.Name
            "Manufacturer"=$System.Manufacturer
            "Model"=$System.Model
            "OS"=$OS.Caption
            "OSArchitecture"=$OS.OSArchitecture
            "SerialNumber"=$Enclosure.SerialNumber
            "Processor" = $Processor.Name
            "Memory" = $Memory.Total
        } | Select Computername,Manufacturer,Model,OS,OSArchitecture,SerialNumber,Processor,Memory | Out-String

        $Output1.AppendText($nl)
        $Output1.Text += "System info for $($Input1.Text)`n"
        $Output1.Text += "----------------------------------`n"
        $Output1.Text += $obj.Trim()
    }
    catch {
        $Output1.AppendText($nl)
        $Output1.Text += "Function [System Info] Failed"
    }  
})

#endregion

#region Helper Functions

function PingTest ($Computer){
    $Ping = New-Object System.Net.NetworkInformation.Ping
    try {
        $Ping.Send($Computer)
        $true
    }
    catch {
        $false
    }
}

#endregion

$UserInterFace.ShowDialog() | Out-Null