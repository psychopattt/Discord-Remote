#Include "%A_ScriptDir%\..\Config.ini"
#Include "%A_ScriptDir%\..\Discord\DiscordControls.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordChannels.ahk"

parameters := A_Args.Has(1) ? StrSplit(A_Args[1], A_Space) : []

SendMode("Event")
CoordMode("Mouse", "Screen")

switch parameters.Length
{
    case 0:
        ScreenshotWholeScreen()
    case 2:
        if (ValidateParameters(parameters))
            ScreenshotAroundMouse(parameters)
    case 4:
        if (ValidateParameters(parameters))
            ScreenshotSpecifiedZone(parameters)
    default:
        WriteScreenshotError()
}

WriteScreenshotError()
{
    WriteOutput("Error - Screenshot: Invalid parameters")
}

ValidateParameters(parameters)
{
    for parameter in parameters
    {
        if (!IsInteger(parameter))
        {
            WriteScreenshotError()
            return false
        }
    }

    return true
}

ScreenshotWholeScreen()
{
    global processDelay
    SendInput("#+s")
    Sleep(processDelay * 10)
    SendInput("{Tab}{Tab}{Tab}{Tab}{Enter}")
    Sleep(processDelay * 5)
    SendScreenshot("[Whole Screen]")
}

ScreenshotAroundMouse(parameters)
{
    global processDelay
    width := parameters[1]
    height := parameters[2]
    MouseGetPos(&mouseX, &mouseY)

    SendInput("#+s")
    Sleep(processDelay * 10)
    MouseClickDrag("L", (-width / 2), (-height / 2), width, height, 0, "R")
    Sleep(processDelay * 5)

    MouseMove(mouseX, mouseY, 0)
    SendScreenshot("[Around Mouse], {" . width . ", " . height . "}")
}

ScreenshotSpecifiedZone(parameters)
{
    global processDelay
    x := parameters[1]
    y := parameters[2]
    width := parameters[3]
    height := parameters[4]
    MouseGetPos(&mouseX, &mouseY)

    SendInput("#+s")
    Sleep(processDelay * 10)
    MouseClickDrag("L", x, y, (x + width), (y + height), 0)
    Sleep(processDelay * 5)

    MouseMove(mouseX, mouseY, 0)
    SendScreenshot("[Specified Zone], (" . x . ", " . y . "), {" . width . ", " . height . "}")
}

SendScreenshot(message)
{
    global processDelay
    FocusDiscord()
    NavigateToOutChannel()
    Sleep(processDelay)
    SendInput("{Text}Screenshot " . message . ":")
    SendInput("^v")
    Sleep(processDelay)
    SendInput("{Enter}")
    Sleep(processDelay)
    NavigateToInChannel()
}
