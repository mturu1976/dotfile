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

# fzf の設定
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"

# zsh-syntax-highlighting
source /opt/homebrew/opt/zplug/repos/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-autosuggestions
source /opt/homebrew/opt/zplug/repos/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh
