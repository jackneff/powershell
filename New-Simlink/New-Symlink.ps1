function New-SymLink {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Link,
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$Target,
        [Parameter(Mandatory = $true, Position = 2)]
        [ValidateSet('Hardlink', 'SymbolicLink')]
        [string]$Type
    )

    begin {
        $Type = if ($null -eq $Type) { 'SymbolicLink' } 
    }
        
    process {
        New-Item -Path $Link -ItemType $Type -Value $Target
    }
    
}


Import-Module ".\New-SymbolicLink.ps1"

# Map your symbolic links
# "from" = "to"
$Links = @{
    "c:\temp\a" = "x:\temp\a"
    "c:\temp\b" = "x:\temp\b"
    "c:\temp\c" = "x:\temp\c"
}

$Links.Keys | ForEach-Object { 
    $From = $_
    $To = $Links[$_]
    New-SymLink -Link $From $To -Type SymbolicLink
}
