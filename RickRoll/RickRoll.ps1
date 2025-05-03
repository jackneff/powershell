
Function Set-Speaker($Volume){
    $wshShell = New-Object -ComObject wscript.shell;1..50 | 
        ForEach-Object {$wshShell.SendKeys([char]174)};1..$Volume | 
            ForEach-Object {$wshShell.SendKeys([char]175)}
}

function RickRoll {

$Voice = New-Object -ComObject Sapi.SPVoice

$Lyrics = @'
Never gonna give you up
Never gonna let you down
Never gonna run around and desert you
Never gonna make you cry
Never gonna say goodbye
Never gonna tell a lie and hurt you
'@

    Set-Speaker -Volume 100
    Start-Sleep -Seconds 2
    $Voice.Speak($Lyrics)

}

RickRoll