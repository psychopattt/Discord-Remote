#Include "%A_ScriptDir%\..\Config.ini"
#Include "%A_ScriptDir%\..\Discord\DiscordControls.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordChannels.ahk"

parameters := A_Args.Has(1) ? StrSplit(A_Args[1], A_Space) : []
mode := parameters.Has(1) ? StrLower(Trim(parameters[1])) : ""
app := parameters.Has(2) ? Trim(parameters[2]) : ""
desiredOpacity := parameters.Has(3) ? parameters[3] : -1

if (app == "")
{
    WriteHideErrorMessage(
        "Missing mode " . (mode == "" ? "and" : "or") .
        " process identifier"
    )
}
else
{
    HideProcess(mode, app, desiredOpacity)
}

ValidateHandle(handle)
{
    if (!handle)
    {
        WriteHideErrorMessage(
            "The process `"" . app . "`" (mode `"" .
            mode . "`") could not be found"
        )

        return false
    }
    
    return true
}

ValidateOpacity(opacity)
{
    if (!IsInteger(opacity) || opacity < -1 || opacity > 255)
    {
        WriteHideErrorMessage(
            "The opacity must be an integer between 0 and 255 " .
            "(received `"" . opacity . "`")"
        )

        return false
    }
    
    return true
}

HideProcess(mode, app, desiredOpacity)
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
            WriteHideErrorMessage("Invalid mode `"" . mode . "`"")
            return
    }

    if (!ValidateHandle(handle) || !ValidateOpacity(desiredOpacity))
        return

    if (desiredOpacity == -1)
    {
        currentOpacity := WinGetTransparent("ahk_id " . handle)
        desiredOpacity := (!IsInteger(currentOpacity) || currentOpacity > 0) ? 0 : "Off"
    }
    
    WinSetTransparent(desiredOpacity, "ahk_id " . handle)
}

WriteHideErrorMessage(message)
{
    global processDelay
    WriteOutput("Error - Hide: " . message)
    Sleep(processDelay)
}
