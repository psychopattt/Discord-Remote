#NoEnv

CommandExists(command, commandsPath)
{
    if (command != "") {
        commandParts := ExtractCommandParts(command)
        commandName := FormatCommandName(commandParts[1])
        commandPath := commandsPath . commandName . ".ahk"
    
        if (FileExist(commandPath)) {
            return true
        }
    }

    return false
}

ExecuteCommand(command, commandsPath)
{
    commandParts := ExtractCommandParts(command)
    commandName := FormatCommandName(commandParts[1])
    commandParameters := commandParts[2]
    commandPath := commandsPath . commandName . ".ahk"

    if (FileExist(commandPath)) {
        RunWait, %commandPath% "%commandParameters%"
    }
}

ExtractCommandParts(command)
{
    return StrSplit(command, [A_Space, "`n"], "`r", 2)
}

FormatCommandName(commandName)
{
    StringUpper, formattedCommandName, commandName, T
    return formattedCommandName
}
