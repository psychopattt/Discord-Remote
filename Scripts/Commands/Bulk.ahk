#NoEnv

#Include, %A_ScriptDir%\..\CommandDistributor.ahk
#Include, %A_ScriptDir%\..\Discord\DiscordControls.ahk
#Include, %A_ScriptDir%\..\Discord\DiscordChannels.ahk

actionTime := 100
commandsString := A_Args[1]
commandsArray := StrSplit(commandsString, "`n", "`r")
commandsPath := A_ScriptDir . "\"

for i, command in commandsArray
{
    if (!CommandExists(command, commandsPath)) {
        WriteOutput("Error - Invalid command")
    } else {
        ExecuteCommand(command, commandsPath)
    }
}
