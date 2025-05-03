function Get-Clipboard{
    Add-Type -Assembly PresentationCore
    $text = [Windows.Clipboard]::GetText()
    $lines = $text.Split("`n").Trim()
    Write-Output $lines
}