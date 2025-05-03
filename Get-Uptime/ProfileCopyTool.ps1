#Profile Copy Tool

function MainMenu {
    
    Clear-Host
    Write-Host "MAIN MENU:"
    Write-Host "##########################"
    Write-Host "1. Copy my profile"
    Write-Host "2. Copy another profile"
    Write-Host "3. Quit"
    Write-Host "##########################"
    Write-Host "`n"

    #Validate user input
    do {
        $valid = $false
        [int]$Option = Read-Host "Enter a number"
        if (($Option -gt 0) -and ($Option -lt 4)){
            $valid = $true
        } else {
            Write-Host "Invalid choice!`n" -ForegroundColor Red
        }
    } while (-not($valid))

    #Process request
    if ($Option -eq 1){
        CopyMyProfile
    } elseif ($Option -eq 2){
        CopyOtherProfile
    } else {
        Break
    }

}

function CopyMyProfile {

    Clear-Host
    Write-Host "Select a Destination:"
    Write-Host "##########################"
    Write-Host "1. Home Drive (H:)"
    Write-Host "2. VDI Migration"
    Write-Host "3. Custom Path"
    Write-Host "4. Return to Main Menu"
    Write-Host "5. Quit"
    Write-Host "##########################"
    Write-Host "`n`n"

    #Validate user input
    do {
        $valid = $false
        [int]$Option = Read-Host "Enter a number"
        if (($Option -gt 0) -and ($Option -lt 6)){
            $valid = $true
        } else {
            Write-Host "Invalid choice!`n" -ForegroundColor Red
        }
    } while (-not($valid))

    #Process request
    switch ($Option){
        1 { $Destination = "H:\ProfileBackup" }
        2 { ValidateUserVDIProfilePath }
        3 { GetCustomPathFromUser }
        4 { MainMenu }
        5 { Break }
    }

}

function CopyOtherProfile {

    $testPath = $false

    Clear-Host
    Write-Host "Select a host:"
    Write-Host "##########################"
    Write-Host "1. This computer"
    Write-Host "2. A remote computer"
    Write-Host "3. Return to Main Menu"
    Write-Host "4. Quit"
    Write-Host "##########################"
    Write-Host "`n`n"
    
    #Validate user input
    do {
        $valid = $false
        [int]$Option = Read-Host "Enter a number"
        if (($Option -gt 0) -and ($Option -lt 5)){
            $valid = $true
        } else {
            Write-Host "Invalid choice!`n" -ForegroundColor Red
        }
    } while (-not($valid))

    #Process request
    switch ($Option){
        1 { $Computername = $env:COMPUTERNAME }
        2 { GetRemoteComputerName }
        3 { MainMenu }
        4 { Break }
    }

}

function ValidateUserVDIProfilePath {

}

function GetCustomPathFromUser {

    $CustomPath = Read-Host "Enter path"
    if (-not(Test-Path -Path $CustomPath)){
        $Option = Read-Host "Path doesn't exist would you like to create it? (Y or N)"
        if ($Option -eq 'Y'){

        } elseif ($Option -eq 'N'){
            GetCustomPathFromUser
        } else {
            Write-Host "Invalid Choice!"
            Pause
            GetCustomPathFromUser
        }
    } 
}

function GetRemoteComputerName {

}