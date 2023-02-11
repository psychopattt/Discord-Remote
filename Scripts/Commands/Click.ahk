#NoEnv

options := A_Args[1]
CoordMode, Mouse, Screen
SendInput, {Click %options%}
