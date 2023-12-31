#!/bin/bash

HOME=/home/syt_su_admin

# Check if running in WSL
if grep -q "microsoft" /proc/version; then
    echo "Running in Windows Subsystem for Linux (WSL)."

    # Get the active Windows username
    windows_user=$(powershell.exe '$env:USERNAME' | tr -d '\r')
    echo "Windows username: $windows_user"

    # WSL configuration
    # Configure GitHub
    rm $HOME/.gitconfig
    ln -s $HOME/.dotfiles/github/gitconfig $HOME/.gitconfig

    # Configure zsh
    rm $HOME/.zshrc
    ln -s $HOME/.dotfiles/zsh/zshrc $HOME/.zshrc
    rm $HOME/.p10k.zsh
    ln -s $HOME/.dotfiles/zsh/p10k.zsh $HOME/.p10k.zsh

else
    echo "Running in a native Linux environment."

    # Native Linux configuration
    # Configure GitHub
    # rm ~/.gitconfig
    # ln -s ~/.dotfiles/github/gitconfig $HOME/.gitconfig

    # Configure zsh
    rm $HOME/.zshrc
    ln -s $HOME/.dotfiles/zsh/zshrc $HOME/.zshrc
    rm $HOME/.p10k.zsh
    ln -s $HOME/.dotfiles/zsh/p10k.zsh $HOME/.p10k.zsh

fi
