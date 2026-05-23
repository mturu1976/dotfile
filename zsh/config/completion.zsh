# ~/dotfile/zsh/config/completion.zsh

# 補完機能を有効にする
# autoload -Uz compinit
# compinit -u

# if [ -e /usr/local/share/zsh-completions ]; then
#   fpath=(/usr/local/share/zsh-completions $fpath)
# fi

# source /opt/homebrew/opt/git-extras/share/git-extras/git-extras-completion.zsh

# poetry 補完
# if type poetry &>/dev/null; then
#   eval "$(poetry completions zsh)"
# fi

# fzf の設定（キーバインドは .zshrc で起動時に初期化済み）
# eval "$(fzf --zsh)"

# zsh-syntax-highlighting / zsh-autosuggestions は .zshrc で Homebrew から直接ロード済み
