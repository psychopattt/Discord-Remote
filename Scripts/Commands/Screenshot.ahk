#NoEnv

#Include, %A_ScriptDir%\..\Discord\DiscordControls.ahk
#Include, %A_ScriptDir%\..\Discord\DiscordChannels.ahk

actionTime := 100
CoordMode, Mouse, Screen
parameterString := A_Args[1]
parameters := StrSplit(parameterString, " ")

switch (parameters.Length())
{
    Case 0:
        ScreenshotWholeScreen()
    Case 2:
        if (ValidateParameters(parameters, 2)) {
            ScreenshotAroundMouse(parameters)
        }
    Case 4:
        if (ValidateParameters(parameters, 4)) {
            ScreenshotSpecifiedZone(parameters)
        }
    Default:
        WriteScreenshotError()
}

WriteScreenshotError()
{
    WriteOutput("Error - Screenshot: Invalid parameters")
}

ValidateParameters(parameters, paramCount)
{
    Loop %paramCount%
    {
        currentParam := parameters[A_Index]

        if currentParam is not Integer
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
    SendInput, #+s
    Sleep, (actionTime * 10)
    SendInput, {Tab}{Tab}{Tab}{Tab}{Enter}
    Sleep, (actionTime * 5)
    SendScreenshot("[Whole Screen]")
}

ScreenshotAroundMouse(parameters)
{
    global actionTime
    width := parameters[1]
    height := parameters[2]
    MouseGetPos, mouseX, mouseY

    SendInput, #+s
    Sleep, (actionTime * 10)
    MouseClickDrag, Left, (-width / 2), (-height / 2), %width%, %height%, 0, R
    Sleep, (actionTime * 5)

    MouseMove, %mouseX%, %mouseY%, 0
    SendScreenshot("[Around Mouse], {" . width . ", " . height . "}")
}

ScreenshotSpecifiedZone(parameters)
{
    global actionTime
    x := parameters[1]
    y := parameters[2]
    width := parameters[3]
    height := parameters[4]
    MouseGetPos, mouseX, mouseY

    SendInput, #+s
    Sleep, (actionTime * 10)
    MouseClickDrag, Left, %x%, %y%, (x + width), (y + height), 0
    Sleep, (actionTime * 5)

    MouseMove, %mouseX%, %mouseY%, 0
    SendScreenshot("[Specified Zone], (" . x . ", " . y . "), {" . width . ", " . height . "}")
}

SendScreenshot(message)
{
    global actionTime
    FocusDiscord()
    NavigateToOutChannel()
    Sleep, %actionTime%
    SendInput, {Raw}Screenshot %message%:
    SendInput, ^v
    Sleep, %actionTime%
    SendInput, {Enter}
    Sleep, %actionTime%
    NavigateToInChannel()
}
