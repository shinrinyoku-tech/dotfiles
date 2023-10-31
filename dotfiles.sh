#!/bin/bash

# Check if running in WSL
if grep -q "microsoft" /proc/version; then
    echo "Running in Windows Subsystem for Linux (WSL)."

    # Get the active Windows username
    windows_user=$(powershell.exe '$env:USERNAME' | tr -d '\r')
    echo "Windows username: $windows_user"

    # WSL configuration
    # Configure GitHub
    rm ~/.gitconfig
    ln -s ~/.dotfiles/github/gitconfig ~/.gitconfig

    # Configure Logseq
    #rm -r ~/.logseq
    rm -rf /mnt/c/Users/$windows_user/.logseq
    cp -r ~/.dotfiles/logseq /mnt/c/Users/$windows_user/.logseq
    

    # Configure zsh
    rm ~/.zshrc
    ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
    #/mnt/c/Users/$windows_user/AppData/Roaming/Code/User/
    
    # Configure vscode
    ## Vscode settings
    rm /mnt/c/Users/$windows_user/AppData/Roaming/Code/User/settings.json 
    cp ~/.dotfiles/vscode/settings.json /mnt/c/Users/$windows_user/AppData/Roaming/Code/User/settings.json 

    ## Python settings
    rm /mnt/c/Users/$windows_user/AppData/Roaming/Code/User/settings_python.json
    cp ~/.dotfiles/vscode/settings_python.json /mnt/c/Users/$windows_user/AppData/Roaming/Code/User/settings_python.json

    ## Vscode Profile
    rm /mnt/c/Users/$windows_user/AppData/Roaming/Code/User/settings_python.json
    cp ~/.dotfiles/vscode/settings_python.json /mnt/c/Users/$windows_user/AppData/Roaming/Code/User/settings_python.json

    ## Vscode tasks
    rm /mnt/c/Users/$windows_user/AppData/Roaming/Code/User/tasks.json
    cp ~/.dotfiles/vscode/tasks.json /mnt/c/Users/$windows_user/AppData/Roaming/Code/User/tasks.json

    ## Terminal Setttings
    rm /mnt/c/Users/$windows_user/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json
    cp ~/.dotfiles/terminal/settings_terminal.json /mnt/c/Users/$windows_user/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json

else
    echo "Running in a native Linux environment."

    # Native Linux configuration
    # Configure GitHub
    rm ~/.gitconfig
    ln -s ~/.dotfiles/github/gitconfig ~/.gitconfig

    # Configure Logseq
    rm -r ~/.logseq
    ln -s ~/.dotfiles/logseq ~/.logseq
    
    # Configure zsh
    rm ~/.zshrc
    ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc

    # Configure vscode
    ## Vscode settings
    rm ~/.config/Code/User/settings.json
    ln -s ~/.dotfiles/vscode/settings.json ~/.config/Code/User/settings.json

    ## Vscode tasks
    rm ~/.config/Code/User/tasks.json
    ln -s ~/.dotfiles/vscode/tasks.json ~/.config/Code/User/tasks.json
fi
