waitTime := A_Args.Has(1) ? A_Args[1] : 0

if (IsInteger(waitTime))
    Sleep(waitTime)
