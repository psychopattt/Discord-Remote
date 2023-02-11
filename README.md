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
 - Help: Shows how to use a command and lists all commands
 - Bulk: Execute multiple commands at once
 - Clear: Remove all messages in the input and output channels
 - Click: Sends a mouse click (Works like AutoHotKey's [Click](https://www.autohotkey.com/docs/v1/lib/Click.htm) command)
 - Focus: Focus a specific window (bring it to the foreground)
 - Input: Send inputs (Works like AutoHotKey's [SendInput](https://www.autohotkey.com/docs/v1/lib/Send.htm#SendInputDetail) command)
 - Mouse: Moves the mouse to the specified position on the screen
 - Ping: Sends a simple ping to see if Discord Remote is running
 - Screenshot: Takes a screenshot and sends it in the output channel
 - Search: Searches text in the Windows search box and starts the first result
 - Shutdown: Terminates Discord Remote and optionally locks the PC
 - Text: Send text (Works like AutoHotKey's [SendRaw](https://www.autohotkey.com/docs/v1/lib/Send.htm#Raw) command)
 - Wait: Wait for X milliseconds
 - Important details are available when using Discord Remote

## Limitations
 - Doing anything is ***very*** slow

## How to use
 - Coming soon
