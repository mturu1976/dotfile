# ~/.zshrc


# Zsh以外で読み込まれた場合、終了する
if [ -z "$ZSH_VERSION" ]; then
  return
fi

# Starshipの設定ファイルの場所を指定
export STARSHIP_CONFIG="$HOME/dotfile/starship/starship.toml"

# Starshipの初期化
eval "$(starship init zsh)"

# 補完機能の初期化
# autoload -Uz compinit
# compinit -u

# asdfの初期化
export ASDF_DIR="$(brew --prefix asdf)"
export PATH="$ASDF_DIR/bin:$PATH"


# source "$(brew --prefix asdf)/bin/asdf.sh"

# source /opt/homebrew/opt/asdf/bin/asdf.sh

# . /opt/homebrew/opt/asdf/libexec/asdf.sh

# Poetry の設定
#export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.asdf/shims:$PATH"

# Load all config files from ~/dotfile/zsh/config
for config_file in ~/dotfile/zsh/config/*.zsh; do
  source $config_file
done


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# Added by Windsurf
export PATH="/Users/tanuki/.codeium/windsurf/bin:$PATH"
