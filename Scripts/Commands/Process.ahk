#Include "%A_ScriptDir%\..\Config.ini"
#Include "%A_ScriptDir%\..\Discord\DiscordControls.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordChannels.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordMessages.ahk"

mode := A_Args.Has(1) ? StrLower(Trim(A_Args[1])) : ""

if (mode == "*" || mode == "h" || mode == "hidden" || mode == "a" || mode == "all")
    DetectHiddenWindows(true)

OutputRunningProcesses()

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
