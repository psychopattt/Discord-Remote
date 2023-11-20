#SingleInstance Force
#Include "%A_ScriptDir%\DiscordControls.ahk"

actionTime := 100
failsafeRequired := true

Persistent(true)
OnMessage(0x2BED, ResetFailsafe)
OnMessage(0xDEAD, TriggerFailsafe)
Main()

Main()
{
    global failsafeRequired
    failCheckInterval := 60000

    loop
    {
        if (failsafeRequired) {
            TriggerFailsafe()
        } else {
            failsafeRequired := true
        }

        Sleep(failCheckInterval)
    }
}

ResetFailsafe(*)
{
    global
    failsafeRequired := false
}

TriggerFailsafe(*)
{
    SendStopCaptureCommands()
    GetOrCreateDiscordHandle()
    FocusDiscord()
    NavigateToInChannel()
    SendStartCaptureCommands()
}
