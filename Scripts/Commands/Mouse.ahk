#Include "%A_ScriptDir%\..\Config.ini"
#Include "%A_ScriptDir%\..\Discord\DiscordControls.ahk"
#Include "%A_ScriptDir%\..\Discord\DiscordChannels.ahk"

parameters := A_Args.Has(1) ? StrSplit(A_Args[1], A_Space) : []
CoordMode("Mouse", "Screen")

if (parameters.Length != 2)
{
    OutputMousePosition()
}
else
{
    x := parameters[1]
    y := parameters[2]

    if (ValidateCoords(x, y))
        MoveMouse(x, y, GetMode(x), GetMode(y))
}

OutputMousePosition()
{
    MouseGetPos(&currentX, &currentY)
    WriteOutput("Mouse position: (" . currentX . ", " . currentY . ")")
}

GetMode(coord)
{
    if (InStr(coord, "+") || InStr(coord, "-"))
        return "R"

    return ""
}

MoveMouse(x, y, xMode, yMode)
{
    if (xMode == yMode)
    {
        MouseMove(x, y, 0, xMode)
    }
    else
    {
        MouseGetPos(&currentX, &currentY)

        if (xMode == "R") ; X is relative and Y is absolute
        {
            MouseMove(currentX, y, 0)
            MouseMove(x, 0, 0, "R")
        }
        else ; X is absolute and Y is relative
        {
            MouseMove(x, currentY, 0)
            MouseMove(0, y, 0, "R")
        }
    }
}

ValidateCoords(x, y)
{
    errorMessage := ""

    if (!IsInteger(x))
        errorMessage := "Error - Mouse: Invalid X"
    
    if (!IsInteger(y))
    {
        if (errorMessage != "")
            errorMessage .= " and Y"
        else
            errorMessage := "Error - Mouse: Invalid Y"
    }

    if (errorMessage != "")
    {
        WriteOutput(errorMessage)
        return false
    }

    return true
}
