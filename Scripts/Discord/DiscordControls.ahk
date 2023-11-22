#Include "*i %A_ScriptDir%\DiscordChannels.ahk"
#Include "*i %A_ScriptDir%\DiscordMessages.ahk"

GetOrCreateDiscordHandle()
{
    global processDelay
    global discordHandle
    isNewProcess := !IsSet(discordHandle) || !WinExist("ahk_id " . discordHandle)
    discordHandle := WinExist("ahk_exe Discord.exe")

    if (!discordHandle)
    {
        ; Find Discord.exe and start it
        loop files A_AppData . "\..\Local\Discord\Discord.exe", "R"
        {
            Run(A_LoopFileFullPath,,, &discordPid)
            WinWait("ahk_pid " . discordPid) ; Wait until window exists
            discordHandle := WinGetID("ahk_pid " . discordPid) ; Get window Id
            Sleep(processDelay * 100) ; Wait for Discord to be started
            break
        }
    }

    if (isNewProcess && autoHideDiscord)
        WinSetTransparent(0, "ahk_id " . discordHandle)
}

GetDiscordHandle()
{
    global

    if (!IsSet(discordHandle))
        discordHandle := -1

    if (!WinExist("ahk_id " . discordHandle))
    {
        while !WinExist("ahk_exe Discord.exe")
            Sleep(processDelay)

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
    global processDelay
    SendInput("{Esc}{Up}^a")
    Sleep(processDelay)
    SendInput("^c{Esc}{Esc}")
    ClipWait(processDelay / 1000, 0)
}

DeleteLastMessage()
{
    global processDelay
    SendInput("{Tab}{Up}")
    Sleep(processDelay)
    SendInput("{BackSpace}{Enter}")
    Sleep(processDelay * 8)
    SendInput("{Esc}{Esc}")
}

WriteCurrentChannel(message)
{
    global processDelay
    FocusDiscord()
    Sleep(processDelay)
    SendInput(message . "{Enter}")
    Sleep(processDelay)
}

WriteOutput(message)
{
    FocusDiscord()
    NavigateToOutChannel()
    WriteCurrentChannel(message)
    NavigateToInChannel()
}
