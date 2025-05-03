function Get-FileProperties {

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True,
        ValueFromPipelineByPropertyName=$True,
            HelpMessage='What computer name would you like to target?')]
        [Alias('c')]
        [ValidateLength(3,30)]
        [string[]]$Computers,

        [Parameter(Mandatory=$true,HelpMessage='Path to file')]
        [Alias('p')]
        [string]$Path
    )

    begin {}

    process {

        foreach ($Computer in $Computers){
            
            $Scriptblock = $ExecutionContext.InvokeCommand.NewScriptBlock("Get-ItemProperty -Path $Path")
            $File = $null
            $File = Invoke-Command -ComputerName $Computer -ScriptBlock $Scriptblock

            if ($File){
                $Properties = [ordered]@{
                    Computername = $Computer
                    Path = $Path
                    Name = $File.Name
                    Description = $File.VersionInfo.Description
                    Version = $File.VersionInfo.ProductVersion
                    LastWriteTime = $File.LastWriteTime
                }
            } 
        }

        $obj = New-Object PSObject -Property $item
        Write-Output $obj
    }

    end {}
}