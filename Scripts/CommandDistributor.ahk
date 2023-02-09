SetWorkingDir %A_ScriptDir%\Commands

DistributeCommand(command)
{
    commandParts := ExtractCommandParts(command)
    commandName := FormatCommandName(commandParts[1])
    commandParameters := commandParts[2]
    commandPath := commandName . ".ahk"

    if (FileExist(commandPath)) {
        RunWait, %commandPath% "%commandParameters%"
    }
}

ExtractCommandParts(command)
{
    return StrSplit(command, A_Space,, 2)
}

FormatCommandName(commandName)
{
    StringUpper, formattedCommandName, commandName, T
    return formattedCommandName
}
