#NoEnv

#Include, %A_ScriptDir%\..\Discord\DiscordControls.ahk
#Include, %A_ScriptDir%\..\Discord\DiscordChannels.ahk

actionTime := 100
parameter := A_Args[1]
StringLower, parameter, parameter

Switch (parameter)
{
    Case "i", "in", "input":
        ClearInput()
    Case "*", "all", "everything":
        ClearInput()
        ClearOutput()
    Default:
        ClearOutput()
}

ClearInput()
{
    NavigateToInChannel()
    ClearCurrentChannel()
}

ClearOutput()
{
    NavigateToOutChannel()
    ClearCurrentChannel()
    NavigateToInChannel()
}

ClearCurrentChannel()
{
    global actionTime
    Sleep, %actionTime%
    command := GetCommand()

    while (command != "")
    {
        FocusDiscord()
        DeleteLastMessage()
        command := GetCommand()
    }

    Sleep, %actionTime%
}
