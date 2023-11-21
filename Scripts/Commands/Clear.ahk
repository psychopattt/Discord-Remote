#Include "%A_ScriptDir%\..\Config.ini"
#Include "%A_ScriptDir%\..\Discord\DiscordControls.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordChannels.ahk"

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
    global processDelay
    Sleep(processDelay)
    command := GetCommand()

    while command != ""
    {
        FocusDiscord()
        DeleteLastMessage()
        command := GetCommand()
    }

    Sleep(processDelay)
}
