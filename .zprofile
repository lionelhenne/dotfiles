# ------------------------------------------------------------
# Paths
# ------------------------------------------------------------
directories=(
    "/usr/local/sbin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "$HOME/.local/bin"
    "$HOME/.config/composer/vendor/bin"
    "$HOME/.config/phpmon/bin"
    "$HOME/Developer/laravel-tool/bin"
    "$HOME/Developer/cockpit-tool/bin"
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
)

for dir in "${directories[@]}"; do
    [[ -d $dir ]] && export PATH="$dir:$PATH"
done

# ------------------------------------------------------------
# fnm
# ------------------------------------------------------------
if command -v fnm >/dev/null 2>&1; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi

# ------------------------------------------------------------
# Starship
# ------------------------------------------------------------
[[ "$TERM_PROGRAM" == "ghostty" || "$TERM_PROGRAM" == "vscode" ]] && export STARSHIP_CONFIG="$HOME/.config/starship/config.toml"

# ------------------------------------------------------------
# eza
# ------------------------------------------------------------
[[ -d $HOME/.config/eza ]] && export EZA_CONFIG_DIR="$HOME/.config/eza"


# ------------------------------------------------------------
# Atuin
# ------------------------------------------------------------
[[ -d $HOME/.config/atuin ]] && export ATUIN_CONFIG_DIR="$HOME/.dotfiles/.config/atuin"
