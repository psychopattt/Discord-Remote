#NoEnv

#Include, %A_ScriptDir%\..\CommandDistributor.ahk

commandsString := A_Args[1]
commandsArray := StrSplit(commandsString, "`n", "`r")

for i, command in commandsArray
{
    DistributeCommand(command)
}
