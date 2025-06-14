#!/bin/bash

# Dependency Check Script
echo "🔍 Checking dependencies..."

# Required commands
REQUIRED_COMMANDS=(
    "zsh"
    "tmux"
    "starship"
    "fzf"
    "eza"
    "zoxide"
    "direnv"
    "git"
    "nvim"
    "bat"
)

# Optional commands
OPTIONAL_COMMANDS=(
    "thefuck"
    "hstr"
    "timer"
    "terminal-notifier"
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
    echo "💡 Install missing dependencies with:"
    echo "brew install ${missing_required[*]}"
fi

if [ ${#missing_optional[@]} -gt 0 ]; then
    echo ""
    echo "💡 Optional dependencies can be installed with:"
    echo "brew install ${missing_optional[*]}"
fi 