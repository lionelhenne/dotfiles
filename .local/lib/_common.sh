#!/bin/bash

# ==============================================================================
# COLORS
# ==============================================================================

if [[ -z "${MAGENTA:-}" ]]; then
    readonly WHITE=$'\033[38;5;255m'    # Primary text
    readonly CYAN=$'\033[38;5;51m'      # Headers
    readonly BLUE=$'\033[38;5;33m'      # INFO
    readonly GREEN=$'\033[38;5;42m'     # DONE
    readonly YELLOW=$'\033[38;5;214m'   # WARN
    readonly LIGHTRED=$'\033[38;5;203m' # WARN text
    readonly RED=$'\033[38;5;196m'      # FAIL
    readonly MAGENTA=$'\033[38;5;212m'  # CONF
    readonly SILVER=$'\033[38;5;250m'   # Secondary text
    readonly GRAY=$'\033[38;5;240m'     # Dimmed text
    readonly BOLD=$'\033[1m'            # Bold
    readonly RESET=$'\033[0m'           # Reset
fi

# ==============================================================================
# LOGGING
# ==============================================================================

log_header() {
    echo
    echo -e "${CYAN}=== $1 ===${RESET}"
    echo
}

log_info() {
    echo -e "${BLUE}${BOLD}INFO${RESET}  ${SILVER}$*${RESET}"
}

log_success() {
    echo -e "${GREEN}${BOLD}DONE${RESET}  ${SILVER}$*${RESET}"
}

log_warn() {
    echo -e "${YELLOW}${BOLD}WARN${RESET}  ${SILVER}$*${RESET}"
}

log_error() {
    echo -e "${RED}${BOLD}FAIL${RESET}  ${LIGHTRED}$*${RESET}"
    exit 1
}

# ==============================================================================
# INTERACTION
# ==============================================================================
# Prompt pour input utilisateur
# Usage: prompt "Message" [variable_name]
prompt() {
    local message="$1"
    local var_name="$2"
    
    read -p "$(echo -e "${MAGENTA}${BOLD}USER${RESET}  ${WHITE}${message}${RESET} ")" response
    
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
        read -p "$(echo -e "${MAGENTA}${BOLD}USER${RESET}  ${SILVER}${prompt} ${prompt_suffix}:${RESET} ")" response
        
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
