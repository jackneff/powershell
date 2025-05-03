<# 
   .Synopsis 
    Perform an baseline security scan using mbsacli.exe and output reports to text file. 
   .Description 
    This script will run against an inputed set of hosts to determine outstanding security patches. 
    The pre-requisite for this script to run is to install Microsoft Baseline Security Analyzer 2. 
   .Example 
    
    .\Get-MBSAStats.ps1 
    
   .Example 
    Use the -h parameter to input the host file list, plus output to a specific report directory using -r 
    
    .\Get-MBSAStats.ps1 -h C:\PS\MBSA\epic_servers.txt -r "C:\PS\MBSA\Reports" 
    
   .Example 
    The following will provide the full report rather than a summary report 
    This report you will see the default mbsacli report with all extra information. 
    
    .\Get-MBSAStats.ps1 -d 
    
   .Example 
    The following will provide the overview report rather than a detailed report 
    With this report the number of required updates will be shown, not the actual list of updates 
     
    .\Get-MBSAStats.ps1 -s 
    
   .Inputs 
    The file with the list of hosts to be scanned 
   .OutPuts 
    One text file for each computer with the following format "MBSA_Summary_%Y%m%d_%I-%M_$ServerName.txt" 
    Output filename format is MBSA_Summary_20100618_11-30_BLBWHCCPVM001.txt 
   .Notes 
    NAME: Get-MBSAStats.ps1 
    AUTHOR: Benjamin R Wilkinson 
    HANDCODED: Using Windows PowerShell ISE. 
    VERSION: 1.0.0 
    LASTEDIT: 06/18/2010 
    KEYWORDS: MBSA, MBACLI, Microsoft Baseline Security Analyzer 2 
   .Link 
    MBSA v 2.1 download http://bit.ly/af89VW 
#> 
#Requires -Version 2.0 
[CmdletBinding()] 
 Param  
   ( 
    [Parameter(Mandatory=$true, 
               ValueFromPipeline=$true, 
               ValueFromPipelineByPropertyName=$true)] 
    [Alias("computers")] 
    [String] 
    $Hosts, 
    [Alias("r")] 
    [String] 
    $ReportDir = "C:\PS\MBSA\Reports\NewReports", 
    [Alias("d")] 
    [Switch]$DetailedReport, 
    [Alias("s")] 
    [Switch]$SummaryInfo 
   )#End Param 
Begin 
{ 
 Write-Host "Retrieving Computer Security Info . . ." 
} 
Process 
{       
# Check that the prerequisite MBSA v2 is installed. 
if ((Test-Path "C:\Program Files\Microsoft Baseline Security Analyzer 2") -or (test-path "C:\Program Files(x86)\Microsoft Baseline Security Analyzer 2")){     
    # Get the List of Hosts to scan 
    $Report = $Null 
     
     
 
    # Run the report with options. 
    $cmd = "mbsacli /target ""$Hosts"" /n OS+SQL+IIS+Password"
    $ReportDetails = Invoke-Expression $cmd 
     
    # Extract the name of the report from the text output from mbsacli 
    if ($ReportDetails[4] -ne $Null) 
        { 
         for ($i = 4;$i -lt $ReportDetails.length; $i++) 
            {          
             write-host $i 
             $Report = ($ReportDetails[$i].Split(",")[3]).Substring(1) 
             write-host "report name is " $Report
             if ($SummaryInfo) 
                { 
                 # Extract detailed report to Object 
                 $cmd2 = “cmd /c mbsacli /lr ""$Report""" 
                 $FullReport = Invoke-Expression $cmd2 
                } 
             else 
                { 
                 # Extract overview report to Object 
                 $cmd2 = “cmd /c mbsacli /ld ""$Report""" 
                 $FullReport = Invoke-Expression $cmd2 
                } 
             # Scan the results for missing updates 
             $SummaryReport = $FullReport | Where-Object {($_ -match “Missing”) ` 
                -or ($_ -match "Computer name:") -or ($_ -match "Issue:") -or ($_ -match "Not Approved")} 
 
             if ($DetailedReport) 
                { 
                 # Report the full results 
                 $FullReportName = get-date -uformat "MBSA_Full_%Y%m%d_%I-%M_$ServerName.txt" 
                 $FullReportName = (Join-Path -path $ReportDir -childpath $FullReportName) 
                 $FullReport | Out-File $FullReportName 
                 Write-Host "Report (full) written to"$FullReportName 
                } 
             else 
                { 
                 # Report the summary results 
                 $ServerName = ($FullReport | Where-Object {$_ -match "Computer name:"}).Split("\")[1] 
                 $SummaryReportName = get-date -uformat "MBSA_Summary_%Y%m%d_%I-%M_$ServerName.txt" 
                 $SummaryReportName = (Join-Path -path $ReportDir -childpath $SummaryReportName) 
                 $SummaryReport | Tee-Object $SummaryReportName 
                  
                 # To open the reports uncomment the line below 
                 #Invoke-Item $SummaryReportName 
                 Write-Host "" 
                 Write-Host "Report (summary) written to"$SummaryReportName 
                } 
            } 
        } 
    else 
        { 
          Write-Host "There are no valid hosts, now exiting" 
        } 
   } 
else 
   { 
    Write-Host "Please install the MBSA prior to running this script" 
   } 
} 
End 
{ 
     
}