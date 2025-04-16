#!/bin/bash
set -e

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup"

# Create backup folder if needed
mkdir -p "$BACKUP_DIR"

# List of dotfiles to manage
DOTFILES=("zsh") # "nvim" "git" "tmux"

# Check and move conflicting files
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

echo "Dotfiles successfully stowed."
