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



#start_ssh_agent() {
#    if ! ssh-add -l &>/dev/null; then
#        eval $(ssh-agent -s)
#    fi
#    ssh-add ~/.ssh/$1
#}

#load_project_ssh_key() {
#    case "$1" in
#        "github")
#            start_ssh_agent "cristobal-clab-git_key"
#            ;;
#        "aws")
#            start_ssh_agent "project2_id_rsa"
#            ;;
        # Add more projects and SSH keys as needed
#        *)
#            echo "Unknown project"
#            ;;
#    esac
#}

# Which plugins would you like to load?
plugins=(
        git
        zsh-autosuggestions
	zsh-syntax-highlighting
        docker
        sudo
        history
        web-search
        copyfile
        copybuffer
        dirhistory
	zsh-interactive-cd
)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

source $ZSH/oh-my-zsh.sh

########################
# ALIASES
########################
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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/cristobal/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/cristobal/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/cristobal/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/cristobal/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/.dotfiles/zsh/.p10k.zsh ]] || source ~/.dotfiles/zsh/.p10k.zsh

# Created by `pipx` on 2025-04-07 05:58:28
export PATH="$PATH:/home/cristobal/.local/bin"
