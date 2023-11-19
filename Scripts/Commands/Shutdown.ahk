#Include "%A_ScriptDir%\..\Discord\DiscordControls.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordChannels.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordMessages.ahk"

actionTime := 100
discordHandle := -1
lock := A_Args.Has(1) && Trim(A_Args[1]) != ""

FocusDiscord()
Sleep(actionTime)
NavigateToInChannel()
Sleep(actionTime)
DeleteLastMessage()
Sleep(actionTime)
WriteOutput("Shutdown " . (lock ? "[Lock] " : "") . "signal received")
Sleep(actionTime * 30) ; Wait for everything to complete
SendShutdownSignal()

if (lock)
    DllCall("user32.dll\LockWorkStation")
