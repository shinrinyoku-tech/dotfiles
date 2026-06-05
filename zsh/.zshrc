# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Function to start SSH agent and add key
start_ssh_agent() {
    if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        eval "$(ssh-agent -s)" > /dev/null
    fi

    # Ensure SSH_AUTH_SOCK is correctly set
    export SSH_AUTH_SOCK=$(find /tmp -type s -user "$USER" -name 'agent.*' 2>/dev/null | head -n 1)

    # Add the key if it's not already loaded
    ssh-add -l | grep "$1" &>/dev/null || ssh-add -q ~/.ssh/$1 &>/dev/null
}

# load_project_ssh_key() {
#     case "$1" in
#         "github")
#             start_ssh_agent "cristobal-clab-git_key"
#             ;;
#         "aws")
#             start_ssh_agent "project2_id_rsa"
#             ;;
#         # Add more projects and SSH keys as needed
#         *)
#             echo "Unknown project"
#             ;;
#     esac
# }

# Which plugins would you like to load?
plugins=(
        git
        zsh-autosuggestions
        docker
        sudo
        history
        web-search
        copyfile
        copybuffer
        dirhistory
)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
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
## Docker Alias
alias dcup='docker compose up -d'
alias dcdw='docker compose down'
alias dps='docker ps'
alias dstp='docker stop'
alias dkl='docker kill'
alias dexec='docker exec -it'
## Git Alias
alias gits='git status'
alias gita='git add'
alias gitc='git commit -m'
alias gitps='git push origin'
alias gitpl='git pull'
alias gitb='git br'
alias gitco='git co'
## Tmux Alias
alias tmn='tmux new -s'
alias tma='tmux attach -t'
alias tml='tmux ls'
alias tmk='tmux kill-session -t'
alias tmka='tmux kill-server'
alias tmr='tmux source-file ~/.tmux.conf'
alias tmaor='tmux attach -t $1 || tmux new -s $1'

# Tmux Plugin Manager (TPM) Integration
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins"

# Load TPM plugins automatically when tmux starts
if command -v tmux &>/dev/null && [[ -n "$TMUX" ]]; then
  [[ -s ~/.tmux/plugins/tpm/tpm ]] && source ~/.tmux/plugins/tpm/tpm
fi

# Launch lazyvim and yazi with shortcuts
alias nv='nvim'
alias yz='yazi'

# Reload zsh config
alias zr='source ~/.zshrc'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$HOME/.local/bin:$PATH"
