#Include "%A_ScriptDir%\..\Config.ini"
#Include "%A_ScriptDir%\..\Discord\DiscordControls.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordChannels.ahk"

parameters := A_Args.Has(1) ? StrSplit(A_Args[1], A_Space) : []
mode := parameters.Has(1) ? StrLower(Trim(parameters[1])) : ""
app := parameters.Has(2) ? Trim(parameters[2]) : ""

if (app == "")
{
    WriteFocusErrorMessage(
        "Missing mode " . (mode == "" ? "and" : "or") .
        " process identifier"
    )
}
else
{
    FocusProcess(mode, app)
}

ValidateHandle(handle)
{
    if (!handle)
    {
        WriteFocusErrorMessage(
            "The process `"" . app . "`" (mode `"" .
            mode . "`") could not be found"
        )

        return false
    }

    return true
}

FocusProcess(mode, app)
{
    switch mode, false
    {
        case "p", "pid":
            handle := WinExist("ahk_pid " . app)
        case "h", "handle":
            DetectHiddenWindows(true)
            handle := WinExist("ahk_id " . app)
        case "n", "name":
            handle := WinExist("ahk_exe " . (InStr(app, ".") ? app : app . ".exe"))
        default:
            WriteFocusErrorMessage("Invalid mode `"" . mode . "`"")
            return
    }

    if (!ValidateHandle(handle))
        return

    WinActivate("ahk_id " . handle)
    WinMoveTop("ahk_id " . handle)
}

WriteFocusErrorMessage(message)
{
    global processDelay
    WriteOutput("Error - Focus: " . message)
    Sleep(processDelay)
}
