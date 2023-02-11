#NoEnv

actionTime := 100
searchText := A_Args[1]
CoordMode, Mouse, Screen

SendInput, #s
Sleep, (actionTime * 3)
SendInput, {Raw}%searchText%
Sleep, %actionTime%
SendInput, {Enter}
Sleep, %actionTime%
