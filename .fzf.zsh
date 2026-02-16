# fzf key bindings (Ctrl+R history, Ctrl+T file, Esc+C cd) and completion
# Symlinked from dotfiles; sources from platform-specific fzf install path.

if [[ -f "$(brew --prefix 2>/dev/null)/opt/fzf/shell/key-bindings.zsh" ]]; then
  source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
  [[ -f "$(brew --prefix)/opt/fzf/shell/completion.zsh" ]] && source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
elif [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
  [[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
elif [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  [[ -f /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh
fi

# Cd-into-directory: use Esc then c (fzf default \ec is this sequence)
bindkey -M emacs '\ec' fzf-cd-widget
bindkey -M vicmd '\ec' fzf-cd-widget
bindkey -M viins '\ec' fzf-cd-widget
