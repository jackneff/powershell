# wrapper alias for enter-pssession shortening command to 'rs'
# example> rs hostname

function RemoteShell {
    param($ComputerName)
    Enter-PSSession -ComputerName $ComputerName
}

Set-Alias -Name rs -Value RemoteShell
Set-Alias -Name pss -Value RemoteShell #pssession