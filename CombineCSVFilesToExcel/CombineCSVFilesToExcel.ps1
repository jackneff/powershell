<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function CombineCSVFilesToExcel {
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory = $true, Position = 0)]
        $CSVPath,

        # Param2 help description
        [Parameter(Mandatory = $true, Position = 1)]
        $ExcelOutputFile,

        [Parameter(Mandatory = $false)]
        [switch]$Split
    )

    Begin {
        if (Test-Path $ExcelOutputFile) {
            Remove-Item $ExcelOutputFile
        }

    }
    Process {
       
        $csv_files = gci $CSVPath -Include *.csv

        $excelapp = new-object -comobject Excel.Application
        $workbook = $excelapp.Workbooks.Add()
        $worksheets = $workbook.Worksheets
        $worksheets.Item(2).delete()
        $worksheets.Item(3).delete()
        [int]$sheet = 1
        [int]$i = 1
        
        foreach ($csv_file in $csv_files) {
            
            if ($Split.isPresent) {
                $sheet_name = $csv_file.Name.Split("-")[1]
                $sheet_name = $sheet_name.Substring(0, 31)
            }
            else {
                $sheet_name = $csv_file.Name.Split(".")[0]
                $sheet_name = $sheet_name.Substring(0, 31)

            }

            if ($i -eq 1) {
                
                $worksheet = $workbook.worksheets.Item(1)

                $worksheet.Name = $sheet_name

                $TxtConnector = ("TEXT;" + $csv_file.FullName )
            
                $CellRef = $worksheet.Range("A1")

                $Connector = $worksheet.QueryTables.add($TxtConnector, $CellRef)
                $worksheet.QueryTables.item($Connector.name).TextFileCommaDelimiter = $True
                $worksheet.QueryTables.item($Connector.name).TextFileParseType = 1
                $refresh = $worksheet.QueryTables.item($Connector.name).Refresh()
                $worksheet.QueryTables.item($Connector.name).delete()
                
            }
            else {
                            
                $worksheet = $workbook.Worksheets.add()

                $worksheet.Name = $sheet_name

                $TxtConnector = ("TEXT;" + $csv_file.FullName )
            
                $CellRef = $worksheet.Range("A1")

                $Connector = $worksheet.QueryTables.add($TxtConnector, $CellRef)
                $worksheet.QueryTables.item($Connector.name).TextFileCommaDelimiter = $True
                $worksheet.QueryTables.item($Connector.name).TextFileParseType = 1
                $refresh = $worksheet.QueryTables.item($Connector.name).Refresh()
                $worksheet.QueryTables.item($Connector.name).delete()

            }
            $i++
        }

        $save = $workbook.SaveAs($ExcelOutputFile)
        $quit = $excelapp.quit()
    }
    End {
    }
}

Combine-CSVFilesToExcel -CSVPath "\output\temp_csv\*" -ExcelOutputFile "\output\Combine_users.xlsx"