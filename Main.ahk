#NoEnv
#Persistent
#SingleInstance Force

SetWorkingDir, %A_ScriptDir%\Scripts

Run, "SleepBlocker.ahk",,, sleepBlockerPid
Run, "Discord\DiscordManager.ahk",,, discordManagerPid

OnExit("KillAllScripts")

KillAllScripts()
{
    global
    Process, Close, %sleepBlockerPid%
    Process, Close, %discordManagerPid%
}

^!F4::ExitApp, 0
