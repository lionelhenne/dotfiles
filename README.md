# macOS Dotfiles

My personal macOS configuration files and setup tools.

Bootstrap via: [macOS Setup](https://github.com/lionelhenne/macossetup)

## Installation

1. **Bootstrap** (first time setup):
```bash
   curl -fsSL https://raw.githubusercontent.com/lionelhenne/macossetup/main/setup.sh | /bin/bash
```

2. **Dotfiles are automatically applied** via GNU Stow during bootstrap

## Available Tools

- **setup-tool** (usage: `@setup`) – Post-installation modules (identity, webdev, casks, fonts)
- **laravel-tool** (usage: `@laravel`) – Laravel project setup and cache management 
- **cockpit-tool** (usage: `@cockpit`) – Cockpit CMS installation and updates 
- **backup-tool** (usage: `@backup`) – Application configuration backup/restore 

## License

MIT License - see [LICENSE](LICENSE) file for details.