#AUTOBOT SCRIPT
#Author:  Jack Neff
#Description:  Performs specific tasks by emailing a list of items.  Quick, easy and can be used with mobile devices.

#Variables
################################################################################################################
Add-type -AssemblyName "Microsoft.Office.Interop.Outlook" | Out-Null
$ol = New-Object -ComObject "Outlook.Application"
$mapi = $ol.getnamespace("mapi")
$RequestFolder = $mapi.Folders.Item("lazyadmin@work.com").folders.Item("Autobot").folders.item("New").Items
$ProccessedFolder = $mapi.Folders.Item("lazyadmin@work.com").folders.Item("Autobot").folders.item("Proccessed")
$SMTP = 'smtp.mail.com'
$From = 'noreply@work.com'
$AuthorizedUsers = Get-Content "$PSScriptRoot\userlist.txt"
$ValidTasks = Get-Content "$PSScriptRoot\tasklist.txt"
################################################################################################################



#Import worker functions
."$PSScriptRoot\workerfunctions.ps1" 


do {

    foreach ($Request in $RequestFolder) {

        #Get senders email address
        if ($Request.SenderEmailAddress -match '@'){
            #Sent from an outside address, very easy
            $Sender = $Request.SenderEmailAddress
        } else {
            #Sent from inside the exchange, super complicated
            $StringA = $Request.SenderEmailAddress
            $StringB = (($StringA -split "\/" | select -Index 4) -replace "CN=","")
            $Sender = ($StringB.substring(0,$StringB.Length - 3)).tolower() + "@work.com"
        }
        
        #Check if requestor is authorized to use autobot
        if ($AuthorizedUsers -contains $Sender){             
            
            $TaskRequest = ($Request.Subject -replace "@@","").Trim()
            if ($ValidTasks -contains $TaskRequest){

                #Retrieve line items from body of email
                $LineItems = $Request.Body -split '[\r\n]' | Where-Object { $_.length -gt 1 }

                #Perform task on each line item and collect results
                switch ($TaskRequest) {
                    'menu' { $EmailBody = Get-Menu }
                    'tasks' { $EmailBody = Get-Menu }
                    'list tasks' { $EmailBody = Get-Menu }
                    'hello' { $EmailBody = SayHello }
                    'ping' { $EmailBody = Get-PingStatus $LineItems }
                    'logged on user' { $EmailBody = Get-LoggedOnUser $LineItems }
                    'search user' { $EmailBody = Search-User $LineItems }
                    'search computer' { $EmailBody = Search-Computer $LineItems }
                    'get user computername' { $EmailBody = Get-UserComputerName $LineItems }
                    'add printer group' {}
                    'remove printer group' { $EmailBody = Remove-PrinterGroup $LineItems }
                    'system info' { $EmailBody = Get-SystemInfo $LineItems }
                    'unlock account' { $EmailBody = Unlock-Account $LineItems }
                    'force gpupdate' { $EmailBody = Force-GPUdpate $LineItems }
                    'force restart' { $EmailBody = Force-Restart $LineItems }
                }

                #Email the requestor that their task is completed with results
                $Subject = "Request completed"

            } else {
            #Email requestor saying request is invalid
            $Subject = "Invalid request"
            $EmailBody = "Task `'$TaskRequest`' is an invalid request"
        }

        } else {
            #Email requestor they are not authorized to use autobot
            $Subject = "Not authorized"
            $EmailBody = "You are not auhorized to use autobot, sorry."
        }

        #Send the email
        Send-MailMessage -SmtpServer $SMTP -From $From -To $Sender -Subject $Subject -Body $EmailBody

        #Move the request email to the "processed" folder
        $Request.Move($ProccessedFolder) | Out-Null
    }


} while ($RequestFolder.Count -gt 0)

