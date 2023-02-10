#NoEnv
#Include *i %A_ScriptDir%\DiscordChannels.ahk
#Include *i %A_ScriptDir%\DiscordMessages.ahk

GetOrCreateDiscordHandle()
{
    global discordHandle
    discordHandle := WinExist("ahk_exe Discord.exe")

    if (!discordHandle) {
        Loop, Files, %A_AppData%\..\Local\Discord\Discord.exe, R
        {
            Run, %A_LoopFileFullPath%,,, discordPid
            WinWait, ahk_pid %discordPid% ; Wait until window exists
            WinGet, discordHandle, ID, ahk_pid %discordPid% ; Get window Id
            Sleep, 10000 ; Discord start time
            break
        }
    }
}

GetDiscordHandle()
{
    global discordHandle
    if (!WinExist("ahk_id" discordHandle)) {
        while, (!WinExist("ahk_exe Discord.exe")) {
            Sleep, 100
        }

        discordHandle := WinExist("ahk_exe Discord.exe")
    }
}

FocusDiscord()
{
    global discordHandle
    GetDiscordHandle()
    WinWait, ahk_id %discordHandle% ; Wait until window exists
    WinActivate, ahk_id %discordHandle% ; Activate window
    WinSet, Top,, ahk_id %discordHandle% ; Bring window to front
    WinWaitActive, ahk_id %discordHandle% ; Wait until window focused
}

GetCommand()
{
    savedClipboard := ClipboardAll
    Clipboard := ""

    CopyLastMessage()
    command := Clipboard

    Clipboard := savedClipboard
    savedClipboard := ""

    return LTrim(command)
}

CopyLastMessage()
{
    global actionTime
    SendInput, {Esc}{Up}^a
    Sleep, %actionTime%
    SendInput, ^c{Esc}
    ClipWait, (actionTime / 1000)
}

DeleteLastMessage()
{
    global actionTime
    SendInput, {Tab}{Up}
    Sleep, %actionTime%
    SendInput, {BackSpace}{Enter}
    Sleep, %actionTime%
}

WriteOutput(message)
{
    global actionTime
    FocusDiscord()
    NavigateToOutChannel()
    FocusDiscord()
    Sleep, %actionTime%
    SendInput, %message%{Enter}
    Sleep, %actionTime%
    NavigateToInChannel()
}
