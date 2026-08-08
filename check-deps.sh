#!/bin/bash

# Dependency Check Script
echo "🔍 Checking dependencies..."

# Required commands
REQUIRED_COMMANDS=(
    "zsh"
    "tmux"
    "oh-my-posh"
    "fzf"
    "eza"
    "zoxide"
    "direnv"
    "git"
    "delta"
    "nvim"
    "bat"
)

# Optional commands
OPTIONAL_COMMANDS=(
    "hstr"
    "timer"
    "terminal-notifier"
    "btop"
    "duf"
    "dust"
    "glow"
    "procs"
)

missing_required=()
missing_optional=()

echo "📋 Required dependencies:"
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "  ✅ $cmd"
    else
        echo "  ❌ $cmd (MISSING)"
        missing_required+=("$cmd")
    fi
done

echo ""
echo "📋 Optional dependencies:"
for cmd in "${OPTIONAL_COMMANDS[@]}"; do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "  ✅ $cmd"
    else
        echo "  ⚠️  $cmd (optional, not installed)"
        missing_optional+=("$cmd")
    fi
done

echo ""
if [ ${#missing_required[@]} -eq 0 ]; then
    echo "🎉 All required dependencies are installed!"
else
    echo "❌ Missing required dependencies:"
    for cmd in "${missing_required[@]}"; do
        echo "  - $cmd"
    done
    echo ""
    echo "💡 Install everything with:  brew bundle"
fi

if [ ${#missing_optional[@]} -gt 0 ]; then
    echo ""
    echo "💡 Optional tools are also covered by:  brew bundle"
fi 