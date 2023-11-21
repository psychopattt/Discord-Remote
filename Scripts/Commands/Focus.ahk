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
        OutputRunningProcesses()
    else
        WriteFocusErrorMessage("Error - Focus: Invalid mode `"" . mode . "`" or missing process name")
}
else if (mode != "")
{
    FocusProcess(mode, app)
}

class RunningProcess
{
    handle := -1
    name := ""
    pid := -1

    __New(handle, name, pid)
    {
        this.handle := handle
        this.name := name
        this.pid := pid
    }

    ToString()
    {
        return this.name . ": PID = " . this.pid .
        ", Handle = " . this.handle
    }
}

GatherRunningProcesses()
{
    processes := []
    handles := WinGetList()
    processes.Capacity := handles.Length

    for handle in handles
    {
        if (WinExist("ahk_id " . handle)) ; Ensure the process is running
        {
            try
                name := WinGetProcessName("ahk_id " . handle)
            catch
                name := "[Read Denied]"

            pid := WinGetPID("ahk_id " . handle)
            processes.Push(RunningProcess(handle, name, pid))
        }
    }

    return processes
}

OutputRunningProcesses()
{
    pageCounter := 1
    VarSetStrCapacity(&processesPage, 3000) ; Reserve 3 KB of memory
    processesPage := "``````Running processes [" . pageCounter . "]:{Enter}"
    processes := GatherRunningProcesses()
    StartProcessOutput()

    while processes.Length > 0
    {
        if (StrLen(processesPage) > 1000) ; Split processes into different messages
        {
            SendResetFailsafe()
            OutputProcessesPage(processesPage)
            processesPage := "``````Running processes [" . ++pageCounter . "]:{Enter}"
        }

        processesPage .= processes.Pop().ToString() . "{Enter}"
    }

    OutputProcessesPage(processesPage)
    processesPage := "" ; Release memory
    StopProcessOutput()
}

StartProcessOutput()
{
    global processDelay
    processDelay *= 6 ; Ensure there's time to write all characters

    FocusDiscord()
    NavigateToOutChannel()
}

OutputProcessesPage(processesPage)
{
    global processDelay
    WriteCurrentChannel(processesPage . "``````{Enter}")
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
