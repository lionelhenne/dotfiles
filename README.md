# macOS Dotfiles

My personal macOS configuration files and setup tools.

Bootstrap via: [macOS Setup](https://github.com/lionelhenne/macossetup)

## Installation

1. **Bootstrap your Mac** (first time setup):
```bash
   curl -fsSL https://raw.githubusercontent.com/lionelhenne/macossetup/main/setup.sh | /bin/bash
```

2. **Dotfiles are automatically applied** via GNU Stow during bootstrap

## Post-Installation Setup

After bootstrap, restart your terminal and use the setup tool:
```bash
@setup              # Interactive menu
@setup webdev       # Direct module execution
```

### Available Modules

- **webdev** – PHP, Composer, Valet, Node.js, databases
- **identity** – Git & SSH configuration via 1Password
- **casks** – GUI applications with profile selection
- **fonts** – Font collection

## Additional Tools

- **laravel-tool** – Laravel project setup and cache management (usage: `@laravel`)
- **cockpit-tool** – Cockpit CMS installation and updates (usage: `@cockpit`)
- **backup-tool** – Application configuration backup/restore (usage: `@backup`)

## Key Features

- 256 color palette for consistent UI
- Idempotent scripts – safe to re-run
- 1Password integration for secrets
- Profile-based configurations

## License

MIT License - see [LICENSE](LICENSE) file for details.