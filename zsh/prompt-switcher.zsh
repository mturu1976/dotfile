#!/bin/zsh
# プロンプト切り替え設定

# tmux内外で異なるプロンプトを使う場合
if [ -n "$TMUX" ]; then
    # tmux内ではOh My Posh
    eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/microverse-power.omp.json)"
else
    # tmux外ではStarship
    export STARSHIP_CONFIG="$HOME/dotfile/starship/starship.toml"
    eval "$(starship init zsh)"
fi

# または、完全にOh My Poshに切り替える場合
# eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/microverse-power.omp.json)"