Import-Module SqlServer

# Connect to the SQL database
$server = New-Object Microsoft.SqlServer.Management.Smo.Server('')
$database = $server.Databases['']

# Get all of the tables in the database
$tables = $database.Tables

# Create a new empty collection to store the relationship objects
$relationships = @()

# For each table, get all of the foreign key relationships
foreach ($table in $tables) {
    
    $foreignKeys = $table.ForeignKeys

    # For each foreign key, get the related table
    foreach ($foreignKey in $foreignKeys) {
        
        $relatedTable = $foreignKey.ReferencedTable

        # Create a new object to represent the relationship between the two tables
        $relationship = New-Object PSObject
        $relationship.Table1 = $table.Name
        $relationship.Table2 = $relatedTable.Name
        $relationship.RelationshipType = $foreignKey.RelationshipType
        $relationship.ForeignKeyColumn = $foreignKey.ColumnName
        $relationship.RelatedColumn = $relatedTable.Columns[$foreignKey.ReferencedColumnName]

        [pscustomobject]@{
            $Table1 = $Table.Name 
            $Table2 = $relatedTable.Name
        }

        # Add the relationship object to the collection of relationships
        $relationships += $relationship
    }
}

# # Create a map of the database table relationships
# $relationshipMap = @{}
# foreach ($relationship in $relationships) {
#     $relationshipMap[$relationship.Table1] += $relationship
# }

# # Write the relationship map to the console
# Write-Host $relationshipMap

