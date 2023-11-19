SendMessage(message)
{
    DetectHiddenWindows(true)
    ahkProcesses := WinGetList("ahk_class AutoHotkey")
    
    for ahkProcessId in ahkProcesses
        PostMessage(message,,,, "ahk_id " . ahkProcessId)

    DetectHiddenWindows(false)
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
