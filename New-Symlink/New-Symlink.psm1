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
