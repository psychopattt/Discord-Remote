# Discord Remote
Discord Remote is a collection of [AutoHotKey](https://www.autohotkey.com/) scripts that allow you to control your Windows PC remotely via [Discord](https://discord.com/).

## How it works
 1. Discord Remote runs on the PC that's being controlled remotely
 2. The user sends commands and parameters in a specific Discord channel
 2. Every second, Discord Remote tries to copy the most recent message of that channel
 3. If the script finds a message, it compares the message with the available commands
 4. If the message corresponds to a command, it executes the command with the parameters that were passed
 5. If the command outputs someting, the output is sent into another specific Discord channel
 6. The user can then read the results of his commands in that output channel

## Features
 - Full remote control of your PC
 - Read and execute commands remotely
 - Take screenshots remotely
 - Keep your PC awake remotely
 - Automatic recovery from bad inputs

## Commands
All the commands and their details can be seen remotely by using the Help command
 - Help: Show how to use a command and lists all commands
 - Bulk: Execute multiple commands at once
 - Clear: Remove all messages in the input and output channels
 - Click: Send a mouse click (Works like AutoHotKey's [Click](https://www.autohotkey.com/docs/v1/lib/Click.htm) command)
 - Focus: Focus a specific window (bring it to the foreground)
 - Input: Send inputs (Works like AutoHotKey's [SendInput](https://www.autohotkey.com/docs/v1/lib/Send.htm#SendInputDetail) command)
 - Mouse: Move the mouse to the specified position on the screen
 - Ping: Send a simple ping to see if Discord Remote is running
 - Screenshot: Take a screenshot and send it in the output channel
 - Search: Search text in the Windows search box and start the first result
 - Shutdown: Terminate Discord Remote and optionally lock the PC
 - Text: Send text (Works like AutoHotKey's [SendRaw](https://www.autohotkey.com/docs/v1/lib/Send.htm#Raw) command)
 - Wait: Wait for X milliseconds
 - Important details are available when using Discord Remote

## Limitations
 - Doing anything is ***very*** slow

## How to use
 1. Download and install [AutoHotKey](https://www.autohotkey.com/) **v1.1** and [Discord](https://discord.com/download)
 2. Start Discord and create 2 channels in any server:
     1. Create a channel named `discord-remote-in`
         - Everyone who has access to this channel will be able to send commands
     2. Create a channel named `discord-remote-out`
         - Everyone who has access to this channel will be able to read command results
 3. Download the [latest release of Discord Remote](https://github.com/psychopattt/Discord-Remote/releases) (Discord-Remote.exe)
 4. **Warning**: After the next step, your PC will be controlled by the scripts
     - Attempting to use the PC might produce unexpected results like selecting or opening random apps and documents
 5. Start Discord-Remote.exe like any other executable
 6. Discord Remote is now running and can receive commands
     - You can send commands from any other device that can access Discord (browser or app)
     - Commands must be sent into the `discord-remote-in` channel
     - Command results will be sent in the `discord-remote-out` channel
 7. To stop Discord Remote, send the Shutdown command
     - Alternatively, you can press `Ctrl + Alt + F4` on the PC being controlled, but it is less reliable
