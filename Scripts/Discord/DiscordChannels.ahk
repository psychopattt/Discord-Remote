#NoEnv

NavigateToChannel(channelName)
{
    global
    SendInput, ^k{#}%channelName%{Enter}
    Sleep, %actionTime%
}

NavigateToInChannel()
{
    NavigateToChannel("discord-remote-in")
}

NavigateToOutChannel()
{
    NavigateToChannel("discord-remote-out")
}
