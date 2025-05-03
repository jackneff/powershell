#Printer mapper

$host.ui.RawUI.WindowTitle = "Printer Mapper"
$host.UI.RawUI.BackgroundColor = 'DarkBlue'
$host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

$Printers = iex "net view \\printserver"

$SearchString = Read-Host "`nEnter printer property tag"

$Results = $Printers | where { $_ -match $SearchString }

if ($Printers) {
    $arr = $Results.split(" ")
    $PrinterName = $arr[0]
    Write-Host "Printer $PrinterName found, mapping now..."
    $obj = New-Object -ComObject Shell.Application
    $obj.Open("\\printserver\$PrinterName")
    Write-Host "Done"
}
else {
    Write-Host "Printer not found"
}



