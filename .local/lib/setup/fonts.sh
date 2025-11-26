#!/bin/bash
# fonts.sh
# Fonts Installation

run() {
    log_header "Fonts Setup"
    
    local alegreya="font-alegreya font-alegreya-sans font-alegreya-sans-sc font-alegreya-sc"
    local biorhyme="font-biorhyme font-biorhyme-expanded"
    local crimson="font-crimson-pro font-crimson-text"
    local google="font-google-sans-code"
    local inter="font-inter font-inter-tight"
    local jetbrains="font-jetbrains-mono font-jetbrains-mono-nerd-font"
    local libre="font-libre-baskerville font-libre-bodoni font-libre-caslon-display font-libre-caslon-text font-libre-franklin"
    local merriweather="font-merriweather font-merriweather-sans"
    local montserrat="font-montserrat font-montserrat-alternates font-montserrat-underline"
    local noto="font-noto-color-emoji font-noto-emoji font-noto-sans font-noto-sans-display font-noto-sans-jp font-noto-sans-mono font-noto-sans-symbols font-noto-serif font-noto-serif-display font-noto-serif-hentaigana font-noto-serif-jp"
    local nunito="font-nunito font-nunito-sans"
    local playfair="font-playfair font-playfair-display font-playfair-display-sc"
    local raleway="font-raleway font-raleway-dots"
    local roboto="font-roboto font-roboto-condensed font-roboto-flex font-roboto-mono font-roboto-serif font-roboto-slab"
    local vollkorn="font-vollkorn font-vollkorn-sc"
    local standalone="font-alfa-slab-one font-atkinson-hyperlegible-next font-bree-serif font-cascadia-code font-gilbert font-lato font-licorice font-lora font-monaspace font-open-sans font-outfit font-questrial font-redacted-script font-unica-one font-yeseva-one"
    
    local fonts="$alegreya $biorhyme $crimson $google $inter $jetbrains $libre $merriweather $montserrat $noto $nunito $playfair $raleway $roboto $vollkorn $standalone"
    
    log_info "Installing fonts (this may take a few minutes)..."
    
    if brew install --cask $fonts 2>/dev/null; then
        echo
        log_success "All fonts installed"
    else
        echo
        log_warn "Some fonts may have failed or were already installed"
    fi
    
    echo
    log_success "Fonts setup completed!"
}