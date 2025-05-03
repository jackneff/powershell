$ports = @(80, 443)
$list = Import-Csv .\web_servers.csv | foreach-object { $_.hostname.trim() }
$ErrorActionPreference = "silentlycontinue"
$results = @()
Foreach ($hostname in $list) {
    If (Test-Connection -BufferSize 32 -Count 1 -ComputerName $hostname) {
        foreach ($port in $ports) {
            $socket = new-object System.Net.Sockets.TcpClient($hostname, $port)
            if ($socket.Connected) {
                $open = $true
                $socket.Close() 
            }
            else { 
                $open = $false
            }
            $results += [pscustomobject] @{
                "Hostname" = $hostname 
                "Port"     = $port 
                "Open"     = $open 
            }
        }
    }
}

Write-Output $results | Export-csv "portscan_results_443.csv"