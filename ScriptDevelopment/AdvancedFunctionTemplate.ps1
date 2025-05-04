function MyAdvFunction {
    <#
    Add some comment based help for the function here.
    .SYNOPSIS
    This advanced function does...
    #>
    [CmdletBinding()]
    param (

        [Parameter(Mandatory = $True, Position = 0)]
        [string]$Computername,

        [Parameter(Mandatory = $False, Position = 1)]
        [ValidateSet('High', 'Medium', 'Low')]
        [string]$Level,

        [string]$DemoParam31,

        [string]$DemoParam4, $DemoParam5

    )

    begin {}

    process {}

    end {}

}