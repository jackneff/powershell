$ExportPath = "$PSScriptRoot\ScheduledTasksReport.csv"
$Computers = Get-Content -Path "$PSSCriptRoot\server_list.txt"

foreach ( $C in $Computers ) {

    $Tasks = Get-ScheduledTask -CimSession $C | Where-Object { $_.Author -match "thurston" }

    foreach ( $Task in $Tasks ) {

        $ComputerName = $Task.PSComputerName
        $TaskName = $Task.TaskName
        $Action = $Task.Actions | Select-Object -ExpandProperty Execute
        $Fargs = $Task.Actions | Select-Object -ExpandProperty Arguments
        $Start = $Task.Triggers | Select-Object -ExpandProperty StartBoundary
        $Repetition = $Task.Triggers.Repetition | Select-Object -ExpandProperty Interval
        $Duration = $Task.Triggers.Repetition | Select-Object -ExpandProperty Duration
        $Author = $Task.Author
    
        $Obj = [pscustomobject] @{
            'ComputerName' = $ComputerName
            'TaskName'     = $TaskName
            'Action'       = $Action
            'Args'         = $Fargs
            'Start'        = $Start
            'Repetition'   = $Repetition
            'Duration'     = $Duration
            'Author'       = $Author
        }

        $Obj | Export-Csv -Path $ExportPath -NoTypeInformation -Append

    }

}