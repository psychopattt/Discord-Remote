#NoEnv

#Include, %A_ScriptDir%\..\Discord\DiscordControls.ahk
#Include, %A_ScriptDir%\..\Discord\DiscordChannels.ahk

actionTime := 100
CoordMode, Mouse, Screen
parameterString := A_Args[1]
parameters := StrSplit(parameterString, " ")

if (parameters.Length() != 2) {
    OutputMousePosition()
} else {
    x := parameters[1]
    y := parameters[2]

    if (ValidateCoords(x, y)) {
        xMode := GetMode(x)
        yMode := GetMode(y)
        x := ClampCoord(x, A_ScreenWidth, xMode)
        y := ClampCoord(y, A_ScreenHeight, yMode)

        MoveMouse(x, y, xMode, yMode)
    }
}

OutputMousePosition()
{
    MouseGetPos, currentX, currentY
    WriteOutput("Mouse position: (" . currentX . ", " . currentY . ")")
}

GetMode(coord)
{
    if (InStr(coord, "+") || InStr(coord, "-")) {
        return "R"
    }

    return ""
}

ClampCoord(coord, max, mode)
{
    if (mode == "R") {
        return Max(-max, Min(coord, max))
    }

    return Max(0, Min(coord, max))
}

MoveMouse(x, y, xMode, yMode)
{
    if (xMode == yMode) {
        MouseMove, %x%, %y%, 0, %xMode%
    } else {
        MouseGetPos, currentX, currentY

        if (xMode == "R") { ; X is relative and Y is absolute
            MouseMove, %currentX%, %y%, 0
            MouseMove, %x%, 0, 0, R
        } else { ; X is absolute and Y is relative
            MouseMove, %x%, %currentY%, 0
            MouseMove, 0, %y%, 0, R
        }
    }
}

ValidateCoords(x, y)
{
    errorMessage := ""

    if x is not Integer
    {
        errorMessage := "Error - Mouse: Invalid X"
    }
    
    if y is not Integer
    {
        if (errorMessage != "") {
            errorMessage := "Error - Mouse: Invalid X and Y"
        } else {
            errorMessage := "Error - Mouse: Invalid Y"
        }
    }

    if (errorMessage != "") {
        WriteOutput(errorMessage)
        return false
    }

    return true
}
