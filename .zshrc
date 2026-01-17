# ------------------------------------------------------------
# Environment Variables
# ------------------------------------------------------------
export VISUAL="code --wait"
export EDITOR="code --wait"

# ------------------------------------------------------------
# Starship
# ------------------------------------------------------------
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# ------------------------------------------------------------
# Case-insensitive autocompletion
# ------------------------------------------------------------
autoload -U compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} m:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
compinit

# ------------------------------------------------------------
# zsh: zsh-autosuggestions.zsh
# ------------------------------------------------------------
[[ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# ------------------------------------------------------------
# zsh: zsh-syntax-highlighting
# ------------------------------------------------------------
[[ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# ------------------------------------------------------------
# zsh: edit-command-line
# ------------------------------------------------------------
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line
zstyle :zle:edit-command-line editor micro

# ------------------------------------------------------------
# Atuin
# ------------------------------------------------------------
if command -v atuin &> /dev/null; then
    unset HISTFILE
    HISTSIZE=0
    SAVEHIST=0
    eval "$(atuin init zsh)"
fi

# ------------------------------------------------------------
# node (warnings)
# ------------------------------------------------------------
# export NODE_OPTIONS="--no-warnings --experimental-modules"

# ------------------------------------------------------------
# Aliases
# ------------------------------------------------------------
[[ -f "$HOME/.zaliases" ]] && source "$HOME/.zaliases"