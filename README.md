# 🏠 Dotfiles

Modern, modular dotfiles configuration for macOS with zsh, tmux, and starship.

## ✨ Features

- **🐚 Zsh**: Modern shell with syntax highlighting, autosuggestions, and completions
- **🖥️ Tmux**: Terminal multiplexer with Gruvbox theme and performance-optimized plugins
- **🚀 Oh My Posh**: Fast, customizable prompt with Microverse Power theme
- **🔍 FZF**: Fuzzy finder integration for enhanced productivity
- **📁 Modular**: Clean, organized configuration split into logical modules
- **⚡ Performance**: Optimized for fast tmux window/pane creation with lazy loading

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
├── .config/
│   └── oh-my-posh/
│       └── themes/         # Oh My Posh themes
├── .tmux.conf              # Tmux configuration
├── .tmux-minimal.conf      # Minimal tmux config for troubleshooting
├── .tmux-cheatsheet.md     # Tmux keybindings reference
├── .zshrc.minimal          # Minimal zsh config for fast startup
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

## 🖥️ Tmux Configuration

### Theme
- **Gruvbox Dark**: Warm, retro-groove color scheme with 256-color support

### Key Bindings
| Key | Description |
|-----|-------------|
| **Prefix Key** | `Ctrl+j` |

#### Window & Pane Management
| Key | Description |
|-----|-------------|
| `prefix + c` | New window (current directory) |
| `prefix + \|` | Split pane vertically |
| `prefix + -` | Split pane horizontally |
| `prefix + z` | Zoom/unzoom pane |
| `prefix + !` | Move pane to new window |
| `prefix + {/}` | Swap panes |
| `prefix + </>` | Swap windows |

#### Navigation
| Key | Description |
|-----|-------------|
| `prefix + h/j/k/l` | Navigate panes |
| `prefix + H/J/K/L` | Resize panes (large) |
| `prefix + M-h/j/k/l` | Resize panes (small) |
| `Alt + h/j/k/l` | Vim/tmux seamless navigation |
| `prefix + 1-9` | Jump to pane number |
| `Alt + 1-9` | Direct pane jump (requires iTerm2 config) |
| `prefix + q` | Display pane numbers |
| `prefix + s` | Display panes with selection prompt |
| `prefix + o` | SessionX (advanced session management) |

#### Popup Windows
| Key | Description |
|-----|-------------|
| `prefix + p` | Floating terminal |
| `prefix + g` | Git viewer (tig) |
| `prefix + G` | Git status & log |
| `prefix + C` | Claude Code (popup) |
| `prefix + N` | Quick notes |
| `prefix + T` | Temporary terminal |

#### Advanced Features
| Key | Description |
|-----|-------------|
| `prefix + S` | Synchronize panes ON/OFF |
| `prefix + P` | Save pane history |
| `prefix + v` | Paste from clipboard |
| `prefix + R` | Re-run last command |
| `prefix + m` | Toggle mouse mode |
| `prefix + r` | Reload config |
| `prefix + F1` | Show cheatsheet |

#### Copy Mode (Emacs bindings)
| Key | Description |
|-----|-------------|
| `prefix + [` | Enter copy mode |
| `M-w` | Copy selection |
| `C-w` | Copy selection |
| `Enter` | Copy selection |
| `Escape` | Exit copy mode |

#### Session & Restoration
| Key | Description |
|-----|-------------|
| `prefix + Ctrl+s` | Save session |
| `prefix + Ctrl+r` | Restore session |
| `prefix + n` | Create new session |

#### Layout Presets
| Key | Description |
|-----|-------------|
| `prefix + M-!` | Even horizontal |
| `prefix + M-@` | Even vertical |
| `prefix + M-#` | Main horizontal |
| `prefix + M-$` | Main vertical |
| `prefix + M-%` | Tiled |

### Plugins
- **tpm**: Plugin manager
- **tmux-sensible**: Sensible defaults
- **tmux-gruvbox**: Gruvbox theme
- **tmux-resurrect**: Session persistence
- **tmux-continuum**: Automatic session saves
- **tmux-fzf**: Fuzzy finder integration (`Ctrl+f`)
- **tmux-sessionx**: Enhanced session management
- **tmux-notify**: Process completion notifications
- **tmux-open**: Open URLs/files from terminal

### Performance Optimizations
- Status bar update interval: 5 seconds (reduced CPU usage)
- Disabled heavy monitoring plugins (CPU, battery indicators)
- Lazy loading for conda and other heavy tools in zsh
- Minimal configuration available at `.tmux-minimal.conf`

## 🎨 Themes

- **Tmux**: Gruvbox Dark theme
- **Oh My Posh**: Microverse Power theme
- **Terminal**: Optimized for Nerd Fonts

## 🔧 Customization

Each configuration module can be customized independently:

- **Aliases**: Edit `zsh/config/alias.zsh`
- **Environment**: Edit `zsh/config/env-init.zsh`
- **Prompt**: Edit `.config/oh-my-posh/themes/`
- **Tmux**: Edit `.tmux.conf`

### Performance Tips

#### Zsh Optimization
```bash
# Add to .zshrc for lazy loading heavy tools
conda() {
    unfunction conda
    source /opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh
    conda "$@"
}
```

#### Tmux Performance Testing
```bash
# Test with minimal config
tmux -f ~/.tmux-minimal.conf

# Measure startup time
time tmux new-session -d -s test && tmux kill-session -t test
```

## 📦 Dependencies

Run `./check-deps.sh` to verify all dependencies are installed.

### Required
- zsh, tmux, oh-my-posh, fzf, eza, zoxide, direnv, git, neovim, bat

### Optional
- tig, lazygit, ripgrep, tree, pbcopy (macOS)

## 🚨 Troubleshooting

### Tmux window/pane creation is slow
1. Check zsh startup time: `time zsh -i -c exit`
2. Use minimal config: `tmux -f ~/.tmux-minimal.conf`
3. Disable heavy plugins in `.tmux.conf`
4. Add lazy loading for conda/nvm in `.zshrc`

### Key bindings not working
1. For macOS Option key: Configure iTerm2 → Preferences → Profiles → Keys → Left/Right Option key = Esc+
2. Check for conflicts: `tmux list-keys | grep <key>`
3. Reload config: `prefix + r`

### Plugins not installing
1. Install TPM: `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
2. In tmux: `prefix + I` to install plugins
3. Clean unused: `prefix + M-u`

## 🤝 Contributing

Feel free to fork and customize for your own needs!

## 📄 License

MIT
