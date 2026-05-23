# ~/dotfile/zsh/config/completion.zsh
# オンデマンド補完設定 — `c` エイリアスで手動ロード

# poetry 補完（起動時間への影響を避けるため手動ロード）
if command -v poetry &>/dev/null; then
    eval "$(poetry completions zsh)"
    echo "poetry 補完を有効化しました"
fi
