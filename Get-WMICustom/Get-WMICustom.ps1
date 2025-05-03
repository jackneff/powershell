Function Get-WmiCustom([string]$computername,[string]$namespace,[string]$class,[int]$timeout=15) 
{ 
    $ConnectionOptions = new-object System.Management.ConnectionOptions 
    $EnumerationOptions = new-object System.Management.EnumerationOptions

    $timeoutseconds = new-timespan -seconds $timeout 
    $EnumerationOptions.set_timeout($timeoutseconds)

    $assembledpath = "\\" + $computername + "\" + $namespace 
    #write-host $assembledpath -foregroundcolor yellow

    $Scope = new-object System.Management.ManagementScope $assembledpath, $ConnectionOptions 
    $Scope.Connect()

    $querystring = "SELECT * FROM " + $class 
    #write-host $querystring

    $query = new-object System.Management.ObjectQuery $querystring 
    $searcher = new-object System.Management.ManagementObjectSearcher 
    $searcher.set_options($EnumerationOptions) 
    $searcher.Query = $querystring 
    $searcher.Scope = $Scope

    trap { $_ } $result = $searcher.get()

    return $result 
}