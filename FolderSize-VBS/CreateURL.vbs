On Error Resume Next

' VBScript "Include" routine
Sub Include(sInstFile)
	On Error Resume Next

	Dim oFSO, f, s

	Set oFSO = CreateObject("Scripting.FileSystemObject")
	If oFSO.FileExists(sInstFile) Then
		Set f = oFSO.OpenTextFile(sInstFile)
		s = f.ReadAll
		f.Close
		ExecuteGlobal s
	End If

	Set oFSO = Nothing
	Set f = Nothing
End Sub

Function ShowFolderSize(oF)
dim F
    
    for each F in oF.Subfolders
	'LogToFile(UCase(f.Path))
        if f.name = "My Documents" then
		MyDocSize = MyDocSize + f.Size
		TotalDocSize = TotalDocSize + f.Size
		'LogToFile("MyDocSize" & ConvertSize(MyDocSize))
	end if
	ShowFolderSize(F)
    next

end Function

Include("logging.vbs")

Dim oFolder, MyDocSize, TotalDocSize

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objDictionary = CreateObject("Scripting.Dictionary")
Set objTextFile = objFSO.OpenTextFile(".\servers.txt", 1)

i = 0


Do Until objTextFile.AtEndOfStream 
  strNextLine = objTextFile.Readline
  objDictionary.Add i, strNextLine
  i = i + 1
Loop

For Each objItem in objDictionary

	StrComputer = objDictionary.Item(objItem)
	
	Set WshShell = WScript.CreateObject("WScript.Shell")

	Ping = WshShell.Run("ping -n 1 " & StrComputer, 0, True)

	Select Case Ping
	Case 1
		LogToFile(StrComputer & " Not Connected.")
		Err.Clear
	Case 0
		set oFolder = objFSO.GetFolder("\\" & StrComputer & "\c$\Documents and Settings\")
		
		MyDocSize = 0
		
		ShowFolderSize(oFolder)

		LogToFile(StrComputer & " " & oFolder.Name & ":Size=" & ConvertSize(MyDocSize))
	End Select

	

Next

LogToFile("Total Doc Size: " & ConvertSize(TotalDocSize))

