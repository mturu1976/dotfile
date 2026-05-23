# コマンドのスペルを訂正
setopt correct

# nonomatch
setopt nonomatch

# zoxide（zsh/.zshrcで既に初期化済みのため、ここでは無効化）
# eval "$(zoxide init zsh)"

# autojump
[ -f "$HOMEBREW_PREFIX/etc/profile.d/autojump.sh" ] && . "$HOMEBREW_PREFIX/etc/profile.d/autojump.sh"

# asdf
# . /opt/homebrew/opt/asdf/libexec/asdf.sh

# direnv は .zshrc で起動時に初期化済み
export EDITOR=code

# anyenv
#export PATH="$HOME/.anyenv/bin:$PATH"
#eval "$(anyenv init -)"

# HSTR configuration（^r はfzfに統一。hstr は hh エイリアスで直接使用可）
# HISTSIZE / SAVEHIST は .zshrc で定義済みのためここでは設定しない
alias hh=hstr
setopt histignorespace
export HSTR_CONFIG=hicolor

# zsh-completions (Homebrew) — fpath追加はcompinit前に必要なため.zshrcで設定済み
# zsh-syntax-highlighting / zsh-autosuggestions も .zshrc で直接ロード済み
# enhancd は zoxide (z コマンド) で代替。cd 標準維持のため不要
