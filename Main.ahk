#NoEnv
#Persistent
#SingleInstance Force

SetWorkingDir, %A_ScriptDir%\scripts

Run, "SleepBlocker.ahk",,, sleepBlockerPID
Run, "DiscordManager.ahk",,, discordManagerPID

OnExit("KillAllScripts")

KillAllScripts()
{
    global
    Process, Close, %sleepBlockerPID%
    Process, Close, %discordManagerPID%
}
