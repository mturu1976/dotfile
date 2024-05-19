# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# starship
#export STARSHIP_CONFIG=~/.config/starship/starship.toml
#eval "$(starship init zsh)"
# 

export PATH=/usr/local/bin:$PATH



###############
# ヒストリ関連
###############

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=50000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=600000

# 開始と終了を記録
setopt EXTENDED_HISTORY

#zsh
autoload -Uz zmv

# /opt/homebrew/share ディレクトリを fpath に追加
fpath=(/opt/homebrew/share $fpath)

# 補完機能を有効にする
autoload -Uz compinit
compinit -u
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

# git保管
source /opt/homebrew/opt/git-extras/share/git-extras/git-extras-completion.zsh

# 補完候補を詰めて表示
setopt list_packed

# 補完候補一覧をカラー表示
autoload colors
zstyle ':completion:*' list-colors ''

# コマンドのスペルを訂正
setopt correct

# the fuck
eval $(thefuck --alias)

# fzf
eval "$(fzf --zsh)"

#zlib
# LDFLAGS="-L/usr/local/opt/zlib/lib"
# CPPFLAGS="-I/usr/local/opt/zlib/include"

#openssl
# PATH=$PATH:/usr/local/opt/openssl@1.1/bin:/usr/local/opt/openssl/bin
# LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/openssl@1.1/lib"
# CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/openssl@1.1/include"
# PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

#zsh-completions
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
	autoload -Uz compinit
    compinit
fi


#pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init --path)"

# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init --path)"
# fi

#virtualenv
#eval "$(pyenv virtualenv-init -)"


#alias
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
alias ls='eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions'
alias ll='ls --git --time-style=long-iso -gl'
alias la='ls --git --time-style=long-iso -agl'
alias l1='eza -1'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

alias dll='time aria2c -x10 -s10 -k1M '
alias cot="open -a /Applications/CotEditor.app"

alias sakiokuri0="timer 8m && terminal-notifier -message 'Pomodoro'\
-title 'ワークタイマー作動 休憩 😀'\
-appIcon ' -/Pictures/pumpkin.png'\
-sound Crystal"

alias work="timer 8m && terminal-notifier -message 'Pomodoro'\
-title 'work Timer is up! Take a Break 😀'\
-appIcon ' -/Pictures/pumpkin.png'\
-sound Crystal"

#DL
alias dll2='time aria2c -x10 -s10 -k2M '

# youtube-dl
# alias youtubemp3='youtube-dl -x --audio-format mp3 '
# alias you3='youtube-dl -x --audio-format mp3 '
# alias youtube3='youtube-dl -x --audio-format mp3 '
# alias youtubedl='youtube-dl --cookies /Users/$USERNAME/Documents/projects/youtubedl/youtube.com_cookies.txt '

# vimでnvimが起動するようにする 
alias vim="nvim"

#emacs
#alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"

# python
alias dougubako="cd /Users/$USERNAME/Documents/py/dougubako2021;python ./dougubako.py"

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# youtube字幕
alias jimaku='cd /Users/tanuki/Documents/py/youtube_jimaku200;python ./toucou_youtube.py '

# youtube字幕
alias opendot='cd /Users/tanuki/Documents/py/youtube_jimaku200;python ./opendot.py '


# sedondbrain mkdir
alias mkdir2='mkdir 0inbox 1Projects 2Areas 3Resources 4Archives'
alias mkdirpara="mkdir 0inbox 1Projects 2Areas 3Resources 4Archives"

# alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"export PATH="/usr/local/opt/texinfo/bin:$PATH"

# HDD取り出す
alias toridashi="diskutil unmount /Volumes/HD-LE-B"
# alias toridasi="diskutil unmount /Volumes/HD-LE-B"
# alias toridasu="diskutil unmount /Volumes/HD-LE-B"


#emacs build
export PATH="/usr/local/opt/texinfo/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

#python
#alias pip-upgrade-all="pip list -o | tail -n +3 | awk '{ print \$1 }' | xargs pip install -U"function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}

#project python
alias ppython="gibo dump MacOS Python emacs >> .gitignore;git init;touch Readme.md requirements.txt"

#path
#export PATH="/Users/$USERNAME/.deta/bin:$PATH"
#export DETA_ACCESS_TOKEN=a0bbsmf0_EAtmnHYHNNah37CYqmLKsnubXnExBAWq

# nonomatch
setopt nonomatch

# tcl-tk
export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/tcl-tk/lib"
export CPPFLAGS="-I/usr/local/opt/tcl-tk/include"
export PKG_CONFIG_PATH="/usr/local/opt/tcl-tk/lib/pkgconfig"
export PYTHON_CONFIGURE_OPTS="--with-tcltk-includes='-I/usr/local/opt/tcl-tk/include' --with-tcltk-libs='-L/usr/local/opt/tcl-tk/lib -ltcl8.6 -ltk8.6'"

#zoxide
eval "$(zoxide init zsh)"
# HSTR configuration - add this to ~/.zshrc
alias hh=hstr                    # hh to be alias for hstr
setopt histignorespace           # skip cmds w/ leading space from history
export HSTR_CONFIG=hicolor       # get more colors
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)# Python Custom Command File
export PATH="$HOME/.pycmd-scripts:$PATH"
export PATH="$HOME:$PATH"

#autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

#dreenv
export EDITOR=code
eval "$(direnv hook zsh)"

#poetory
export PATH="/Users/$USERNAME/.local/bin:$PATH"export PATH="$HOME/.anyenv/bin:$PATH"

#anyenv
# export PATH="$HOME/.anyenv/bin:$PATH"
# eval "$(anyenv init -)"

# composer
#export PATH=~/.composer/vendor/bin:$PATH
export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
#export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# source /Users/$USERNAME/.config/broot/launcher/bash/br

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
alias tmuxnew='tmux new-session -d -s'
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

PATH=~/.console-ninja/.bin:$PATH
export PATH="$HOME/.poetry/bin:$PATH"
