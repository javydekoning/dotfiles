# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/github/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Add the following line to your ~/.zshrc, before you source oh-my-zsh.sh:
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
plugins=(
  git
  brew
  kubectl
  helm
  zsh-autosuggestions
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
