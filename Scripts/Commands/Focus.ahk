#Include "%A_ScriptDir%\..\Config.ini"
#Include "%A_ScriptDir%\..\Discord\DiscordControls.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordChannels.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordMessages.ahk"

parameters := A_Args.Has(1) ? StrSplit(A_Args[1], A_Space) : []
mode := parameters.Has(1) ? StrLower(Trim(parameters[1])) : ""
app := parameters.Has(2) ? Trim(parameters[2]) : ""

if (app == "")
{
    if (mode == "h" || mode == "hidden" || mode == "a" || mode == "all")
    {
        DetectHiddenWindows(true)
        mode := ""
    }
    
    if (mode == "")
        GatherRunningProcesses()
    else
        WriteFocusErrorMessage("Error - Focus: Invalid mode `"" . mode . "`" or missing process name")
}
else if (mode != "")
{
    FocusProcess(mode, app)
}

GatherRunningProcesses()
{
    pageCounter := 1
    VarSetStrCapacity(&processes, 3000) ; Reserve 3 KB of memory
    processes := "``````Running processes [" . pageCounter . "]:{Enter}"
    
    StartProcessOutput()
    handles := WinGetList()

    for handle in handles
    {
        if (StrLen(processes) > 1000) ; Split processes into different messages
        {
            SendResetFailsafe()
            OutputRunningProcesses(processes)
            processes := "``````Running processes [" . ++pageCounter . "]:{Enter}"
        }

        name := "[Read Denied]"
        try name := WinGetProcessName("ahk_id " . handle)

        pid := WinGetPID("ahk_id " . handle)
        processes .= name . ": PID = " . pid . ", Handle = " . handle . "{Enter}"
    }

    OutputRunningProcesses(processes)
    processes := "" ; Release memory
    StopProcessOutput()
}

StartProcessOutput()
{
    global processDelay
    processDelay *= 6 ; Ensure there's time to write all characters

    FocusDiscord()
    NavigateToOutChannel()
}

OutputRunningProcesses(processes)
{
    global processDelay
    WriteCurrentChannel(processes . "``````{Enter}")
    Sleep(processDelay * 3)
}

StopProcessOutput()
{
    global processDelay
    processDelay := Integer(processDelay / 6) ; Restore original delay

    FocusDiscord()
    NavigateToInChannel()
}

FocusProcess(mode, app)
{
    switch mode, false
    {
        case "p", "pid":
            appHandle := WinExist("ahk_pid " . app)
        case "h", "handle":
            DetectHiddenWindows(true)
            appHandle := WinExist("ahk_id " . app)
        case "n", "name":
            appHandle := WinExist("ahk_exe " . (InStr(app, ".") ? app : app . ".exe"))
        default:
            WriteFocusErrorMessage("Error - Focus: Invalid mode `"" . mode . "`"")
            return
    }

    if (!appHandle)
    {
        WriteFocusErrorMessage(
            "Error - Focus: The process `"" . app .
            "`" (mode `"" . mode . "`") could not be found"
        )

        return
    }
    
    WinActivate("ahk_id " . appHandle)
    WinMoveTop("ahk_id " . appHandle)
}

WriteFocusErrorMessage(message)
{
    global processDelay
    WriteOutput(message)
    Sleep(processDelay)
}
