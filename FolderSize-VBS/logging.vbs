'---------LogToFile Configuration---------
'NOTE: Copy the configuration section To 
'the beginning of an existing script. The 
'values specified here must be set before 
'calling the LogToFile sub.

'You can disable logging globally by 
'setting the bEnableLogging option to false. 
bEnableLogging = True

'Setting this to true will time stamp Each
'message that is logged to the log file
'with the current date and time.
bIncludeDateStamp = True

'This will set the log file name to the
'current date and time. You can use this
'option to create incremental log files.
bPrependDateStampInLogFileName = False

'Specify the log file location here. Path
'must contain a trailing backslash. If you
'would like to log to the same location as
'the currently running script, set this
'value to "relative" or uncomment out the
'line below.
'sLogFileLocation = "C:\LogFiles\"
sLogFileLocation = "relative"

'Specify the log file name here.
sLogFileName = "logtofiletest.txt"

'You can set whether or not you would like
'the script to append to an existing file,
'or if you would like it to overwrite
'existing copies. To overwrite set the
'sOverWriteORAppend variable to "overwrite"
sOverWriteORAppend = "append"

'Here you can set the maximum number of
'lines you like to record. If the maximum
'is reached the beginning of the log file
'will be pruned. Setting this to a value
'of 0 will disable this function.
vLogMaximumLines = 0

'This is just like limiting the log file
'to a number of lines but limits by the
'total size of the log file. This value
'is in bytes. Setting this to 0 will
'disable this function.
vLogMaximumSize = 0
'-------END LogToFile Configuration-------

Sub LogToFile(Message)
    'LogToFile.vbs 10-18-07
    'This script is provided under the Creative Commons license located
    'at http://creativecommons.org/licenses/by-nc/2.5/ . It may not
    'be used for commercial purposes with out the expressed written consent
    'of NateRice.com

    If bEnableLogging = False Then Exit Sub

    Const ForReading = 1
    Const ForWriting = 2
    Const ForAppending = 8

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
   
    sLogFile = sLogFileLocation & sLogFileName
   
    If sOverWriteORAppend = "overwrite" Then
        Set oLogFile = oLogFSO.OpenTextFile(sLogFile, ForWriting, True)
        sOverWriteORAppend = "append"
    Else
        Set oLogFile = oLogFSO.OpenTextFile(sLogFile, ForAppending, True)
    End If

    If bIncludeDateStamp Then
        Message = Now & "   " & Message
    End If

    oLogFile.WriteLine(Message)
    oLogFile.Close
   
    If vLogMaximumLines > 0 Then
      Set oReadLogFile = oLogFSO.OpenTextFile(sLogFile, ForReading, True)   
      sFileContents = oReadLogFile.ReadAll
      aFileContents = Split(sFileContents, vbCRLF)
      If Ubound(aFileContents) > vLogMaximumLines Then
        sFileContents = Replace(sFileContents, aFileContents(0) & _
        vbCRLF, "", 1, Len(aFileContents(0) & vbCRLF))
        Set oLogFile = oLogFSO.OpenTextFile(sLogFile, ForWriting, True)
        oLogFile.Write(sFileContents)
        oLogFile.Close
      End If
      oReadLogFile.Close
    End If
    
    If vLogMaximumSize > 0 Then
      Set oReadLogFile = oLogFSO.OpenTextFile(sLogFile, ForReading, True)  
      sFileContents = oReadLogFile.ReadAll
      oReadLogFile.Close
      sFileContents = RightB(sFileContents, (vLogMaximumSize*2))
      Set oLogFile = oLogFSO.OpenTextFile(sLogFile, ForWriting, True)
      oLogFile.Write(sFileContents)
      oLogFIle.Close
    End If
    
    oLogFSO = Null
End Sub

Function ConvertSize(Size) 
Do While InStr(Size,",") 'Remove commas from size 
    CommaLocate = InStr(Size,",") 
    Size = Mid(Size,1,CommaLocate - 1) & _ 
        Mid(Size,CommaLocate + 1,Len(Size) - CommaLocate) 
Loop 

Suffix = " Bytes" 
If Size >= 1024 Then suffix = " KB" 
If Size >= 1048576 Then suffix = " MB" 
If Size >= 1073741824 Then suffix = " GB" 
If Size >= 1099511627776 Then suffix = " TB" 

Select Case Suffix 
    Case " KB" Size = Round(Size / 1024, 1) 
    Case " MB" Size = Round(Size / 1048576, 1) 
    Case " GB" Size = Round(Size / 1073741824, 1) 
    Case " TB" Size = Round(Size / 1099511627776, 1) 
End Select 

ConvertSize = Size & Suffix 
End Function



