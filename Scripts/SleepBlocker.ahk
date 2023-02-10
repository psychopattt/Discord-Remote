#NoEnv
#Persistent
#SingleInstance Force

recentlyUpdated := true
OnMessage(0x2BED, "Update")
OnMessage(0xCA01, "Update")
SetTimer, CheckPingRequired, 29000

CheckPingRequired()
{
    global recentlyUpdated

    if (recentlyUpdated) {
        recentlyUpdated := false
    } else {
        ShakeMouse()
        Update()
    }
}

Update()
{
    global recentlyUpdated
    recentlyUpdated := true
}

ShakeMouse()
{
    MouseMove, 1, 0, 1, R
    MouseMove, -1, 0, 1, R
}
