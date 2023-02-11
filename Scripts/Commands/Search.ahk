#NoEnv

actionTime := 100
CoordMode, Mouse, Screen
searchText := A_Args[1]

MouseMove, 65, A_ScreenHeight, 0
Sleep, (actionTime * 2)
SendInput, {Click}
Sleep, (actionTime * 3)
SendInput, {Raw}%searchText%
Sleep, %actionTime%
SendInput, {Enter}
Sleep, %actionTime%
