#NoEnv

#Include, %A_ScriptDir%\..\Discord\DiscordControls.ahk
#Include, %A_ScriptDir%\..\Discord\DiscordChannels.ahk
#Include, %A_ScriptDir%\..\Discord\DiscordMessages.ahk

actionTime := 100
FocusDiscord()
NavigateToInChannel()
DeleteLastMessage()
WriteOutput("Shutdown signal received")
SendShutdownSignal()

parameter := A_Args[1]
parameter := Trim(parameter)

if (parameter != "") {
    Sleep, 5000 ; Waits for everything to complete
    DllCall("user32.dll\LockWorkStation")
}
