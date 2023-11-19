#SingleInstance Force

/*@Ahk2Exe-Keep
DirCreate(".\Scripts\Discord")
DirCreate(".\Scripts\Commands")
#Include ".\Scripts\InstallScript.ahk"
*/

Persistent(true)
^!F4::KillAllScripts()
OnExit(KillAllScripts, 1)
OnMessage(0xD1E0, KillAllScripts)
SetWorkingDir(A_WorkingDir . "\Scripts\")

sleepBlockerPid := RunSubScript("SleepBlocker.ahk")
discordManagerPid := RunSubScript("Discord\DiscordManager.ahk")
discordFailsafePid := RunSubScript("Discord\DiscordFailsafe.ahk")

RunSubScript(subPath)
{
    Run(A_AhkPath . " /script " . subPath,,, &subScriptPid)
    return subScriptPid
}

KillAllScripts(*)
{
    global
    ProcessClose(sleepBlockerPid)
    ProcessClose(discordManagerPid)
    ProcessClose(discordFailsafePid)
    OnExit(KillAllScripts, 0)
    ExitApp()
}

;@Ahk2Exe-IgnoreBegin
; Uncomment to regenerate included files
; GenerateInstallScript()

GenerateInstallScript()
{
    installScriptPath := A_WorkingDir . "\InstallScript.ahk"
    
    if (FileExist(installScriptPath))
        FileDelete(installScriptPath)

    loop files "*.*", "FR"
    {
        filePath := ".\Scripts\" . A_LoopFilePath

        FileAppend(
            "try {`nFileInstall(`"" . filePath . "`", `"" .
            filePath . "`", 0)`n} ", installScriptPath
        )
    }
}
;@Ahk2Exe-IgnoreEnd
