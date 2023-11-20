options := A_Args.Has(1) ? A_Args[1] : ""

CoordMode("Mouse", "Screen")
SendInput("{Click " . options . "}")
