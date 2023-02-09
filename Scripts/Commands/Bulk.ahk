#NoEnv

#Include, %A_ScriptDir%\..\CommandDistributor.ahk

commandsString := A_Args[1]
commandsArray := StrSplit(commandsString, "`n", "`r")
commandsPath := A_ScriptDir . "\"

for i, command in commandsArray
{
    ExecuteCommand(command, commandsPath)
}
