# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dracula"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  brew
  kubectl
  helm
)

source $ZSH/oh-my-zsh.sh

source <(kubectl completion zsh)

fpath=($fpath ~/.zsh/completion)

# Set architecture-specific brew share path.
arch_name="$(uname -m)"
if [ "${arch_name}" = "x86_64" ]; then
    share_path="/usr/local/share"
elif [ "${arch_name}" = "arm64" ]; then
    share_path="/opt/homebrew/share"
else
    echo "Unknown architecture: ${arch_name}"
fi

# Git aliases.
alias gs='git status'
alias gcam='git commit -am'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Kubernetes aliases
alias k=kubecolor
alias kubectl=kubecolor
alias k=kubecolor
alias kgp='kubectl get pods --sort-by=.metadata.creationTimestamp -A'

# Other aliases
alias ytdlp='docker run --rm -v "$(pwd)":/downloads jauderho/yt-dlp:latest'
alias fixteams='rm -r ~/Library/Application\ Support/Microsoft/Teams'
alias chl='ssh root@192.168.1.2'

# Completions.
# autoload bashcompinit && bashcompinit
# autoload -Uz compinit && compinit
complete -C 'aws_completer' aws
compdef kubecolor=kubectl

export PATH=$PATH:$(go env GOPATH)/bin
