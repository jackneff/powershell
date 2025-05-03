#------------------------------------------------------------------
# Produces report for McAfee AntiVirus on a set of remote computers
# Usage: get-content <list of servers.txt> | .\GetMcAfeeInfo.ps1
#        Optionally pipe output to Export-Csv, ConverTo-Html
#------------------------------------------------------------------

Begin {
	# Pings $cn and if successful, pass $cn to output, otherwise, $null
	function SelectAlive ( $cn ) {
		$ping = New-Object System.Net.NetworkInformation.Ping # faster than ping, not to mention easier to parse
		$reply = $null
		$cn = $cn.trim() # removes any extraneous whitespace
		$reply = $ping.Send($cn)
		if ($reply.status -eq "Success") {
			Write-Output $cn
		} else {
			Write-Warning "$cn : not pingable"
		}
	}

	# Attempts to query registry for $cn and if successful, pass $cn to output, otherwise, $null
	function SelectRemoteRegistryAccess ( $cn ) {
		$ErrorActionPreference = "SilentlyContinue" # squelch errors
		$root = "LocalMachine"
		if ( [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey( $root, $cn ) ) {
			Write-Output $cn
		} else {
			Write-Warning "$cn : remote registry access not accessible"
		}
	}
	
	function GetHKLMRegValue ( $cn, $key, $value ) {
		$ErrorActionPreference = "SilentlyContinue" # squelch errors
		$root = "LocalMachine"
		$rootkey = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey( $root, $cn )
		$key = $rootkey.OpenSubKey( $key )
		$key.GetValue( $value )
	}
	
	# McAfee registry paths
	$sKeyPath85 = "SOFTWARE\McAfee\DesktopProtection"
	$sKeyPath85e = "SOFTWARE\McAfee\AVEngine"
	$sKeyPath80 = "SOFTWARE\Network Associates\TVD\VirusScan Enterprise\CurrentVersion"
	$sProductVer = "szProductVer"
	$sEngineVer80 = "szEngineVer"
	$sEngineVer85 = "EngineVersionMajor"
	$sVirDefVer80 = "szVirDefVer"
	$sVirDefVer85 = "AVDatVersion"

}
Process {
	# If the computer isn't pingable, move on to next in pipeline.
	if ( -not ( SelectAlive $_ ) ) { continue }
	
	# Can we access the remote registry? If not, then the service is stopped or firewall enabled, or its a Linux box :)
	if ( -not ( SelectRemoteRegistryAccess $_ ) ) { continue }
	
	# create custom object with properties for each datum
	# technique described here: http://bsonposh.com/archives/221
	$Output = "" | Select-Object Server, ProductVersion, EngineVersion, DatVersion
	
	if ( GetHKLMRegValue -cn $_ -key $sKeyPath85 -value $sProductVer ) {
		$output.Server = $_
		$output.ProductVersion = GetHKLMRegValue -cn $_ -key $sKeyPath85 -value $sProductVer
		$output.EngineVersion = GetHKLMRegValue -cn $_ -key $sKeyPath85 -value $sEngineVerValue
		$output.DatVersion = GetHKLMRegValue -cn $_ -key $sKeyPath85 -value $sVirDefVer85
	} else {
		# do 8.0
	}
	$output
}