#SingleInstance Force
#Include "%A_ScriptDir%\..\Config.ini"
#Include "%A_ScriptDir%\..\CommandDistributor.ahk"
#Include "%A_ScriptDir%\DiscordControls.ahk"

captureCommands := false

Persistent(true)
OnMessage(0xCA00, StopCaptureCommands)
OnMessage(0xCA01, StartCaptureCommands)
Main()

Main()
{
    commandCheckInterval := 1000
    commandsPath := A_ScriptDir . "\..\Commands\"
    global captureCommands

    loop
    {
        Sleep(commandCheckInterval)

        if (captureCommands)
        {
            command := GetCommand()

            if (CommandExists(command, commandsPath))
            {
                SendResetFailsafe()
                ExecuteCommand(command, commandsPath)
                FocusDiscord()
                DeleteLastMessage()
            }
            else if (command != "")
            {
                DeleteLastMessage()
                command := StrReplace(SubStr(command, 1, 30), "``")
                WriteOutput("Error - Invalid command: " . command)
            }
        }
    }
}

StartCaptureCommands(*)
{
    global
    captureCommands := true
}

StopCaptureCommands(*)
{
    global
    captureCommands := false
}
