#Include "%A_ScriptDir%\..\CommandDistributor.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordControls.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordChannels.ahk"

actionTime := 100
commandsPath := A_ScriptDir . "\"
commands := A_Args.Has(1) ? StrSplit(A_Args[1], "`n", "`r") : []

for command in commands
{
    if (!CommandExists(command, commandsPath))
        WriteOutput("Error - Invalid command: " . command)
    else
        ExecuteCommand(command, commandsPath)

    Sleep(actionTime / 4)
}

Sleep(actionTime * 2)
