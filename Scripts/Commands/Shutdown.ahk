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
NavigateToInChannel()
DeleteLastMessage()
WriteOutput(message)
Sleep, 5000 ; Waits for everything to complete
SendShutdownSignal()

if (parameter != "") {
    DllCall("user32.dll\LockWorkStation")
}
