NavigateToChannel(channelName)
{
    global processDelay
    SendInput("^k{#}" . channelName . "{Enter}")
    Sleep(processDelay)
}

NavigateToInChannel()
{
    NavigateToChannel(discordChannelIn)
}

NavigateToOutChannel()
{
    NavigateToChannel(discordChannelOut)
}
