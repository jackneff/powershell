function GetComputers(computerlistfilename)
    dim objDictionary, objFSO, objTextFile, i, strNextLine
	
	computerlistfilename = ".\" & computerlistfilename

    set objDComputers = CreateObject("Scripting.Dictionary")
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set objTextFile = objFSO.OpenTextFile(computerlistfilename, 1)

    i = 0

    Do Until objTextFile.AtEndOfStream
		strComputer = objTextFile.Readline
      	if LEFT(strComputer,1) <> "#" then 
			objDComputers.Add i, strComputer
			i = i + 1
		end if
    Loop

    Set GetComputers = objDComputers

    Set objDComputers = Nothing
    Set objFSO = Nothing
    Set objTextFile = Nothing

end function

function ComputerOnline(computername)
		
        Set WshShell = WScript.CreateObject("WScript.Shell")

        Ping = WshShell.Run("ping -n 1 " & computername, 0, True)

        Select Case Ping
        Case 1
			ComputerOnline = False
			Err.Clear
        Case 0
			ComputerOnline = True
        End Select
end function

function GetProfiles(computername)
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set profilesubfolders = objFSO.GetFolder("\\" & computername & strProfilePath).Subfolders

    set GetProfiles = profilesubfolders

    Set objFSO = Nothing
    Set profilesubfolders = Nothing
end function

function GetLoggedInUser(computername)
  
	logonName    = ""
	
	On Error Resume Next
	Set wmi   = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & computername & "\root\cimv2") 
	set results = wmi.execQuery("Select __relpath From Win32_Process Where Caption = 'explorer.exe'")

	If results.Count <> 0 Then
		For Each result In results
			Set process = result.ExecMethod_("GetOwner")
			logonName  = process.User
		Next
	End If

	GetLoggedInUser = logonName
end function

' get SID for User
Function GetSid(username)
	On Error Resume Next
	strComputer = "."
	Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
	if Err.Number <> 0 then
		GetSid = "0"
	else
		Set objAccount = objWMIService.Get("Win32_UserAccount.Name='" & username & "',Domain='contoso.com'")
		if Err.Number <> 0 then
			GetSid = "0"
			lgDebug.Log "GetSid(): " & username & " Err.Num: " & Err.Number
		else
			GetSid = objAccount.SID
		end if
	end if

    Set objWMIService = Nothing
    Set objAccount = Nothing
End Function