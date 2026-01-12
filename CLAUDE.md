# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a modern, performance-optimized dotfiles repository for macOS development workflows. The configuration emphasizes terminal multiplexing (tmux), shell enhancement (zsh), and fuzzy finding workflows with a unified cyberpunk/synthweave theme.

## Key Commands

### Development Environment Setup
```bash
# Check and install dependencies
./check-deps.sh                    # Verify missing dependencies
brew bundle                       # Install Homebrew packages from Brewfile

# Performance testing
time zsh -i -c exit                # Measure zsh startup time
tmux source-file ~/.tmux.conf      # Reload tmux configuration
```

### Interactive Git Workflows (fzf-powered)
```bash
fgc                    # Interactive git branch checkout with fuzzy search
flog                   # Interactive git log browser with commit preview  
fadd                   # Interactive git staging with diff preview
fcd                    # Interactive directory navigation
```

### Tmux Operations
```bash
# Prefix key: Ctrl+j
tmux new-session -s <name>         # Create new session
tmux attach -t <name>              # Attach to session
# Key bindings:
# prefix+g: Git popup window
# prefix+C: Claude Code popup  
# prefix+N: Notes popup
# Alt+h/j/k/l: Seamless vim-tmux pane navigation
```

## Architecture & Configuration Structure

### Core Configuration Files
- **`.tmux.conf`**: 456-line comprehensive tmux setup with custom theme and performance optimizations
- **`zsh/.zshrc`**: Main shell configuration with Oh My Posh integration and lazy loading
- **`zsh/config/`**: Modular zsh configurations split by functionality:
  - `alias.zsh`: Interactive git/fzf functions
  - `completion.zsh`: Completions and syntax highlighting
  - `env-init.zsh`: Environment variables and PATH setup
  - `poetry.zsh`: Python Poetry integration

### Theme System
- **Oh My Posh**: Primary prompt system via `cyberpunk.omp.json`
- **Starship**: Alternative prompt in `starship/starship.toml` (currently disabled)
- **Conditional loading**: Different prompts for tmux vs standalone sessions via `prompt-switcher.zsh`

### Performance Optimization Patterns

#### Lazy Loading Implementation
The codebase uses extensive lazy loading for performance:
```bash
# Conda lazy initialization pattern
function conda() {
    unset -f conda
    eval "$(/opt/homebrew/bin/conda shell.zsh hook)"
    conda "$@"
}
```

#### Plugin Management Strategy
- Heavy tmux plugins (cpu monitoring, complex status bars) are commented out
- Essential plugins (resurrect, continuum) remain active for session persistence
- Performance vs functionality trade-offs are explicitly documented

### Color Theme Architecture
- **Unified palette**: Consistent cyberpunk/synthweave colors across tmux and prompt
- **Low saturation design**: Muted colors to reduce visual fatigue
- **Background consistency**: Dark themes (#262335, #1F2937) throughout
- **Accent colors**: Coordinated foreground colors (#8B93C7, #D1D5DB, #C48691)

## Development Workflow Integration

### fzf-Everywhere Pattern
Most git and file operations use fuzzy finding:
- Branch switching, log browsing, and staging are all interactive
- Directory navigation and file selection integrate with fzf
- Custom preview windows show git diffs and file contents

### Tmux Popup System
Key development tools accessible via popup windows:
- Git operations (tig, interactive staging)
- Claude Code integration for AI assistance
- Quick note-taking and temporary terminals

### Session Management
- **Automatic persistence**: Sessions restore automatically via tmux-continuum
- **Manual control**: `Ctrl+j + Ctrl+s` to save, `Ctrl+j + Ctrl+r` to restore
- **Named sessions**: Use descriptive session names for project separation

## Performance Considerations

### Startup Time Optimization
- Target: <0.1s zsh startup time (measured via `time zsh -i -c exit`)
- Conditional loading of heavy configurations
- Cached completions and minimal plugin loading

### Resource Usage
- Tmux status updates every 30 seconds (not real-time) for CPU efficiency
- Disabled resource monitoring plugins by default
- Modular configuration allows selective feature enabling

## Common Issues & Solutions

### Theme Not Loading
If cyberpunk theme doesn't apply:
```bash
oh-my-posh cache clear             # Clear cached configurations
eval "$(oh-my-posh init zsh --config ~/dotfile/.config/oh-my-posh/themes/cyberpunk.omp.json)"
```

### Tmux Session Restoration
If sessions don't restore:
```bash
# Ensure plugins are active in .tmux.conf:
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
```

### Performance Debugging
Monitor startup performance:
```bash
# Add to .zshrc temporarily:
zmodload zsh/zprof
# ... at end of file:
zprof
```