# ------------------------------------------------------------
# Paths
# ------------------------------------------------------------
directories=(
    "/usr/local/sbin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "$HOME/.composer/vendor/bin"
    "$HOME/.config/phpmon/bin"
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    "/Applications/PhpStorm.app/Contents/MacOS"
)

for dir in "${directories[@]}"; do
    [[ -d $dir ]] && export PATH="$dir:$PATH"
done

# ------------------------------------------------------------
# nvm
# ------------------------------------------------------------
[[ -d $HOME/.nvm ]] && export NVM_DIR="$HOME/.nvm"
[[ -s /opt/homebrew/opt/nvm/nvm.sh ]] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[[ -s /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm ]] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

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
