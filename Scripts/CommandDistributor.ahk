﻿CommandExists(command, commandsPath)
{
    if (command != "")
    {
        commandParts := ExtractCommandParts(command)
        commandName := StrTitle(commandParts[1])
        commandPath := commandsPath . commandName . ".ahk"
    
        if (FileExist(commandPath))
            return true
    }

    return false
}

ExecuteCommand(command, commandsPath)
{
    commandParts := ExtractCommandParts(command)
    commandName := StrTitle(commandParts[1])
    commandParameters := commandParts.Has(2) ? commandParts[2] : ""
    commandPath := commandsPath . commandName . ".ahk"

    if (FileExist(commandPath))
    {
        RunWait(
            A_AhkPath . " /script " . "`"" . commandPath .
            "`" `"" . commandParameters . "`""
        )
    }
}

ExtractCommandParts(command)
{
    return StrSplit(command, [A_Space, "`n"], "`r", 2)
}
