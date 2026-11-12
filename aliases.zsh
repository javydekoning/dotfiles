# Aliases

# Git aliases
alias gitconfig='
    git config --global user.email "javydekoning+github@gmail.com" &&
    git config --global user.name "javydekoning" &&
    git config --global core.autocrlf false
'
alias gs='git status'
alias gcam='git commit -am'
alias omzupdate='cd ~/.oh-my-zsh && git reset --hard HEAD && omz update && cd -'

if command -v kubecolor >/dev/null 2>&1; then
  alias kubectl=kubecolor
  alias k=kubecolor
  compdef kubecolor=kubectl
else
  alias kubectl=kubectl
  alias k=kubectl
fi

# Dev aliases
alias tf='tofu'
alias runlinter='npx mega-linter-runner --fix'
alias cdkd='cdk deploy --require-approval never --path-metadata false'

# Cross-platform aliases
alias grep='grep --color=auto'
alias untar='tar -zxvf '
alias wget='wget -c '

# Platform-specific aliases
case "$(uname -s)" in
  Linux)
    alias shutdown=poweroff
    alias dir='dir --color=auto'
    alias egrep='grep -E --color=auto'
    alias fgrep='grep -F --color=auto'
    if command -v hwinfo &>/dev/null; then
      alias hw='hwinfo --short'
    fi
    if command -v pacman &>/dev/null; then
      alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
      alias update='sudo pacman -Syu'
      alias fixpacman='sudo rm /var/lib/pacman/db.lck'
    elif command -v apt-get &>/dev/null; then
      alias update='sudo apt update && sudo apt upgrade'
      alias cleanup='sudo apt autoremove'
    fi
    ;;
  Darwin)
    ytmp3() { cd ~/Music && yt-dlp --extract-audio --audio-format mp3 "$1" && cd -; }
    alias shutdown='sudo shutdown -h now'
    # Function, not alias: oh-my-zsh sources this file before .zshrc adds
    # ~/.toolbox/bin and ~/.aim/mcp-servers to PATH, so check at run time.
    # `function` keyword stops an existing alias from expanding on re-source.
    unalias update 2>/dev/null
    function update {
      brew update && brew outdated && brew upgrade --greedy && brew cleanup
      if command -v toolbox &>/dev/null; then
        toolbox update
      fi
      if command -v aim &>/dev/null; then
        aim mcp update
      fi
    }
    alias cleanup='brew cleanup'
    alias egrep='grep -E --color=auto'
    alias fgrep='grep -F --color=auto'
    ;;
esac
