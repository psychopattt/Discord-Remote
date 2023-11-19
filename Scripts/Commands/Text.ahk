SendMode("Input")
rawText := A_Args.Has(1) ? A_Args[1] : ""
SendText(rawText)
