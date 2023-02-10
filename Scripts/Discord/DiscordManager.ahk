#NoEnv
#Persistent
#SingleInstance Force

#Include, %A_ScriptDir%\..\CommandDistributor.ahk
#Include, %A_ScriptDir%\DiscordControls.ahk

actionTime := 100
discordHandle := -1
captureCommands := false
OnMessage(0xCA00, "StopCaptureCommands")
OnMessage(0xCA01, "StartCaptureCommands")
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
            } else if (command != "") {
                DeleteLastMessage()
                WriteOutput("Error - Invalid command")
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
