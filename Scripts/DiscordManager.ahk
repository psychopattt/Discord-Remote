#NoEnv
#Persistent
#SingleInstance Force

discordHandle := -1
actionTime := 100
commandCheckInterval := 1000
FocusDiscord()

loop {
    Sleep, %commandCheckInterval%
    command := GetCommand()

    if (command != "")
    {
        ;Execute command
        FocusDiscord()
        DeleteLastMessage()
    }
}

GetOrCreateDiscordHandle()
{
    global
    discordHandle := WinExist("ahk_exe Discord.exe")

    if (!discordHandle) {
        Loop, Files, %A_AppData%\..\Local\Discord\Discord.exe, R
        {
            Run, %A_LoopFileFullPath%,,, discordPid
            WinWait, ahk_pid %discordPid% ; Wait until window exists
            WinGet, discordHandle, ID, ahk_pid %discordPid% ; Get window Id
            break
        }
    }
}

FocusDiscord()
{
    global
    if (!WinExist("ahk_id" discordHandle)) {
        GetOrCreateDiscordHandle()
    }

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

    return %command%
}

CopyLastMessage()
{
    global
    SendInput, {Esc}{Up}^a
    Sleep, %actionTime%
    SendInput, ^c{Esc}
    ClipWait, (actionTime / 1000)
}

DeleteLastMessage()
{
    global
    SendInput, {Tab}{Up}
    Sleep, %actionTime%
    SendInput, {BackSpace}{Enter}
    Sleep, %actionTime%
}
