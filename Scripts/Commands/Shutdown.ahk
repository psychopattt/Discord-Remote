#Include "%A_ScriptDir%\..\Config.ini"
#Include "%A_ScriptDir%\..\Discord\DiscordControls.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordChannels.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordMessages.ahk"

lock := A_Args.Has(1) && Trim(A_Args[1]) != ""

FocusDiscord()
Sleep(processDelay)
NavigateToInChannel()
Sleep(processDelay)
DeleteLastMessage()
Sleep(processDelay)
WriteOutput("Shutdown " . (lock ? "[Lock] " : "") . "signal received")
Sleep(processDelay * 30) ; Wait for everything to complete
SendShutdownSignal()

if (lock)
    DllCall("user32.dll\LockWorkStation")
