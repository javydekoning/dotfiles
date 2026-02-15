# Verify dependencies installed by Ansible
_missing_deps=()
[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ] && _missing_deps+=(powerlevel10k)
[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ] && _missing_deps+=(zsh-autosuggestions)
[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/F-Sy-H" ] && _missing_deps+=(F-Sy-H)
if (( ${#_missing_deps[@]} )); then
  echo "\033[1;31mError: Missing zsh dependencies: ${_missing_deps[*]}\033[0m"
  echo "\033[1;33mPlease run the Ansible installer: ansible-playbook install_dotfiles.yml\033[0m"
  unset _missing_deps
  return 1
fi
unset _missing_deps

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS="true"

# Plugins to use.
plugins=(
  git
  kubectl
  helm
  zsh-autosuggestions
  F-Sy-H
)

# Load brew plugin only on macOS
if [[ "$(uname -s)" == "Darwin" ]]; then
  plugins+=(brew)
fi

source $ZSH/oh-my-zsh.sh

# Kubectl completion
autoload -U compinit
compinit

if command -v kubectl &>/dev/null; then
  source <(kubectl completion zsh)
fi

# Source custom aliases
if [ -f "${ZSH_CUSTOM}/aliases.zsh" ]; then
  source "${ZSH_CUSTOM}/aliases.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable fzf (multi-path: Homebrew/manual install, Linux package manager, etc.)
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
elif [ -f /usr/share/fzf/key-bindings.zsh ]; then
  source /usr/share/fzf/key-bindings.zsh
  [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
elif [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
fi
