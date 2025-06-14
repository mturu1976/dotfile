# 🏠 Dotfiles

Modern, modular dotfiles configuration for macOS with zsh, tmux, and starship.

## ✨ Features

- **🐚 Zsh**: Modern shell with syntax highlighting, autosuggestions, and completions
- **🖥️ Tmux**: Terminal multiplexer with Catppuccin theme and useful plugins
- **🚀 Starship**: Fast, customizable prompt with Pastel Powerline preset
- **🔍 FZF**: Fuzzy finder integration for enhanced productivity
- **📁 Modular**: Clean, organized configuration split into logical modules

## 🚀 Quick Start

### Automated Installation (Recommended)

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfile.git ~/dotfile
cd ~/dotfile

# Check dependencies
./check-deps.sh

# Install missing dependencies
brew bundle

# Install dotfiles
./install.sh
```

### Manual Installation

```bash
# Create directories
mkdir -p ~/.zshrc.d ~/.config

# Create symlinks
ln -sf ~/dotfile/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfile/zsh/config/alias.zsh ~/.zshrc.d/alias.zsh
ln -sf ~/dotfile/zsh/config/env-init.zsh ~/.zshrc.d/env-init.zsh
ln -sf ~/dotfile/zsh/config/completion.zsh ~/.zshrc.d/completion.zsh
ln -sf ~/dotfile/zsh/config/other.zsh ~/.zshrc.d/other.zsh
ln -sf ~/dotfile/zsh/config/poetry.zsh ~/.zshrc.d/poetry.zsh
ln -sf ~/dotfile/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfile/starship/starship.toml ~/.config/starship.toml

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## 📁 Structure

```
~/dotfile/
├── zsh/
│   ├── .zshrc              # Main zsh configuration
│   └── config/
│       ├── alias.zsh       # Aliases and functions
│       ├── env-init.zsh    # Environment variables
│       ├── completion.zsh  # Completion settings
│       ├── other.zsh       # Other configurations
│       └── poetry.zsh      # Poetry configuration
├── starship/
│   └── starship.toml       # Starship prompt configuration
├── .tmux.conf              # Tmux configuration
├── Brewfile                # Homebrew dependencies
├── install.sh              # Automated installation script
└── check-deps.sh           # Dependency checker
```

## 🛠️ Key Tools & Aliases

### Aliases
- `ls` → `eza` with icons and git status
- `cd` → `z` (zoxide for smart directory jumping)
- `vim` → `nvim`

### Functions
- `fgc` - Interactive git branch checkout with fzf
- `flog` - Interactive git log browser
- `fcd` - Interactive directory navigation
- `fadd` - Interactive git add with diff preview

### Tmux Shortcuts
- Prefix: `Ctrl-j`
- Split panes: `|` (horizontal), `-` (vertical)
- Navigate panes: `h/j/k/l`
- Resize panes: `H/J/K/L`

## 🎨 Themes

- **Tmux**: Catppuccin theme
- **Starship**: Pastel Powerline preset
- **Terminal**: Optimized for Nerd Fonts

## 🔧 Customization

Each configuration module can be customized independently:

- **Aliases**: Edit `zsh/config/alias.zsh`
- **Environment**: Edit `zsh/config/env-init.zsh`
- **Prompt**: Edit `starship/starship.toml`
- **Tmux**: Edit `.tmux.conf`

## 📦 Dependencies

Run `./check-deps.sh` to verify all dependencies are installed.

### Required
- zsh, tmux, starship, fzf, eza, zoxide, direnv, git, neovim, bat

### Optional
- thefuck, hstr, timer, terminal-notifier

## 🤝 Contributing

Feel free to fork and customize for your own needs!

```zsh
# .zshrc.dを作成
mkdir -p ~/.zshrc.d

#シンボリックリンク
ln -s ~/dotfile/zsh/alias/alias-init.zsh ~/.zshrc.d/alias-init.zsh
ln -s ~/dotfile/zsh/env/env-init.zsh ~/.zshrc.d/env-init.zsh
ln -s ~/dotfile/zsh/completion/completion-init.zsh ~/.zshrc.d/completion-init.zsh


# StartShip設定
#mkdir /Users/$USERNAME/.config/starship/
#ln -s /Users/$USERNAME/dotfile/starship/starship.toml /Users/$USERNAME/.config/starship/starship.toml

```
