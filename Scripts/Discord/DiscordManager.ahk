#NoEnv
#Persistent
#SingleInstance Force

#Include, %A_ScriptDir%\..\CommandDistributor.ahk
#Include, %A_ScriptDir%\DiscordControls.ahk

actionTime := 100
discordHandle := -1
Main()

Main()
{
    commandCheckInterval := 1000
    commandsPath := A_ScriptDir . "\..\Commands\"
    FocusDiscord()

    loop {
        Sleep, %commandCheckInterval%
        command := GetCommand()

        if (command != "") {
            DistributeCommand(command, commandsPath)
            FocusDiscord()
            DeleteLastMessage()
        }
    }
}
