parameterString := A_Args.Has(1) ? A_Args[1] : ""
waitCommandPath := A_ScriptDir . "\Wait.ahk"

RunWait(
    A_AhkPath . " /script " . "`"" . waitCommandPath .
    "`" `"" . parameterString . "`""
)
