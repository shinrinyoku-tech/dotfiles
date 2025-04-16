#!/bin/bash
set -e

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Create backup folder if needed
mkdir -p "$BACKUP_DIR"

# List of dotfiles to manage
DOTFILES=("zsh")  # You can add "nvim" "git" etc. later

# Backup any conflicting files and stow
for name in "${DOTFILES[@]}"; do
  for file in $(cd "$DOTFILES_DIR/$name" && find . -type f); do
    target="$HOME/${file#./}"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
      echo "Backing up $target to $BACKUP_DIR"
      mkdir -p "$BACKUP_DIR/$(dirname "$file")"
      mv "$target" "$BACKUP_DIR/$file"
    fi
  done

  echo "Stowing $name"
  stow -d "$DOTFILES_DIR" "$name"
done

# Ensure Oh My Zsh plugins are installed
echo "Installing Oh My Zsh plugins..."

# Powerlevel10k theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "Cloning powerlevel10k theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# zsh-autosuggestions plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "Cloning zsh-autosuggestions plugin..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# zsh-syntax-highlighting plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "Cloning zsh-syntax-highlighting plugin..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

echo "Dotfiles successfully stowed and plugins installed."

