# Powerlevel10k instant prompt
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# SSH Agent (optional for container use)
start_ssh_agent() {
  if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)" > /dev/null
  fi
  export SSH_AUTH_SOCK=$(find /tmp -type s -user "$USER" -name 'agent.*' 2>/dev/null | head -n 1)
  ssh-add -l | grep "$1" &>/dev/null || ssh-add -q ~/.ssh/$1 &>/dev/null
}

# Oh My Zsh setup
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Safe plugin check
plugins=(git docker sudo history web-search copyfile copybuffer dirhistory zsh-interactive-cd)

[[ -d $ZSH/custom/plugins/zsh-autosuggestions ]] && plugins+=("zsh-autosuggestions")
[[ -d $ZSH/custom/plugins/zsh-syntax-highlighting ]] && plugins+=("zsh-syntax-highlighting")

source "$ZSH/oh-my-zsh.sh"

# Aliases
alias rm='trash -v'
alias apt-get='sudo apt-get'
alias update="sudo apt update && sudo apt upgrade -y"
alias mkdir='mkdir -pv'
alias ls='ls -F --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias l='ls -CF'
alias ps='ps auxf'

# Docker
alias dcup='docker compose up -d'
alias dcdw='docker compose down'
alias dps='docker ps'
alias dstp='docker stop'
alias dkl='docker kill'
alias dexec='docker exec -it'

# Git
alias gits='git status'
alias gita='git add'
alias gitc='git commit -m'
alias gitps='git push origin'
alias gitpl='git pull'
alias gitb='git br'
alias gitco='git co'

# Conda init (make it container-safe)
if [ -x "$(command -v conda)" ]; then
  __conda_setup="$(conda shell.zsh hook 2> /dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
      . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
      export PATH="$HOME/miniconda3/bin:$PATH"
    fi
  fi
  unset __conda_setup
fi

# Powerlevel10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
[[ -f ~/.dotfiles/zsh/.p10k.zsh ]] && source ~/.dotfiles/zsh/.p10k.zsh

# Pipx path
export PATH="$PATH:$HOME/.local/bin"
