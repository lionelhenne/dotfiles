#!/bin/bash

run() {
    log_header "Web Development Setup"
    
    # Create folders
    log_info "Creating project directories..."
    mkdir -p ~/Sites ~/Developer
    log_success "Directories created"

    # Install PHP, Composer, Laravel Valet
    log_info "Installing PHP and Composer..."
    if brew install php composer; then
        log_success "PHP and Composer installed"
    else
        log_error "Failed to install PHP or Composer"
    fi

    log_info "Installing Laravel Installer and Valet..."
    if composer global require laravel/installer laravel/valet; then
        log_success "Laravel tools installed"
    else
        log_error "Failed to install Laravel tools"
    fi
    
    # Add Composer global bin to PATH for this session
    export PATH="$HOME/.composer/vendor/bin:$PATH"

    log_info "Setting up Valet..."
    if valet install; then
        log_success "Valet installed"
    else
        log_error "Failed to install Valet"
    fi

    if valet trust; then
        log_success "Valet trusted"
    else
        log_warn "Valet trust failed (may need manual intervention)"
    fi

    log_info "Parking ~/Sites directory..."
    cd ~/Sites && valet park
    log_success "Sites directory parked"

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
    
    log_info "Launching PHP Monitor..."
    open -a "PHP Monitor"

    # Install Node.js via fnm
    log_info "Installing fnm..."
    if brew install fnm; then
        log_success "fnm installed"
    else
        log_error "Failed to install fnm"
    fi

    log_info "Installing Node.js LTS..."
    if fnm install --lts; then
        fnm use lts-latest
        log_success "Node.js LTS installed"
    else
        log_error "Failed to install Node.js"
    fi

    # Install MySQL and PostgreSQL
    log_info "Installing MySQL..."
    if brew install mysql; then
        log_success "MySQL installed"
    else
        log_error "Failed to install MySQL"
    fi

    # Configure MySQL
    log_info "Starting MySQL service..."
    brew services start mysql
    sleep 3

    log_info "Securing MySQL (root/root)..."
    if mysql -u root -e "
        ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
        DELETE FROM mysql.user WHERE User='';
        DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
        DROP DATABASE IF EXISTS test;
        FLUSH PRIVILEGES;
    " 2>/dev/null; then
        log_success "MySQL configured"
    else
        log_warn "MySQL configuration may have failed"
    fi

    # PostgreSQL (optional)
    echo
    if confirm "Install PostgreSQL?" N; then
        log_info "Installing PostgreSQL..."
        if brew install postgresql@18; then
            log_success "PostgreSQL installed"
        else
            log_error "Failed to install PostgreSQL"
        fi

        log_info "Starting PostgreSQL service..."
        brew link --force postgresql@18
        brew services start postgresql@18
        sleep 3

        log_info "Creating postgres user (postgres/postgres)..."
        if createuser -s postgres 2>/dev/null; then
            if psql postgres -c "ALTER USER postgres WITH PASSWORD 'postgres';" 2>/dev/null; then
                log_success "PostgreSQL configured"
            else
                log_warn "Failed to set PostgreSQL password"
            fi
        else
            log_warn "PostgreSQL user may already exist"
        fi
    else
        log_info "PostgreSQL installation skipped"
    fi

    echo
    log_success "Web development environment ready!"
}
