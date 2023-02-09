#NoEnv
#Persistent
#SingleInstance Force

#Include, %A_ScriptDir%\..\CommandDistributor.ahk
#Include, %A_ScriptDir%\DiscordControls.ahk

actionTime := 100
discordHandle := -1
captureCommands := false
OnMessage(0x8000, "StartCaptureCommands")
OnMessage(0x8001, "StopCaptureCommands")
Main()

Main()
{
    commandCheckInterval := 1000
    commandsPath := A_ScriptDir . "\..\Commands\"
    global captureCommands

    loop {
        Sleep, %commandCheckInterval%

        if (captureCommands) {
            command := GetCommand()

            if (CommandExists(command, commandsPath)) {
                SendResetFailsafe()
                ExecuteCommand(command, commandsPath)
                FocusDiscord()
                DeleteLastMessage()
            }
        }
    }
}

StartCaptureCommands()
{
    global
    captureCommands := true
}

StopCaptureCommands()
{
    global
    captureCommands := false
}
