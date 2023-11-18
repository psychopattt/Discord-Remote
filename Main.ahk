#NoEnv
#Persistent
#SingleInstance Force

if (A_IsCompiled) {
    RunInstallScript()
} else if (false) {
    ; Switch to true when a new file is added
    GenerateInstallScript()
}

SetWorkingDir, %A_WorkingDir%\Scripts\

Run, "%A_AhkPath%" "SleepBlocker.ahk",,, sleepBlockerPid
Run, "%A_AhkPath%" "Discord\DiscordManager.ahk",,, discordManagerPid
Run, "%A_AhkPath%" "Discord\DiscordFailsafe.ahk",,, discordFailsafePid

OnExit("KillAllScripts")
OnMessage(0xD1E0, "KillAllScripts")
^!F4::KillAllScripts()

KillAllScripts()
{
    global
    Process, Close, %sleepBlockerPid%
    Process, Close, %discordManagerPid%
    Process, Close, %discordFailsafePid%
    ExitApp, 0
}

GenerateInstallScript()
{
    installScriptPath := "Scripts\InstallScript.ahk"
    FileDelete, %installScriptPath%

    Loop, Files, .\Scripts\*.*, FR
        FileAppend, FileInstall`, %A_LoopFilePath%`, %A_LoopFilePath%`, 0`n, %installScriptPath%
}

RunInstallScript()
{
    FileCreateDir, .\Scripts\Commands
    FileCreateDir, .\Scripts\Discord
    #Include, Scripts\InstallScript.ahk
}
