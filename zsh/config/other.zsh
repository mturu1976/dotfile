# コマンドのスペルを訂正
setopt correct

# the fuck
eval $(thefuck --alias)

# nonomatch
setopt nonomatch

# zoxide
eval "$(zoxide init zsh)"

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

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

# zplug initialization
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "b4b4r07/enhancd", use:"init.sh"

if ! zplug check --verbose; then
    printf "インストールしますか？[y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load
