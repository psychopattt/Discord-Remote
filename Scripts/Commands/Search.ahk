#NoEnv

actionTime := 100
searchText := A_Args[1]

SendInput, #s
Sleep, (actionTime * 3)
SendInput, {Raw}%searchText%
Sleep, %actionTime%
SendInput, {Enter}
Sleep, %actionTime%
