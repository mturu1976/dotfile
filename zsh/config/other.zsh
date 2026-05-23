# コマンドのスペルを訂正
setopt correct

# the fuck
eval $(thefuck --alias)

# nonomatch
setopt nonomatch

# zoxide（zsh/.zshrcで既に初期化済みのため、ここでは無効化）
# eval "$(zoxide init zsh)"

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# asdf
# . /opt/homebrew/opt/asdf/libexec/asdf.sh

# direnv
export EDITOR=code
eval "$(direnv hook zsh)"

# anyenv
#export PATH="$HOME/.anyenv/bin:$PATH"
#eval "$(anyenv init -)"

# HSTR configuration
alias hh=hstr
setopt histignorespace
export HSTR_CONFIG=hicolor
bindkey -s "\C-r" "\C-a hstr -- \C-j"
export HISTFILESIZE=10000
export HISTSIZE=${HISTFILESIZE}

# zsh-completions (Homebrew) — fpath追加はcompinit前に必要なため.zshrcで設定済み
# zsh-syntax-highlighting / zsh-autosuggestions も .zshrc で直接ロード済み
# enhancd は zoxide (z コマンド) で代替。cd 標準維持のため不要
