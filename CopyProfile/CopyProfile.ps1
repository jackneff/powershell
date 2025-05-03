#Profile Backup

$FileSizeThreshold = 100MB

Write-Host "Analyzing profile..."
$colItems = (Get-ChildItem $env:USERPROFILE -Recurse | Measure-Object -Property length -Sum)
[float]$ProfileSize = "{0:N2}" -f ($colItems.Sum / 1MB)
if ($ProfileSize -lt 5120) {
    Write-Host "Profile size: $ProfileSize" -ForegroundColor Yellow
}
else {
    Write-Host "WARNING LARGE PROFILE ($($ProfileSize/1GB) GB)" -ForegroundColor Yellow
    "Checking for large files..."
    $LargeFiles = Get-ChildItem -Path $env:USERPROFILE -Recurse | where { $_.Length -gt $FileSizeThreshold }
    if ($LargeFiles) {
        $LargeFiles
        $Option = Read-Host "Want to delete these files now? (Y or N)"
        if ($Option -eq 'Y') { 
            $LargeFiles | ForEach-Object { Remove-Item -Path $_.FullName } 
        }
    }
    else {
        Write-Host "No files found over $FileSizeThreshold"
    }
}

$Date = Get-Date -Format "yyyyMMddHHmm"
$BackupFolderName = "WinProf_$($env:USERNAME)_$Date"
$Destination = Read-Host "Backup destination path"
$FullDestPath = "$Destination\$BackupFolderName"

try {
    New-Item -Path $FullDestPath -ItemType Directory -ErrorAction Stop | Out-Null
}
catch {
    Write-Error -Message "Failed to create destination folder"
    Break
}

Write-Host "`nAbout to copy $env:USERNAME profile to $FullPath (CTRL + C to Cancel)" -ForegroundColor Yellow
Pause

$SubFolders = "Favorites", "Documents", "Downloads", "Music", "Pictures"

foreach ($Folder in $SubFolders) {
    Copy-Item -Path "$env:USERPROFILE\$Folder" -Destination $FullDestPath -Force
}

New-Item -Path "$FullDestPath\Outlook" -ItemType Directory
Copy-Item -Path "$env:APPDATA\Microsoft\Outlook\*.nk2" -Destination "$FullDestPath\Outlook"
Copy-Item -Path "$env:LOCALAPPDATA\Microsoft\Outlook\*.pst" -Destination "$FullDestPath\Outlook"
Copy-Item -Path "$env:APPDATA\Microsoft\Signatures" -Destination $FullDestPath -Force