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
    global actionTime

    switch (command)
    {
        Default:
            helpMessage =
            (
                Help has not been implemented for this command
                Good luck{!}
            )
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
        Case "Click":
            helpMessage =
            (
                Sends a mouse click
                It works just as AutoHotKey's Click command
                Options:
                Left (L), Right (R), Middle (M), X1 or X2: Specifies which button to click (X1 and X2 are side buttons)
                X Y: Specifies where to click (If present, must be before the Number option)
                Number: Specifies how many clicks to do
                Default: Sends a single left click at the current mouse position
            )
        Case "Input":
            helpMessage =
            (
                Sends the specified inputs
                It works just as AutoHotKey's SendInput command
                It can use AutoHotKey's formatting
                Options:
                Text: The inputs that will be sent
            )
        Case "Mouse":
            helpMessage =
            (
                Moves the mouse to the specified position on the screen
                The position can be absolute or relative
                Options:
                X Y: The mouse will be placed on (X, Y)
                {+}X {+}Y: The mouse will be offset by {+}X and {+}Y
                -X -Y: The mouse will be offset by -X and -Y
                {+}X -Y: The mouse will be offset by {+}X and -Y
                -X {+}Y: The mouse will be offset by -X and {+}Y
                X {+}Y: The mouse will be placed on X and offset by {+}Y
                X -Y: The mouse will be placed on X and offset by -Y
                {+}X Y: The mouse will be offset by {+}X and placed on Y
                -X Y: The mouse will be offset by -X and placed on Y
                Default: Outputs the mouse's current position
            )
    }

    helpMessage := StrReplace(helpMessage, "                ")
    helpMessage := StrReplace(helpMessage, "`n", "+{Enter}")
    helpMessage := StrReplace(helpMessage, "`r")
    helpMessage := "|+{Enter}Help - " . command . "+{Enter}" . helpMessage . "+{Enter}|"

    WriteOutput(helpMessage)
    Sleep, (actionTime * 3)
}
