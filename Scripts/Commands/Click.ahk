#NoEnv

CoordMode, Mouse, Screen
parameterString := A_Args[1]
SendInput, {Click %parameterString%}
