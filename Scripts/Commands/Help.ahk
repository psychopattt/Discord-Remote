#Include "%A_ScriptDir%\..\Config.ini"
#Include "%A_ScriptDir%\..\CommandDistributor.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordControls.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordChannels.ahk"

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
    global processDelay

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
                - List: Lists all command names
                - Command Name: Shows help for a specific command
                - Default: Shows help for the Help command

                Examples:
                - Help ; Shows help for the help command
                - Help List ; Shows a list of all the commands
                - Help Click ; Shows help for the Click command
            )"
        case "list":
            helpMessage := "
            (
                - Bulk
                - Clear
                - Click
                - Focus
                - Help
                - Hide
                - Input
                - Mouse
                - Ping
                - Screenshot
                - Search
                - Shutdown
                - Text
                - Wait / Sleep
            )"
        case "bulk":
            helpMessage := "
            (
                Execute multiple commands
                Bulk and all of its commands must be on a separate line
                It's a good idea to put delays (see Wait) when executing commands in bulk

                Example:
                Bulk
                Focus n Paint
                Wait 300
                Screenshot
                ; Runs the commands under Bulk from top to bottom
            )"
        case "clear":
            helpMessage := "
            (
                Removes all the messages in Discord Remote's channels

                Options:
                - i, in or input: Clears the input channel
                - *, all or everything: Clears the input and the output channels
                - Default: Clears the output channel

                Examples:
                - Clear ; Clears the output channel
                - Clear i ; Clears the input channel
                - Clear all ; Clears both channels
            )"
        case "click":
            helpMessage := "
            (
                Sends various mouse inputs
                Very similar to AutoHotKey's [Click](<https://www.autohotkey.com/docs/v2/lib/Click.htm>) function

                Options:
                - Up (U) or Down (D): Specifies weither to click down or up instead of both
                - Left (L), Right (R), Middle (M), WheelUp (WU), WheelDown (WD), X1 or X2: Specifies which button to use (X1 and X2 are side buttons)
                - X Y: Specifies where to click (If present, must be before the Number option)
                - Relative (Rel): Use X and Y as relative coordinates
                - Number: Specifies how many clicks to do
                - Default: Sends a single left click at the current mouse position

                Examples:
                - Click ; Left clicks once on the current mouse position
                - Click R 235 783 3 ; Right clicks 3 times on (235, 783)
                - Click WU 5 ; Scrolls the mouse wheel up 5 times
                - Click Left 50 75 Rel ; Left clicks once on the current mouse position offset by (50, 75)
                - Click Down ; Presses and holds left click
            )"
        case "focus":
            helpMessage := "
            (
                Focus a specific window (bring it to the foreground)
                Can also output a list of running processes

                Options:
                - Mode App: Specifies the detection mode and the app identifier
                  - Mode: Handle (H), Name (N) or PID (P)
                    - The handle is always unique and can focus hidden windows
                  - App: The identifier of the app in the current mode
                - Hidden (H) or All (A): Outputs a list of all running processes, including hidden ones
                - Default: Outputs a list of all visible running processes
                  - There might be more processes when running as administrator

                Examples:
                - Focus ; Outputs a list of all visible running processes
                - Focus h ; Outputs a list of all running processes, including hidden ones
                - Focus All ; Outputs a list of all running processes, including hidden ones
                - Focus n paint ; Focuses a process named "paint.exe"
                - Focus pid 9845 ; Focuses a process with pid "9845"
                - Focus h 712346 ; Focuses the process with handle "712346"
            )"
        case "hide":
            helpMessage := "
            (
                Changes the opacity of a specific window

                Options:
                - Mode App: Specifies the detection mode and the app identifier
                  - Mode: Handle (H), Name (N) or PID (P)
                    - The handle is always unique and can focus hidden windows
                  - App: The identifier of the app in the current mode
                - Opacity: Specifies the desired opacity (between 0 and 255)
                  - If present, the opacity must appear after Mode and App
                  - If omitted or equal to -1, toggles between fully transparent and fully opaque

                Examples:
                - Hide n Discord ; Toggles a process named "Discord.exe" between fully transparent and fully opaque
                - Hide name paint 200 ; Changes the opacity of a process named "paint.exe" to 200
                - Hide pid 9845 0 ; Changes the opacity of a process with pid "9845" to 0 (fully transparent)
                - Hide h 12489 255 ; Changes the opacity of the process with handle "12489" to 255 (fully opaque)
            )"
        case "input":
            helpMessage := "
            (
                Sends the specified inputs
                Very similar to AutoHotKey's [SendInput](<https://www.autohotkey.com/docs/v2/lib/Send.htm>) function

                Options:
                - Text: The inputs that will be sent

                Examples:
                - Input qwerty12345 ; Sends "qwerty12345"
                - Input {{}Tab{}} ; Sends a Tab ("{{}{}}" contains special keys)
                - Input {^}{{}Esc{}} ; Sends Ctrl {+} Esc ("{^}" is the symbol for control)
                - Input {+}abC ; Sends "AbC" ("{+}" is the symbol for shift)
                - Input {{}Volume_Mute{}} ; Mutes the computer
                - Input {{}Raw{}}{{}Tab{}} ; Sends "Tab" as text
            )"
        case "mouse":
            helpMessage := "
            (
                Moves the mouse to the specified position on the screen
                The position can be absolute or relative

                Options:
                - X Y: The mouse will be placed on (X, Y)
                - {+}X {+}Y: The mouse will be offset by {+}X and {+}Y
                - -X -Y: The mouse will be offset by -X and -Y
                - {+}X -Y: The mouse will be offset by {+}X and -Y
                - -X {+}Y: The mouse will be offset by -X and {+}Y
                - X {+}Y: The mouse will be placed on X and offset by {+}Y
                - X -Y: The mouse will be placed on X and offset by -Y
                - {+}X Y: The mouse will be offset by {+}X and placed on Y
                - -X Y: The mouse will be offset by -X and placed on Y
                - Default: Outputs the mouse's current position

                Examples:
                - Mouse ; Outputs the mouse's current position
                - Mouse 400 700 ; The mouse will be placed on (400, 700)
                - Mouse {+}65 -34 ; The mouse will be offset from its current position by ({+}65, -34)
                - Mouse 90 {+}20 ; The mouse will placed on x=90 and offset by y=20
            )"
        case "ping":
            helpMessage := "
            (
                Sends a simple ping to see if Discord Remote is running
                Writes a message in the output channel

                Example:
                - Ping ; Writes a message in the output channel
            )"
        case "screenshot":
            helpMessage := "
            (
                Takes a screenshot and sends it in the output channel

                Options:
                - Width Height: Screenshots a rectangle around the mouse (mouse centered)
                - X Y Width Height: Screenshots the specified rectangle (X, Y are the top left)
                - Default: Screenshots the whole screen

                Examples:
                - Screenshot ; Screenshots the whole screen
                - Screenshot 300 400 ; Screenshots a 300x400 rectangle centered on the mouse
                - Screenshot 90 95 50 40 ; Screenshots a 50x40 rectangle whose top left is at (90, 95)
            )"
        case "search":
            helpMessage := "
            (
                Searches text using the Windows search box (Win {+} S) and starts the first result

                Options:
                - Text: The text to search

                Example:
                - Search paint ; Searches for "paint" and starts the first result
            )"
        case "shutdown":
            helpMessage := "
            (
                Terminates Discord Remote and optionally locks (Win {+} L) the PC

                Options:
                - Any: Terminates Discord Remote and locks the PC
                - Default: Terminates Discord Remote

                Examples:
                - Shutdown ; Terminates Discord Remote
                - Shutdown lock ; Terminates Discord Remote and locks the PC
                - Shutdown test ; Terminates Discord Remote and locks the PC
            )"
        case "text":
            helpMessage := "
            (
                Sends the specified text
                Very similar to AutoHotKey's [SendText](<https://www.autohotkey.com/docs/v2/lib/Send.htm>) function

                Options:
                - Text: The text that will be sent

                Examples:
                - Text qwerty12345 ; Sends "qwerty12345"
                - Text {{}Tab{}} ; Sends "{{}Tab{}}" as text
                - Text {^}{{}Esc{}} ; Sends "{^}{{}Esc{}}" as text
                - Text {+}abC ; Sends "{+}abC" as text
            )"
        case "wait", "sleep":
            helpMessage := "
            (
                Wait for X milliseconds

                Options:
                - Number: Wait for Number milliseconds
                - Default: Wait for 0 milliseconds

                Examples:
                - Wait 300 ; Waits for 300ms
                - Sleep 400 ; Waits for 400ms
                - Wait ; Waits for 0ms
            )"
    }

    WriteOutput(
        ">>> **Help - " . command . "**+{Enter}" .
        StrReplace(helpMessage, "`n", "+{Enter}") .
        "+{Enter}{BS}‎{Enter}"
    )

    Sleep(Max(
        processDelay,
        Integer(processDelay * StrLen(helpMessage) / 34)
    ))
}
