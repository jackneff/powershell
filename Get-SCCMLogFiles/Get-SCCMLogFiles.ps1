Function Pause($M="Press any key to continue . . . "){If($psISE){$S=New-Object -ComObject "WScript.Shell";$B=$S.Popup("Click OK to continue.",0,"Script Paused",0);Return};Write-Host -NoNewline $M;$I=16,17,18,20,91,92,93,144,145,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183;While($K.VirtualKeyCode -Eq $Null -Or $I -Contains $K.VirtualKeyCode){$K=$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")};Write-Host}

function test-port {

  Param(

  [string]$ComputerName,

  [int]$port = 445 # new 'remoting' port

  )

  $ErrorActionPreference = “SilentlyContinue”

  $socket = new-object Net.Sockets.TcpClient

  $socket.Connect($ComputerName, $port)

  if ($socket.Connected) {

    write-output $true

    $socket.Close()

  }

  else {

   write-output $false

  }

  $socket = $null

}


#----------------------------------------------------------
#STATIC VARIABLES
#----------------------------------------------------------
$SCRIPT_PARENT   = Split-Path -Parent $MyInvocation.MyCommand.Definition

function Get-SCCMLogFiles {
    Write-Host "[INFO] Get the list of computers from the input file and store it in an array."
    $arrComputer = Get-Content ($SCRIPT_PARENT + "\input.txt")
    Foreach ($strComputer In $arrComputer)
    {

        Write-Host "" -foregroundcolor "Yellow"

        $ips = @()
        $systemIP = ""

        Write-Host "`t[INFO] Trying system : $strComputer"
        try{
            $ips = @([System.Net.Dns]::GetHostAddresses($strComputer).IPAddressToString)
            foreach ($ip in $ips){
               if ($ip -like "140.139.*")
               {
                    Write-Host "`t`t[INFO] Found System IP : $ip"
                    $systemIP = $ip
               }
            }            
        } catch {
            Write-Host "`t`t[FAIL] Can't find host: $strComputer" -foregroundcolor "RED"

        }

        if ($systemIP -ne ""){
            Write-Host "`t`t[INFO] Test-Connection to $strComputer"
            if(Test-Connection -Cn $systemIP -BufferSize 16 -Count 1 -ea 0 -quiet)
            {
                #remote powershell invoke command on client to verify port connectivity is open

                if (!(test-port $systemIP -port 445))
                {
            Write-Host "`t`t`t[FAIL] Port 445 Closed" -foregroundcolor "RED"
                }
                else
                {
            Write-Host "`t`t`t[INFO] Port 445 open"
            
            
                    #
                    # Check for CCM Install Log Files
                    #
            Write-Host "`t`t`t`t[INFO] Test-Path to \\$strComputer\c$\windows\ccmsetup\."
            
                    if ( Test-path "\\$systemIP\c$\windows\ccmsetup\")
                    {
            
                Write-Host "`t`t`t`t`t[INFO] Does $SCRIPT_PARENT\$strComputer\ exist"
            
                        if (!(Test-path "$SCRIPT_PARENT\$strComputer\"))
                        {
            
                Write-Host "`t`t`t`t`t`t[INFO] Creating $SCRIPT_PARENT\$strComputer\"
            
                            New-Item ("$SCRIPT_PARENT\$strComputer") -type directory | Out-Null
                            New-Item ("$SCRIPT_PARENT\$strComputer\logs") -type directory | Out-Null
                        }
                Write-Host "`t`t`t`t`t`t`t[INFO] Copying files \\$systemIP\c$\windows\ccmsetup\"
                    
                        Copy-Item "\\$systemIP\c$\windows\ccmsetup\*.log" ("$SCRIPT_PARENT\$strComputer\")
                     
                    }

                    #
                    # Check for CCM Log Files
                    #
                    Write-Host "            [INFO] Test-Path to \\$strComputer\c$\windows\syswow64\ccm\logs"
            
                    if ( Test-path "\\$systemIP\c$\windows\syswow64\ccm\logs")
                    {
            
                Write-Host "                    [INFO] Does $SCRIPT_PARENT\$strComputer\logs exist"
            
                        if (!(Test-path "$SCRIPT_PARENT\$strComputer\logs"))
                        {
            
                Write-Host "                    [INFO] Creating $SCRIPT_PARENT\$strComputer\logs"
            
                            New-Item ("$SCRIPT_PARENT\$strComputer\logs") -type directory | Out-Null
                        }
                Write-Host "                    [INFO] Copying files \\$strComputer\c$\windows\syswow64\ccm\logs"
                    
                        Copy-Item "\\$strComputer\c$\windows\syswow64\ccm\logs\*.log" ("$SCRIPT_PARENT\$strComputer\logs\")
                     
                    }

                }

           
            } else
            {
            Write-Host "        [INFO] Test-Connection to $strComputer failed" -foregroundcolor "RED"
            }
        }
        
    }

}

Get-SCCMLogFiles

pause