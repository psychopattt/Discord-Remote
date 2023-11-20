#Include "%A_ScriptDir%\..\Discord\DiscordControls.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordChannels.ahk"

actionTime := 100
discordHandle := -1
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
    global actionTime
    SendInput("#+s")
    Sleep(actionTime * 10)
    SendInput("{Tab}{Tab}{Tab}{Tab}{Enter}")
    Sleep(actionTime * 5)
    SendScreenshot("[Whole Screen]")
}

ScreenshotAroundMouse(parameters)
{
    global actionTime
    width := parameters[1]
    height := parameters[2]
    MouseGetPos(&mouseX, &mouseY)

    SendInput("#+s")
    Sleep(actionTime * 10)
    MouseClickDrag("L", (-width / 2), (-height / 2), width, height, 0, "R")
    Sleep(actionTime * 5)

    MouseMove(mouseX, mouseY, 0)
    SendScreenshot("[Around Mouse], {" . width . ", " . height . "}")
}

ScreenshotSpecifiedZone(parameters)
{
    global actionTime
    x := parameters[1]
    y := parameters[2]
    width := parameters[3]
    height := parameters[4]
    MouseGetPos(&mouseX, &mouseY)

    SendInput("#+s")
    Sleep(actionTime * 10)
    MouseClickDrag("L", x, y, (x + width), (y + height), 0)
    Sleep(actionTime * 5)

    MouseMove(mouseX, mouseY, 0)
    SendScreenshot("[Specified Zone], (" . x . ", " . y . "), {" . width . ", " . height . "}")
}

SendScreenshot(message)
{
    global actionTime
    FocusDiscord()
    NavigateToOutChannel()
    Sleep(actionTime)
    SendInput("{Text}Screenshot " . message . ":")
    SendInput("^v")
    Sleep(actionTime)
    SendInput("{Enter}")
    Sleep(actionTime)
    NavigateToInChannel()
}
