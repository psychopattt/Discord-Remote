#NoEnv
#Persistent
#SingleInstance Force

#Include, %A_ScriptDir%\DiscordControls.ahk

discordHandle := -1
failsafeRequired := true
OnMessage(0x2BED, "ResetFailsafe")
OnMessage(0xDEAD, "TriggerFailsafe")
Main()

Main()
{
    global failsafeRequired
    failCheckInterval := 20000

    loop {
        if (failsafeRequired) {
            TriggerFailsafe()
        } else {
            failsafeRequired := true
        }

        Sleep, %failCheckInterval%
    }
}

ResetFailsafe()
{
    global
    failsafeRequired := false
}

TriggerFailsafe()
{
    SendStopCaptureCommands()
    GetOrCreateDiscordHandle()
    FocusDiscord()
    NavigateToInChannel()
    SendStartCaptureCommands()
}
