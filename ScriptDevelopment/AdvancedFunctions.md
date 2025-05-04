# Advanced Functions

```powershell
function MyAdvFunction {
    <#
    Add some comment based help for the function here.
    .SYNOPSIS
    This advanced function does...
    #>
    [CmdletBinding()]
    param (

        [Parameter(Mandatory=$True, Position=0)]
        [string]$Computername,

        [Parameter(Mandatory=$False, Position=1)]
        [ValidateSet('High','Medium','Low')]
        [string]$Level,

        [string]$DemoParam31,

        [string]$DemoParam4, $DemoParam5

    )

    begin {}

    process {}

    end {}

}

```

## Attributes

```powershell

Several (optional) attributes can be added to the Param clause of an advanced function.
The Param keyword is used to define parameters in both simple and advanced functions,
The Parameter attribute in advanced functions is to validate (limit the valid values of each parameter).

[parameter(Argument=value)] # Define attributes for each parameter, see below for a list of Parameter Arguments.
[alias("CN","MachineName")] # Establish an alternate name(s) for the parameter.
[AllowNull()]
[AllowEmptyString()]
[AllowEmptyCollection()]
[ValidateCount(1,5)] # The number or parameters accepted.
[ValidateLength(1,10)] # minimum and max. number of characters in a parameter or variable value.
[ValidatePattern("[0-9][0-9][0-9][0-9]")] # specifies a regex that is compared to the parameter or variable value.
[ValidateRange(0,10)] # specifies a numeric range for each parameter or variable value.
[ValidateScript({$_ -ge (Get-Date)})] # specifies a script that is used to validate a parameter or variable value. [ValidateSet("Low", "Average", "High")] # specifies a set of valid values for a parameter or variable.
[ValidateNotNull()] # specifies that the parameter value cannot be null ($null).
[ValidateNotNullOrEmpty()] # specifies that the parameter value cannot be null and cannot be an empty string ("")
DynamicParam {<statement-list>} # A dynamic parameter.
[Switch]<ParameterName> # Set a parameter with only a True/False value.

```

## Parameters

```powershell

These can be included in each [Parameter( )] attribute. The Parameter attribute is optional, and you can omit it if none of the parameters of your advanced function need attributes. Separate multiple arguments with commas.

Mandatory=$true # Whether the parameter is mandatory or optional (the default) If you call a function without passing a value for a mandatory parameter, PowerShell will prompt for the value.
Position=0 # By default, PowerShell assigns each parameter a position number in the order declared, starting from 0.
ParameterSetName="User" # allow a function to accept different sets of parameters for different tasks.
ValueFromPipeline=$true # Accept values via the pipeline.
ValueFromPipelineByPropertyName=$true # Accept values via the pipeline of the same type expected by the parameter and which also must have the same name as the parameter accepting pipeline input.
ValueFromRemainingArguments=$true
HelpMessage="Custom prompt message that appears for a mandatory parameter."

```
