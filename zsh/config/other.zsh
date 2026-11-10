# EDITOR / LANG / setopt correct などは .zshrc で設定済み
# zoxide / direnv / asdf / 補完 / ハイライトも .zshrc で初期化済み

# HSTR configuration（^r はfzfに統一。hstr は hh エイリアスで直接使用可）
if command -v hstr &> /dev/null; then
    alias hh=hstr
    export HSTR_CONFIG=hicolor
fi
