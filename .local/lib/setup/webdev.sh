#!/bin/bash
# webdev.sh
# Web Development Environment Setup

run() {
    log_header "Web Development Setup"
    
    # Create folders
    log_info "Creating project directories..."
    mkdir -p ~/Sites ~/Developer
    log_success "Directories created"

    # Install PHP, Composer, Laravel Valet
    if command -v php >/dev/null 2>&1; then
        log_warn "PHP already installed"
    else
        log_info "Installing PHP..."
        if brew install php; then
            log_success "PHP installed"
        else
            log_error "Failed to install PHP"
        fi
    fi

    if command -v composer >/dev/null 2>&1; then
        log_warn "Composer already installed"
    else
        log_info "Installing Composer..."
        if brew install composer; then
            log_success "Composer installed"
        else
            log_error "Failed to install Composer"
        fi
    fi

    # Install Laravel Installer and Valet
    log_info "Installing Laravel Installer and Valet..."
    if composer global require laravel/installer laravel/valet >/dev/null 2>&1; then
        log_success "Laravel tools installed"
    else
        log_error "Failed to install Laravel tools"
    fi
    
    # Add Composer global bin to PATH for this session
    export PATH="$HOME/.composer/vendor/bin:$PATH"
    
    # Debug: verify valet is available
    if ! command -v valet >/dev/null 2>&1; then
        log_error "Valet not found in PATH. Please check: ls -la $HOME/.composer/vendor/bin/"
    fi

    # Check if Valet is configured
    if valet --version >/dev/null 2>&1 && [[ -f "$HOME/.config/valet/dnsmasq.d/tld-test.conf" ]]; then
        log_warn "Valet already configured"
    else
        log_info "Setting up Valet..."
        
        # Call valet directly with full path as fallback
        local valet_cmd="valet"
        if ! command -v valet >/dev/null 2>&1; then
            valet_cmd="$HOME/.composer/vendor/bin/valet"
        fi
        
        if $valet_cmd install; then
            log_success "Valet installed"
        else
            log_error "Failed to install Valet"
        fi

        if $valet_cmd trust; then
            log_success "Valet trusted"
        else
            log_warn "Valet trust failed (may need manual intervention)"
        fi
    fi

    if valet paths | grep -q "$HOME/Sites"; then
        log_warn "Sites directory already parked"
    else
        log_info "Parking ~/Sites directory..."
        cd ~/Sites && valet park
        log_success "Sites directory parked"
    fi

    # Install PHP Monitor
    if [ -d "/Applications/PHP Monitor.app" ]; then
        log_warn "PHP Monitor already installed"
    else
        log_info "Downloading PHP Monitor..."
        local phpmon_url="https://github.com/nicoverbruggen/phpmon/releases/download/v7.1/phpmon.zip"
        local phpmon_zip="/tmp/phpmon.zip"
        
        if curl -fsSL -o "$phpmon_zip" "$phpmon_url"; then
            if unzip -tq "$phpmon_zip" &>/dev/null; then
                unzip -q "$phpmon_zip" -d "/Applications"
                rm -f "$phpmon_zip"
                log_success "PHP Monitor installed"
            else
                rm -f "$phpmon_zip"
                log_error "PHP Monitor zip is corrupted"
            fi
        else
            log_error "Failed to download PHP Monitor"
        fi
    fi
    
    if [ -d "/Applications/PHP Monitor.app" ]; then
        log_info "Launching PHP Monitor..."
        open -a "PHP Monitor" 2>/dev/null || log_warn "Failed to launch PHP Monitor (launch manually)"
    fi

    # Install Node.js via fnm
    if command -v fnm >/dev/null 2>&1; then
        log_warn "fnm already installed"
    else
        log_info "Installing fnm..."
        if brew install fnm; then
            log_success "fnm installed"
        else
            log_error "Failed to install fnm"
        fi
    fi
    
    # Load fnm in current shell
    eval "$(fnm env --use-on-cd --shell bash)"

    if fnm list | grep -q "lts"; then
        log_warn "Node.js LTS already installed"
    else
        log_info "Installing Node.js LTS..."
        if fnm install --lts; then
            fnm use lts-latest
            log_success "Node.js LTS installed"
        else
            log_error "Failed to install Node.js"
        fi
    fi

    # Install MySQL
    if brew list mysql &>/dev/null; then
        log_warn "MySQL already installed"
    else
        log_info "Installing MySQL..."
        if brew install mysql; then
            log_success "MySQL installed"
        else
            log_error "Failed to install MySQL"
        fi
    fi

    # Configure MySQL
    if brew services list | grep -q "mysql.*started"; then
        log_warn "MySQL service already running"
    else
        log_info "Starting MySQL service..."
        brew services start mysql
        sleep 3
    fi

    log_info "Configuring MySQL (root/root)..."
    
    # Check if already configured with password 'root'
    if mysql -u root -proot -e "SELECT 1" >/dev/null 2>&1; then
        log_success "MySQL already configured with root/root"
    else
        # Not configured with 'root', so configure it (works with empty password on fresh install)
        log_info "Setting MySQL root password to 'root'..."
        if mysql -u root <<EOF >/dev/null 2>&1
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
EOF
        then
            log_success "MySQL configured with root/root"
        else
            log_warn "MySQL configuration failed (may already have a different password)"
        fi
    fi

    # PostgreSQL (optional)
    echo
    if confirm "Install PostgreSQL?" N; then
        if brew list postgresql@18 &>/dev/null; then
            log_warn "PostgreSQL already installed"
        else
            log_info "Installing PostgreSQL..."
            if brew install postgresql@18; then
                log_success "PostgreSQL installed"
            else
                log_error "Failed to install PostgreSQL"
            fi
        fi

        if brew services list | grep -q "postgresql@18.*started"; then
            log_warn "PostgreSQL service already running"
        else
            log_info "Starting PostgreSQL service..."
            brew link --force postgresql@18
            brew services start postgresql@18
            sleep 3
        fi

        log_info "Creating postgres user (postgres/postgres)..."
        if psql postgres -c "SELECT 1" -U postgres >/dev/null 2>&1; then
            log_warn "PostgreSQL already configured"
        else
            if createuser -s postgres 2>/dev/null; then
                if psql postgres -c "ALTER USER postgres WITH PASSWORD 'postgres';" 2>/dev/null; then
                    log_success "PostgreSQL configured"
                else
                    log_warn "Failed to set PostgreSQL password"
                fi
            else
                log_warn "PostgreSQL user may already exist"
            fi
        fi
    else
        log_info "PostgreSQL installation skipped"
    fi

    echo
    log_success "Web development environment ready!"
}
