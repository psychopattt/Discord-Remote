#NoEnv

#Include, %A_ScriptDir%\..\Discord\DiscordControls.ahk
#Include, %A_ScriptDir%\..\Discord\DiscordChannels.ahk

actionTime := 100
parameterString := A_Args[1]
parameters := StrSplit(parameterString, " ")
mode := parameters[1]
app := parameters[2]
mode := Trim(mode)
app := Trim(app)

if (mode != "") {
    StringLower, mode, mode
}

if (app == "") {
    if (mode == "h" || mode == "hidden" || mode == "a" || mode == "all") {
        DetectHiddenWindows, On
        GatherRunningProcesses()
    } else if (mode == "") {
        GatherRunningProcesses()
    } else {
        WriteFocusErrorMessage("Error - Focus: Invalid mode """ . mode . """ or missing process name")
    }
}

if (app != "" && mode != "") {
    FocusProcess(mode, app)
}

GatherRunningProcesses()
{
    global actionTime
    actionTime *= 6 ; Ensure there's time to write all characters
    pageCounter := 1

    processes := ""
    VarSetCapacity(processes, 5000) ; Reserve 5 KB of memory
    processes := "``````Running processes [" . pageCounter . "]:{Enter}"
    
    StartProcessOutput()
    WinGet, handles, List

    Loop, % handles {
        if (StrLen(processes) > 1000) { ; Split processes into different messages
            OutputRunningProcesses(processes)
            processes := "``````Running processes [" . ++pageCounter . "]:{Enter}"
        }

        handle := handles%A_Index%
        WinGet, name, ProcessName, ahk_id %handle%
        WinGet, pid, PID, ahk_id %handle%
        processes .= name . ": PID = " . pid . ", Handle = " . handle . "{Enter}"
    }

    OutputRunningProcesses(processes)
    processes := "" ; Release memory
    StopProcessOutput()
}

StartProcessOutput()
{
    FocusDiscord()
    NavigateToOutChannel()
}

OutputRunningProcesses(processes)
{
    global actionTime
    WriteCurrentChannel(processes . "``````{Enter}")
    Sleep, (actionTime * 3)
}

StopProcessOutput()
{
    FocusDiscord()
    NavigateToInChannel()
}

FocusProcess(mode, app)
{
    switch (mode)
    {
        Case "h", "handle":
            if (!InStr(app, "0x")) {
                app := "0x" . app
            }

            DetectHiddenWindows, On
            appHandle := WinExist("ahk_id" app)           
        Case "n", "name":
            if (!InStr(app, ".")) {
                app := app . ".exe"
            }

            appHandle := WinExist("ahk_exe" app)
        Case "p", "pid":
            appHandle := WinExist("ahk_pid" app)
        Default:
            WriteFocusErrorMessage("Error - Focus: Invalid mode """ . mode . """")
            return
    }

    if (appHandle) {
        WinActivate, ahk_id %appHandle%
        WinSet, Top,, ahk_id %appHandle%
    } else {
        WriteFocusErrorMessage("Error - Focus: The process """ . app . """ (mode """ . mode . """) could not be found")
    }
}

WriteFocusErrorMessage(message)
{
    global actionTime
    WriteOutput(message)
    Sleep, %actionTime%
}
