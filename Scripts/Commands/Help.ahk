#NoEnv

#Include, %A_ScriptDir%\..\CommandDistributor.ahk
#Include, %A_ScriptDir%\..\Discord\DiscordControls.ahk
#Include, %A_ScriptDir%\..\Discord\DiscordChannels.ahk

actionTime := 300
commandsPath := A_ScriptDir . "\"
command := A_Args[1]
command := FormatCommandName(command)

if (command == "") {
    WriteCommandHelp("Help")
} else if (command == "List") {
    WriteCommandHelp("List")
} else if (!CommandExists(command, commandsPath)) {
    WriteOutput("Help - Invalid command: " . command)
} else {
    WriteCommandHelp(command)
}

WriteCommandHelp(command)
{
    switch (command)
    {
        Case "Help":
            helpMessage =
            (
                Shows how to use a certain command
                Options:
                List: Lists all command names
                Command Name: Shows help for the specified command
                Default: Shows help for the Help command
            )
        Case "List":
            helpMessage =
            (
                Bulk
                Clear
                Click
                Help
                Input
                Mouse
                Ping
                Screenshot
                Shutdown
                Sleep
                Text
            )
        Case "Bulk":
            helpMessage =
            (
                Execute multiple commands
                Bulk and each of it's commands must be on a separate line
            )
        Case "Clear":
            helpMessage =
            (
                Removes all the messages in Discord Remote's channels
                Options:
                i, in or input: Clears the input channel
                *, all or everything: Clears the input and the output channels
                Default: Clears the output channel
            )
        Default:
            helpMessage =
            (
                Help has not been implemented for this command
                Good luck{!}
            )
    }

    helpMessage := StrReplace(helpMessage, "                ")
    helpMessage := StrReplace(helpMessage, "`n", "+{Enter}")
    helpMessage := StrReplace(helpMessage, "`r")
    helpMessage := "|+{Enter}Help - " . command . "+{Enter}" . helpMessage . "+{Enter}|"

    WriteOutput(helpMessage)
    Sleep, %actionTime%
}
