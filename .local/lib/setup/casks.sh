run() {
    log_header "Applications Setup"
    
    echo "1) Personal Mac"
    echo "2) Work Mac"
    echo "0) Cancel"
    echo
    
    read -p "$(echo -e "${MAGENTA}${BOLD}USER${RESET}  ${SILVER}Select profile (0-2):${RESET} ")" choice
    
    case "$choice" in
        1)
            local config_file="$HOME/.local/lib/setup/casks-personal.sh"
            ;;
        2)
            local config_file="$HOME/.local/lib/setup/casks-pro.sh"
            ;;
        0)
            log_info "Installation cancelled"
            return 0
            ;;
        *)
            log_error "Invalid choice: $choice"
            ;;
    esac
    
    if [[ ! -f "$config_file" ]]; then
        log_error "Config not found: $config_file"
    fi
    
    log_info "Loading applications list..."
    source "$config_file"
    
    log_info "Installing applications (this may take a few minutes)..."
    
    if brew install --cask $CASKS 2>/dev/null; then
        echo
        log_success "All applications installed"
    else
        echo
        log_warn "Some applications may have failed or were already installed"
    fi
    
    echo
    log_success "Applications setup completed!"
}