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

SendStartCaptureCommands() {
    SendMessage(0x8000)
}

SendStopCaptureCommands() {
    SendMessage(0x8001)
}

SendResetFailsafe() {
    SendMessage(0x2BED)
}

SendTriggerFailsafe() {
    SendMessage(0xDEAD)
}
