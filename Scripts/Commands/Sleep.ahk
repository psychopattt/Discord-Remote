#NoEnv

sleepTime := A_Args[1]
waitCommandPath := A_ScriptDir . "\Wait.ahk"
RunWait, %waitCommandPath% %sleepTime%
