actionTime := 100
searchText := A_Args.Has(1) ? Trim(A_Args[1]) : ""

if (searchText != "")
{
    SendInput("#s")
    Sleep(actionTime * 3)
    SendText(searchText)
    Sleep(actionTime)
    SendInput("{Enter}")
    Sleep(actionTime)
}
