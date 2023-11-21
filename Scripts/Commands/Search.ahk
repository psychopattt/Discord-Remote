#Include "%A_ScriptDir%\..\Config.ini"

searchText := A_Args.Has(1) ? Trim(A_Args[1]) : ""

if (searchText != "")
{
    SendInput("#s")
    Sleep(processDelay * 3)
    SendText(searchText)
    Sleep(processDelay)
    SendInput("{Enter}")
    Sleep(processDelay)
}
