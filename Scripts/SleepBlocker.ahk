#NoEnv
#Persistent
#SingleInstance Force

recentlyUpdated := true
SetTimer, CheckPingRequired, 5000

CheckPingRequired()
{
    if (recentlyUpdated) {
        recentlyUpdated = false
    } else {
        MoveMouse()
    }
}

MoveMouse()
{
    MouseMove, 1, 0, 1, R
    MouseMove, -1, 0, 1, R
}
