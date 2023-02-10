#NoEnv

#Include, %A_ScriptDir%\..\Discord\DiscordControls.ahk
#Include, %A_ScriptDir%\..\Discord\DiscordChannels.ahk
#Include, %A_ScriptDir%\..\Discord\DiscordMessages.ahk

actionTime := 100
parameter := A_Args[1]
parameter := Trim(parameter)

if (parameter != "") {
    message := "Shutdown [Lock] signal received"
} else {
    message := "Shutdown signal received"
}

FocusDiscord()
Sleep, %actionTime%
NavigateToInChannel()
Sleep, %actionTime%
DeleteLastMessage()
Sleep, %actionTime%
WriteOutput(message)
Sleep, (actionTime * 50) ; Waits for everything to complete
SendShutdownSignal()

if (parameter != "") {
    DllCall("user32.dll\LockWorkStation")
}
