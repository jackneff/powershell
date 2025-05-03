function Invoke-SCCMActions {
  <#
  .SYNOPSIS
  Repairs sccm client
  .DESCRIPTION
  Repairs sccm client
  .EXAMPLE
  Get-Content somelist.txt | SCCM-Repair
  .PARAMETER computername
  The computer name to query. Just one.
  #>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True,
        ValueFromPipelineByPropertyName=$True,
            HelpMessage='What computer name would you like to target?')]
        [Alias('host')]
        [ValidateLength(3,30)]
        [string[]]$computername
    )

    begin {}

    process {

        write-verbose "Beginning process loop"

        foreach ($computer in $computername) {
            Write-Verbose "Processing $computer"
      
            if (Test-Connection $computer -Count 1 -Quiet){
                Write-Host "$computer is online, triggering actions:"

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000001}') | Out-Null
                    Write-Host "   HW Inventory Scan - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   HW Inventory Scan - Failed" -ForegroundColor Red
                }

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000002}') | Out-Null
                    Write-Host "   SW Inventory Scan - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   SW Inventory Scan - Failed" -ForegroundColor Red
                }

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000003}') | Out-Null
                    Write-Host "   Discover Data Record - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   Discovery Data Record - Failed" -ForegroundColor Red
                }

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000021}') | Out-Null
                    Write-Host "   Machine Policy Retrieval & Evaluation - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   Machine Policy Retrieval & Evaluation - Failed" -ForegroundColor Red
                }

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000010}') | Out-Null
                    Write-Host "   File Collection - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   File Collection - Failed" -ForegroundColor Red
                }

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000022}') | Out-Null
                    Write-Host "   SW Metering and Usage Report - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   SW Metering and Usage Report - Failed" -ForegroundColor Red
                }

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000113}') | Out-Null
                    Write-Host "   SW Updates Scan - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   SW Updates Scan - Failed" -ForegroundColor Red
                }

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000114}') | Out-Null
                    Write-Host "   SW Updates Store - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   SW Updates Store - Failed" -ForegroundColor Red
                }

                try {
                    ([wmiclass]"\\$computer\root\ccm:sms_client").TriggerSchedule('{00000000-0000-0000-0000-000000000108}') | Out-Null
                    Write-Host "   SW Updates Deployment - Success" -ForegroundColor Green
                } 
                catch {
                    Write-Host "   SW Updates Deployment - Failed" -ForegroundColor Red
                }

                
            } else {

                Write-Verbose "$computer is offline"
            }
        }
    }

    end {}
}