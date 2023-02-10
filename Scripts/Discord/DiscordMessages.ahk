#NoEnv

SendMessage(message)
{
    DetectHiddenWindows, On
    WinGet, allAhkProcesses, List, ahk_class AutoHotkey

    Loop, % allAhkProcesses {
        ahkProcessHandle := allAhkProcesses%A_Index%
        PostMessage, %message%,,,, ahk_id %ahkProcessHandle%
    }

    DetectHiddenWindows, Off
}

SendStopCaptureCommands() {
    SendMessage(0xCA00)
}

SendStartCaptureCommands() {
    SendMessage(0xCA01)
}

SendResetFailsafe() {
    SendMessage(0x2BED)
}

SendTriggerFailsafe() {
    SendMessage(0xDEAD)
}

SendShutdownSignal() {
    SendMessage(0xD1E0)
}
