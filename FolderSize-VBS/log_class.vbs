    Const ForReading = 1
    Const ForWriting = 2
    Const ForAppending = 8

class LogFile
	public oLogError
	public sLogFileName
	public bLogMessages
	public bIncludeDateStamp
	public bPrependDateStampInLogFileName
	public bRelativePath
	public sLogFileLocation
	public sOverWriteORAppend
	public vLogMaximumLines
	public vLogMaximumSize
	public oLogFile

    public function LogInitalize(logfilename)
		'on Error Resume Next
		if IsEmpty(bLogMessages) then bLogMessages = true
		if IsEmpty(bRelativePath) then bRelativePath = true
		if IsEmpty(bIncludeDateStamp) then bIncludeDateStamp = true
		if IsEmpty(bPrependDateStampInLogFileName) then bPrependDateStampInLogFileName = false
		if IsEmpty(sLogFileLocation) then sLogFileLocation = "relative"
		if IsEmpty(sOverWriteORAppend) then sOverWriteORAppend = "overwrite"
		if IsEmpty(vLogMaximumLines) then vLogMaximumLines = 0
		if IsEmpty(vLogMaximumSize) then vLogMaximumSize = 0

		sLogFileName = logfilename
    	
		Set oLogFSO = CreateObject("Scripting.FileSystemObject")
		
		If sLogFileLocation = "relative" Then
			Set oLogShell = CreateObject("Wscript.Shell")
			sLogFileLocation = oLogShell.CurrentDirectory & "\"
			Set oLogShell = Nothing
		End If
	
		If bPrependDateStampInLogFileName Then
			sNow = Replace(Replace(Now(),"/","-"),":",".")
			sLogFileName = sNow & " - " & sLogFileName
			bPrependDateStampInLogFileName = False       
		End If
		
		if bRelativePath then
			sLogFileName = sLogFileLocation & sLogFileName
		end if

	
		If sOverWriteORAppend = "overwrite" Then
			'wscript.echo sLogFileName
			Set LogInitalize = oLogFSO.OpenTextFile(sLogFileName, ForWriting, True)
			if Err.Number <> 0 then
				Set LogInitalize = Nothing
				Set oLogError = Err
				exit function
			else 
				'Wscript.echo "Error Creating log"
			end if
			sOverWriteORAppend = "append"
		Else
			Set LogInitalize = oLogFSO.OpenTextFile(sLogFileName, ForAppending, True)
			if Err.Number <> 0 then
				Set LogInitalize = Nothing
				Set oLogError = Err
				exit function
			end if
		End If
		
		Set oLogFSO = Nothing
	end function

	public sub Log(message)
		If bIncludeDateStamp Then
			message = Now & "   " & message
		End If
		if bLogMessages then
			oLogFile.WriteLine(message)
			TrimLog()
		end if
	end sub
	
	public sub LogTrim(message)
		If bIncludeDateStamp Then
			message = Now & "   " & message
		End If
		if bLogMessages then
			oLogFile.Write(message)
			TrimLog()
		end if
	end sub

	public sub Clear
		oLogFile.Close
		Set oLogFSO = CreateObject("Scripting.FileSystemObject")
		Set oLogFile = oLogFSO.OpenTextFile(sLogFileName, ForWriting, True)
		oLogFile.Close
		Set oLogFile = oLogFSO.OpenTextFile(sLogFileName, ForAppending, True)
	end sub
	
	public sub Close
		oLogFile.Close
		Set oLogFile = Nothing
	end sub
	
	public sub TrimLog
		If vLogMaximumLines > 0 Then
			Set oLogFSO = CreateObject("Scripting.FileSystemObject")
			Set oReadLogFile = oLogFSO.OpenTextFile(sLogFileName, ForReading, True)
			sFileContents = oReadLogFile.ReadAll
			aFileContents = Split(sFileContents, vbCRLF)
			wscript.echo Ubound(aFileContents) & " : " & vLogMaximumLines
			If Ubound(aFileContents) > vLogMaximumLines Then
				sFileContents = Replace(sFileContents, aFileContents(0) & vbCRLF, "", 1, Len(aFileContents(0) & vbCRLF))
				Clear()
				oLogFile.Write(sFileContents)
			End If
		oReadLogFile.Close
		Set oReadLogFile = Nothing
		Set oLogFSO = Nothing
		End If
		
		If vLogMaximumSize > 0 Then
			Set oLogFSO = CreateObject("Scripting.FileSystemObject")
			Set oReadLogFile = oLogFSO.OpenTextFile(sLogFileName, ForReading, True)  
			sFileContents = oReadLogFile.ReadAll
			oReadLogFile.Close
			sFileContents = RightB(sFileContents, (vLogMaximumSize*2))
			Clear()
			oLogFile.Write(sFileContents)
			Set oReadLogFile = Nothing
			Set oLogFSO = Nothing
		End If
	end sub

end class