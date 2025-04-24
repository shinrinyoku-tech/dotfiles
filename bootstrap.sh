#!/bin/bash
set -e

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "🔧 Installing essential packages..."
sudo apt-get update && sudo apt-get install -y \
    git curl fzf zsh unzip sudo stow fonts-powerline wget fontconfig \
    && sudo rm -rf /var/lib/apt/lists/*

echo "🔤 Installing CaskaydiaCove Nerd Font..."
FONT_DIR="/usr/share/fonts/truetype/caskaydia"
sudo mkdir -p "$FONT_DIR"
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/CascadiaCode.zip -O /tmp/CaskaydiaCove.zip
sudo unzip -o /tmp/CaskaydiaCove.zip -d "$FONT_DIR"
rm /tmp/CaskaydiaCove.zip
sudo fc-cache -fv > /dev/null

echo "🗂️ Preparing dotfile backups if needed..."
mkdir -p "$BACKUP_DIR"


# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "📥 Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes CHSH=no bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✔️ Oh My Zsh already installed"
fi

# List of dotfiles to manage
DOTFILES=("zsh")  # Add "nvim", "git" etc. if needed

for name in "${DOTFILES[@]}"; do
  for file in $(cd "$DOTFILES_DIR/$name" && find . -type f); do
    target="$HOME/${file#./}"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
      echo "📦 Backing up $target to $BACKUP_DIR"
      mkdir -p "$BACKUP_DIR/$(dirname "$file")"
      mv "$target" "$BACKUP_DIR/$file"
    fi
  done

  echo "📌 Stowing $name"
  stow -d "$DOTFILES_DIR" "$name"
done

echo "🔌 Installing Oh My Zsh plugins and theme..."

# Powerlevel10k theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "⬇️ Cloning powerlevel10k theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# zsh-autosuggestions plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "⬇️ Cloning zsh-autosuggestions plugin..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# zsh-syntax-highlighting plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "⬇️ Cloning zsh-syntax-highlighting plugin..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

echo "🐚 Setting Zsh as the default shell..."
chsh -s "$(which zsh)"

echo "✅ Dotfiles setup complete. Fonts, plugins, and stows are ready."


