#NoEnv
#Persistent
#SingleInstance Force

SetWorkingDir, %A_ScriptDir%\Scripts

Run, "SleepBlocker.ahk",,, sleepBlockerPid
Run, "Discord\DiscordManager.ahk",,, discordManagerPid
Run, "Discord\DiscordFailsafe.ahk",,, discordFailsafePid

OnExit("KillAllScripts")
OnMessage(0xD1E0, "KillAllScripts")

KillAllScripts()
{
    global
    Process, Close, %sleepBlockerPid%
    Process, Close, %discordManagerPid%
    Process, Close, %discordFailsafePid%
    ExitApp, 0
}

^!F4::KillAllScripts()
