#Include "*i %A_ScriptDir%\DiscordChannels.ahk"
#Include "*i %A_ScriptDir%\DiscordMessages.ahk"

GetOrCreateDiscordHandle()
{
    global actionTime
    global discordHandle
    discordHandle := WinExist("ahk_exe Discord.exe")

    if (!discordHandle)
    {
        ; Find Discord.exe and start it
        loop files A_AppData . "\..\Local\Discord\Discord.exe", "R"
        {
            Run(A_LoopFileFullPath,,, &discordPid)
            WinWait("ahk_pid " . discordPid) ; Wait until window exists
            discordHandle := WinGetID("ahk_pid " . discordPid) ; Get window Id
            Sleep(actionTime * 100) ; Wait for Discord to be started
            break
        }
    }
}

GetDiscordHandle()
{
    global

    if (!IsSet(discordHandle))
        discordHandle := -1

    if (!WinExist("ahk_id " . discordHandle))
    {
        while !WinExist("ahk_exe Discord.exe")
            Sleep(actionTime)

        discordHandle := WinExist("ahk_exe Discord.exe")
    }
}

FocusDiscord()
{
    global discordHandle
    GetDiscordHandle()
    discordWinTitle := "ahk_id " . discordHandle
    WinWait(discordWinTitle) ; Wait until window exists
    WinActivate(discordWinTitle) ; Activate window
    WinMoveTop(discordWinTitle) ; Bring window to front
    WinWaitActive(discordWinTitle) ; Wait until window focused
}

GetCommand()
{
    savedClipboard := ClipboardAll()
    A_Clipboard := ""

    CopyLastMessage()
    command := A_Clipboard

    A_Clipboard := savedClipboard
    savedClipboard := ""

    return LTrim(command)
}

CopyLastMessage()
{
    global actionTime
    SendInput("{Esc}{Up}^a")
    Sleep(actionTime)
    SendInput("^c{Esc}")
    ClipWait(actionTime / 1000, 0)
}

DeleteLastMessage()
{
    global actionTime
    SendInput("{Tab}{Up}")
    Sleep(actionTime)
    SendInput("{BackSpace}{Enter}")
    Sleep(actionTime)
}

WriteCurrentChannel(message)
{
    global actionTime
    FocusDiscord()
    Sleep(actionTime)
    SendInput(message . "{Enter}")
    Sleep(actionTime)
}

WriteOutput(message)
{
    FocusDiscord()
    NavigateToOutChannel()
    WriteCurrentChannel(message)
    NavigateToInChannel()
}
