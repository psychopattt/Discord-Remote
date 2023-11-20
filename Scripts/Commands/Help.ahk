#Include "%A_ScriptDir%\..\CommandDistributor.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordControls.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordChannels.ahk"

actionTime := 300
commandsPath := A_ScriptDir . "\"
command := A_Args.Has(1) ? StrTitle(Trim(A_Args[1])) : ""

if (command == "")
    WriteCommandHelp("Help")
else if (command == "List") ; Invalid command, but valid parameter
    WriteCommandHelp(command)
else if (!CommandExists(command, commandsPath))
    WriteOutput("Help - Invalid command: " . command)
else
    WriteCommandHelp(command)

WriteCommandHelp(command)
{
    global actionTime

    switch command, false
    {
        default:
            helpMessage := "
            (
                Help has not been implemented for this command
                Good luck{!}
            )"
        case "help":
            helpMessage := "
            (
                Shows how to use a certain command
                Options:
                List: Lists all command names
                Command Name: Shows help for a specific command
                Default: Shows help for the Help command
            )"
        case "list":
            helpMessage := "
            (
                Bulk
                Clear
                Click
                Focus
                Help
                Input
                Mouse
                Ping
                Screenshot
                Search
                Shutdown
                Text
                Wait / Sleep
            )"
        case "bulk":
            helpMessage := "
            (
                Execute multiple commands
                Bulk and all of its commands must be on a separate line
                It's a good idea to put delays (see Wait) when executing commands in bulk
            )"
        case "clear":
            helpMessage := "
            (
                Removes all the messages in Discord Remote's channels
                Options:
                i, in or input: Clears the input channel
                *, all or everything: Clears the input and the output channels
                Default: Clears the output channel
            )"
        case "click":
            helpMessage := "
            (
                Sends a mouse click
                Works just like AutoHotKey's Click command
                Options:
                Up (U) or Down (D): Specifies weither to click down or up instead of both
                Left (L), Right (R), Middle (M), WheelUp (WU), WheelDown (WD), X1 or X2: Specifies which button to use (X1 and X2 are side buttons)
                X Y: Specifies where to click (If present, must be before the Number option)
                Relative (Rel): Use X and Y as relative coordinates
                Number: Specifies how many clicks to do
                Default: Sends a single left click at the current mouse position
            )"
        case "focus":
            helpMessage := "
            (
                Focus a specific window (bring it to the foreground)
                Options:
                Mode App: Specifies the detection mode and the app identifier
                  Mode: Handle (H), Name (N) or PID (P)
                    The handle is always unique and can focus hidden windows
                  App: The identifier of the app in the current mode
                Hidden (H) or All (A): Outputs a list of all the running processes, including hidden ones
                Default: Outputs a list of all the visible running processes
                  There might be more processes when running as administrator
            )"
        case "input":
            helpMessage := "
            (
                Sends the specified inputs
                Works just like AutoHotKey's SendInput command
                Can use AutoHotKey's formatting
                Options:
                Text: The inputs that will be sent
            )"
        case "mouse":
            helpMessage := "
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
            )"
        case "ping":
            helpMessage := "
            (
                Sends a simple ping to see if Discord Remote is running
                Writes a message in the output channel
            )"
        case "screenshot":
            helpMessage := "
            (
                Takes a screenshot and sends it in the output channel
                Options:
                Width Height: Screenshots a rectangle around the mouse (mouse centered)
                X Y Width Height: Screenshots the specified rectangle (X, Y are the top left)
                Default: Screenshots the whole screen
            )"
        case "search":
            helpMessage := "
            (
                Searches text using the Windows search box (Win {+} S) and starts the first result
                Options:
                Text: The text to search
            )"
        case "shutdown":
            helpMessage := "
            (
                Terminates Discord Remote and optionally locks (Win {+} L) the PC
                Options:
                Any: Terminates Discord Remote and locks the PC
                Default: Terminates Discord Remote
            )"
        case "text":
            helpMessage := "
            (
                Sends the specified text
                Works just like AutoHotKey's SendText command
                Options:
                Text: The text that will be sent
            )"
        case "wait", "sleep":
            helpMessage := "
            (
                Wait for X milliseconds
                Options:
                Number: Wait for Number milliseconds
                Default: Wait for 0 milliseconds
            )"
    }

    WriteOutput("``````Help - " . command . "{Enter}" . helpMessage . "``````{Enter}")
    Sleep(actionTime * 3)
}
