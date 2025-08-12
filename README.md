# macOS Dotfiles

My personal macOS development environment configuration files, managed with GNU Stow.

Part of my broader setup: [macOS Development Setup](https://github.com/lionelhenne/macossetup).

## 🛠 Environment

### System
- **OS**: macOS
- **Shell**: zsh with customizations
- **Package Manager**: [Homebrew](https://brew.sh/)
- **Dotfiles Manager**: [GNU Stow](https://www.gnu.org/software/stow/)

### Development Tools
- **Terminal**: [Ghostty](https://ghostty.org/) with Catppuccin Macchiato theme
- **Editor**: [VSCode](https://code.visualstudio.com/) with Catppuccin Macchiato theme
- **Font**: JetBrainsMono Nerd Font

## 📦 Configured Tools

### Shell & Prompt
- **[Starship](https://starship.rs/)** - Cross-shell prompt with custom Pastel Powerline theme
- **[Atuin](https://atuin.sh/)** - Magical shell history with sync capabilities
- **zsh-autosuggestions** - Command suggestions based on history
- **zsh-syntax-highlighting** - Fish shell-like syntax highlighting

### File Management
- **[eza](https://eza.rocks/)** - Modern replacement for `ls` with custom OneDark-inspired theme
- **[fd](https://github.com/sharkdp/fd)** - Fast and user-friendly alternative to `find`

### Node.js
- **[fnm](https://github.com/Schniz/fnm)** - Fast Node.js version manager

### Git Configuration
- **Signing**: SSH key signing with 1Password integration
- **Editor**: VSCode as default editor
- **User**: Lionel Henné <lionelhenne@gmail.com>

## 🎨 Theme & Aesthetics

All tools are configured with a consistent **Catppuccin Macchiato** color scheme:
- Terminal (Ghostty)
- Code editor (VSCode)
- File listing (eza custom theme)
- Shell prompt (Starship custom colors)

## 📁 Structure

```
.
├── .config/
│   ├── atuin/          # Shell history configuration
│   ├── eza/            # File listing theme
│   ├── ghostty/        # Terminal configuration
│   └── starship/       # Shell prompt configuration
├── .gitconfig          # Git global configuration
├── .gitignore          # Global gitignore
├── .zaliases           # Shell aliases
├── .zprofile           # Zsh profile (paths & exports)
├── .zshrc              # Zsh configuration
└── .stow-global-ignore # Stow ignore patterns
```

## 🚀 Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/lionelhenne/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Install dependencies** (see [macOS Development Setup](https://github.com/lionelhenne/macossetup)):
   ```bash
   # Install Homebrew and required packages
   # Follow the setup guide for complete installation
   ```

3. **Deploy configurations with Stow**:
   ```bash
   stow .
   ```

4. **Reload shell**:
   ```bash
   source ~/.zshrc
   ```

## 🔧 Key Features

### Aliases
- **File operations**: `l`, `li`, `lt`, `lti` for enhanced directory listings
- **Navigation**: `..` for parent directory, `home` for quick home + clear
- **System**: `flushcache` for DNS cache refresh
- **Package management**: `update`, `upgrade`, `list` for comprehensive system updates

### Shell History
- **Atuin integration**: Synced shell history across devices
- **Search**: Fuzzy search through command history
- **Privacy**: Automatic filtering of secrets and sensitive data

### Development Workflow
- **Laravel Valet** ready paths
- **Composer** global packages in PATH
- **fnm** for Node.js version management
- **VSCode** CLI integration

## 🎯 Philosophy

These dotfiles prioritize:
- **Consistency** - Unified color scheme and UX across tools
- **Performance** - Fast modern alternatives (eza, fd, fnm, atuin)
- **Developer Experience** - Streamlined workflows for web development
- **Security** - Git signing with 1Password, secret filtering

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.