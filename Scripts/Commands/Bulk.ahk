#Include "%A_ScriptDir%\..\Config.ini"
#Include "%A_ScriptDir%\..\CommandDistributor.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordControls.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordChannels.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordMessages.ahk"

commandsPath := A_ScriptDir . "\"
commands := A_Args.Has(1) ? StrSplit(A_Args[1], "`n", "`r") : []

for command in commands
{
    if (!CommandExists(command, commandsPath))
        WriteOutput("Error - Invalid command: " . command)
    else
        ExecuteCommand(command, commandsPath)

    Sleep(processDelay / 4)
    SendResetFailsafe()
}

Sleep(processDelay * 2)
