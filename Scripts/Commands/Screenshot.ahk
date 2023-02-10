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
        ScreenshotAroundMouse()
    Case 4:
        ScreenshotSpecifiedPart()
    Default:
        WriteOutput("Error - Screenshot: Invalid parameters")
}

ScreenshotWholeScreen()
{
    global actionTime
    SendInput, #+s
    Sleep, (actionTime * 10)
    SendInput, {Tab}{Tab}{Tab}{Tab}{Enter}
    Sleep, (actionTime * 5)
    SendScreenshot()
}

ScreenshotAroundMouse()
{

}

ScreenshotSpecifiedPart()
{
    
}

SendScreenshot()
{
    global actionTime
    FocusDiscord()
    NavigateToOutChannel()
    Sleep, %actionTime%
    SendInput, Screenshot result:^v
    Sleep, %actionTime%
    SendInput, {Enter}
    Sleep, %actionTime%
    NavigateToInChannel()
}
