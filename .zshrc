# Dependencies installed by Ansible
export ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"

_missing_deps=()
[[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]] && _missing_deps+=(powerlevel10k)
[[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]] && _missing_deps+=(zsh-autosuggestions)
[[ ! -d "$ZSH_CUSTOM/plugins/F-Sy-H" ]] && _missing_deps+=(F-Sy-H)
if (( ${#_missing_deps[@]} )); then
  echo "\033[1;31mError: Missing zsh dependencies: ${_missing_deps[*]}\033[0m"
  echo "\033[1;33mPlease run the Ansible installer: ansible-playbook install_dotfiles.yml\033[0m"
  unset _missing_deps
  return 1
fi
unset _missing_deps

# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  kubectl
  helm
)

# Load platform-specific plugins before syntax highlighting.
if [[ "$OSTYPE" == darwin* ]]; then
  plugins+=(brew)
fi
plugins+=(zsh-autosuggestions F-Sy-H)

source "$ZSH/oh-my-zsh.sh"

# Optional integrations
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"
[[ -f "$HOME/.openclaw/completions/openclaw.zsh" ]] && source "$HOME/.openclaw/completions/openclaw.zsh"

# Command paths (the -U flag removes duplicates).
typeset -U path PATH
[[ -d "$HOME/.toolbox/bin" ]] && path=("$HOME/.toolbox/bin" $path)
[[ -d "$HOME/.aim/mcp-servers" ]] && path=("$HOME/.aim/mcp-servers" $path)
path=("$HOME/bin" $path)

# Disable Kiro's native cmux integration; kiro-cmux provides its own.
export KIRO_NO_CMUX=1
