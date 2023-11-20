#Include "%A_ScriptDir%\..\Discord\DiscordControls.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordChannels.ahk"

actionTime := 100
parameter := A_Args.Has(1) ? Trim(A_Args[1]) : ""

switch parameter, false
{
    case "i", "in", "input":
        ClearInput()
    case "*", "all", "everything":
        ClearInput()
        ClearOutput()
    default:
        ClearOutput()
}

ClearInput()
{
    FocusDiscord()
    NavigateToInChannel()
    ClearCurrentChannel()
}

ClearOutput()
{
    FocusDiscord()
    NavigateToOutChannel()
    ClearCurrentChannel()
    NavigateToInChannel()
}

ClearCurrentChannel()
{
    global actionTime
    Sleep(actionTime * 3)
    command := GetCommand()

    while command != ""
    {
        Sleep(actionTime * 2)
        DeleteLastMessage()
        Sleep(actionTime * 2)
        command := GetCommand()
    }

    Sleep(actionTime)
}
