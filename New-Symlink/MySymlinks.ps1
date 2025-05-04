
Import-Module ".\New-SymbolicLink.ps1"

# Map your symbolic links
# "from" = "to"
$Links = @{
    "c:\temp\a" = "x:\temp\a"
    "c:\temp\b" = "x:\temp\b"
    "c:\temp\c" = "x:\temp\c"
}

$Links.Keys | ForEach-Object { 
    $Link = $_
    $Target = $Links[$_]
    New-SymLink -Link $Link -Target $Target -Type SymbolicLink
}