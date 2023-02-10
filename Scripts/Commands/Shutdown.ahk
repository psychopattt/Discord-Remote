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
ShutdownDiscord()

ShutdownDiscord()
{
    discordHandle := WinExist("ahk_exe Discord.exe")
    WinClose, ahk_id %discordHandle%
}
