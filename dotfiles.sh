#!/bin/bash


# Configure zsh
rm ~/.zshrc
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc


# Configure vscode
## Vscode settings
rm ~/.config/Code/User/settings.json
ln -s ~/.dotfiles/vscode/settings.json ~/.config/Code/User/settings.json

## Vscode tasks
rm ~/.config/Code/User/tasks.json
ln -s ~/.dotfiles/vscode/tasks.json ~/.config/Code/User/tasks.json
