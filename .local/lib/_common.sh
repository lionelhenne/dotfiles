#!/bin/bash

# ==============================================================================
# COLORS
# ==============================================================================

if [[ -z "${MAGENTA:-}" ]]; then
    readonly WHITE=$'\033[38;2;232;237;255m'  # Primary text    — #E8EDFF  (Text  Macchiato +bright)
    readonly CYAN=$'\033[38;2;0;229;255m'     # Headers         — #00E5FF
    readonly BLUE=$'\033[38;2;68;136;255m'    # INFO            — #4488FF  (Blue  Macchiato +sat)
    readonly GREEN=$'\033[38;2;0;230;118m'    # DONE            — #00E676  (Green Macchiato +sat)
    readonly YELLOW=$'\033[38;2;255;196;0m'   # WARN            — #FFC400
    readonly ORANGE=$'\033[38;2;255;140;90m' # WARN text      — #FF8C5A  (Peach Macchiato +sat)
    readonly RED=$'\033[38;2;255;51;85m'      # FAIL            — #FF3355  (Red   Macchiato +sat)
    readonly MAGENTA=$'\033[38;2;255;82;194m' # CONF            — #FF52C2
    readonly SILVER=$'\033[38;2;160;170;204m' # Secondary text  — #A0AACC  (Subtext1 Macchiato)
    readonly GRAY=$'\033[38;2;106;115;148m'   # Dimmed text     — #6A7394  (Overlay2 Macchiato)
    readonly BLUE_LIGHT=$'\033[38;2;190;213;255m'   # INFO text        — lightened BLUE
    readonly GREEN_LIGHT=$'\033[38;2;166;246;207m'  # DONE text        — lightened GREEN
    readonly YELLOW_LIGHT=$'\033[38;2;255;234;166m' # WARN text        — lightened YELLOW
    readonly RED_LIGHT=$'\033[38;2;255;184;196m'    # FAIL text        — lightened RED
    readonly MAGENTA_LIGHT=$'${MAGENTA_LIGHT}' # USER text       — lightened MAGENTA
    readonly BOLD=$'\033[1m'                  # Bold
    readonly RESET=$'\033[0m'                 # Reset
fi

# ==============================================================================
# LOGGING
# ==============================================================================

log_header() {
    echo
    echo -e "${CYAN}${BOLD}▶︎ $1${RESET}"
    echo
}

log_info() {
    echo -e "${BLUE}${BOLD}● INFO${RESET}  ${BLUE_LIGHT}$*${RESET}"
}

log_success() {
    echo -e "${GREEN}${BOLD}● DONE${RESET}  ${GREEN_LIGHT}$*${RESET}"
}

log_warn() {
    echo -e "${YELLOW}${BOLD}● WARN${RESET}  ${YELLOW_LIGHT}$*${RESET}"
}

log_error() {
    echo -e "${RED}${BOLD}● FAIL${RESET}  ${RED_LIGHT}$*${RESET}"
    return 1
}

# ==============================================================================
# INTERACTION
# ==============================================================================
# Prompt pour input utilisateur
# Usage: prompt "Message" [variable_name]
prompt() {
    local message="$1"
    local var_name="$2"
    
    read -p "$(echo -e "${MAGENTA}${BOLD}● USER${RESET}  ${MAGENTA_LIGHT}${message}${RESET} ")" response
    
    if [[ -n "$var_name" ]]; then
        eval "$var_name='$response'"
    else
        echo "$response"
    fi
}

# Confirmation avec choix par défaut optionnel
# Usage: confirm "Question" [Y|N]
# confirm "Continue?"     → Pas de défaut
# confirm "Continue?" Y   → Défaut Yes
# confirm "Continue?" N   → Défaut No
confirm() {
    local prompt="$1"
    local default="${2:-}"
    local response
    local prompt_suffix
    
    # Déterminer le suffixe [y/n] ou [Y/n] ou [y/N]
    case "$default" in
        [Yy])
            prompt_suffix="(${MAGENTA}${BOLD}Y${RESET}/n)"
            ;;
        [Nn])
            prompt_suffix="(y/${MAGENTA}${BOLD}N${RESET})"
            ;;
        *)
            prompt_suffix="(y/n)"
            ;;
    esac
    
    while true; do
        read -p "$(echo -e "${MAGENTA}${BOLD}● USER${RESET}  ${MAGENTA_LIGHT}${prompt} ${prompt_suffix}:${RESET} ")" response
        
        # Si vide et défaut défini, utiliser le défaut
        if [[ -z "$response" && -n "$default" ]]; then
            response="$default"
        fi
        
        case "$response" in
            [Yy]*) return 0 ;;
            [Nn]*) return 1 ;;
            *) echo -e "      ${YELLOW}${BOLD}Please answer y or n${RESET}" ;;
        esac
    done
}
