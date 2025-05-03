function Copy-DataTableToSQL {
    <#
 .EXAMPLE
 Copy-DataTableToSQL -SQLServer fitchmsql01 -SQLDB dev -Target dbo.test_adcomputer -Source $DataTable
 .PARAMETER Source
 A DataTable that will be merged witht eh target tabled.
 .PARAMETER SQLServer
 Named instances SERVERNAME\INSTANCENAME | If it's a default instance only use server name, do not add \MSSQLSERVER.
 .PARAMETER SQLDB
 Name of the database where the target table is.
 .PARAMETER Target
 The Table in which you're targeting
 .PARAMETER Filter
 Default="*" Used in selecting the columns from the target.
 .PARAMETER Security
 Default="SSPI" Used in connection string to SQL DB.
 .PARAMETER Timeout
 Default="60" Used in connection string.
#>
    param(
        [Parameter(Mandatory = $true)][string]$SQLServer,
        [Parameter(Mandatory = $true)][string]$SQLDB,
        [Parameter(Mandatory = $true)][string]$Target,
        [Parameter(Mandatory = $true)][System.Data.DataTable]$Source,
        [String]$Filter = "*",
        [String]$Security = "SSPI",
        [Int]$Timeout = "60",
        [Int]$Batch = "5000"
    )
    begin {
        #Create connection object to SQL instance if one isnt already open
        if ($SQLConnection.State -ne [Data.ConnectionState]::Open) {
            $SQLConnection = New-Object System.Data.SqlClient.SqlConnection
            $SQLConnection.ConnectionString = "Server=$SQLServer;Database=$SQLDB;Integrated Security=$Security;Connection Timeout=$Timeout"
            $SQLConnection.Open()
        }
    }
    Process {
        if ($SQLConnection.State -ne [Data.ConnectionState]::Open) { throw "Connection to SQL DB not open" }
        else {
            $SQLBulkCopy = New-Object ("System.Data.SqlClient.SqlBulkCopy") $SQLConnection
            $SQLBulkCopy.DestinationTableName = $Target
            $SQLBulkCopy.BatchSize = $Batch
            $SQLBulkCopy.BulkCopyTimeout = $Timeout #Previously set to 0
            foreach ($Column in $Source.columns.columnname) { [void]$SQLBulkCopy.ColumnMappings.Add($Column, $Column) }
            $SQLBulkCopy.WriteToServer($Source)
        }
    }
    end {
        if ($SQLConnection.State -eq [Data.ConnectionState]::Open) { $SQLConnection.Close() }
    }
}