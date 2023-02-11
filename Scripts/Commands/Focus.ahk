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

if (app == "" || mode == "") {
    OutputRunningApps()
} else {
    FocusApp(mode, app)
}

OutputRunningApps()
{
    global actionTime
    actionTime := 300

    processes := "``````Running processes:+{Enter}"
    WinGet, handles, List

    Loop, % handles {
        handle := handles%A_Index%
        WinGet, name, ProcessName, ahk_id %handle%
        WinGet, pid, PID, ahk_id %handle%
        processes := processes . name . ": PID = " . pid . ", Handle = " . handle . "+{Enter}"
    }

    processes := processes . "``````{Enter}"
    WriteFocusMessage(processes)
}

FocusApp(mode, app)
{
    StringLower, mode, mode

    switch (mode)
    {
        Case "h", "handle":
            if (!InStr(app, "0x")) {
                app := "0x" . app
            }

            appHandle := WinExist("ahk_id" app)           
        Case "n", "name":
            if (!InStr(app, ".")) {
                app := app . ".exe"
            }

            appHandle := WinExist("ahk_exe" app)
        Case "p", "pid":
            appHandle := WinExist("ahk_pid" app)
        Default:
            WriteFocusMessage("Error - Focus: Invalid mode """ . mode . """")
            return
    }

    if (appHandle) {
        WinActivate, ahk_id %appHandle%
        WinSet, Top,, ahk_id %appHandle%
    } else {
        WriteFocusMessage("Error - Focus: The process """ . app . """ (mode """ . mode . """) could not be found")
    }
}

WriteFocusMessage(message)
{
    global actionTime
    WriteOutput(message)
    Sleep, (actionTime * 3)
}
