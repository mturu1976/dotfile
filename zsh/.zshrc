#!/bin/zsh
# Modern zsh configuration - High Performance & Cyberpunk Theme

# Return early if not zsh
if [ -z "$ZSH_VERSION" ]; then
  return
fi

# Oh My Poshの初期化（CYBERPUNK THEME + 視認性向上）
eval "$(oh-my-posh init zsh --config ~/dotfile/.config/oh-my-posh/themes/cyberpunk.omp.json)"

# 視認性向上のためのターミナル設定
export TERM=xterm-256color
export COLORTERM=truecolor

# カーソルの視認性向上
echo -ne '\e[2 q'  # ブロックカーソル

# Starshipの設定（無効化）
# export STARSHIP_CONFIG="$HOME/dotfile/starship/starship.toml"
# eval "$(starship init zsh)"

# asdfの初期化
export ASDF_DIR="$(brew --prefix asdf)"
if [[ -d "$ASDF_DIR" ]]; then
    . "$ASDF_DIR/asdf.sh"
fi

# Homebrewのパス設定
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# asdf shimの設定
export PATH="$HOME/.asdf/shims:$PATH"

# 高速化：重要な設定のみ即座に読み込み
source ~/dotfile/zsh/config/alias.zsh

# zoxide（z）は頻繁に使うため即座に読み込み
eval "$(zoxide init zsh)"

# zsh補完システムの有効化
autoload -Uz compinit
compinit -C

# 基本的な補完設定
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# 補完スタイル
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

# リアルタイム候補表示（zsh-autosuggestions）
if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6B7B8C"  # 控えめな色
fi

# シンタックスハイライト
if [[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# エイリアス：c = 詳細補完を有効化
alias c='source ~/dotfile/zsh/config/completion.zsh && echo "詳細補完有効化完了"'

# その他の設定は遅延読み込み（必要時に自動読み込み）
function __load_zsh_configs() {
    if [ -z "$__ZSH_CONFIGS_LOADED" ]; then
        for config_file in ~/dotfile/zsh/config/{completion,env-init,other,poetry}.zsh; do
            [ -f "$config_file" ] && source "$config_file"
        done
        export __ZSH_CONFIGS_LOADED=1
    fi
}

# 特定のコマンド実行時に設定を読み込み
function poetry() { __load_zsh_configs; command poetry "$@"; }

# >>> conda initialize (lazy loading for performance) >>>
# conda環境名をプロンプトに表示しない
export CONDA_CHANGEPS1=false

# 遅延読み込みでzsh起動を高速化
function __conda_lazy_init() {
    if [ -z "$__CONDA_INITIALIZED" ]; then
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
        export __CONDA_INITIALIZED=1
    fi
}

# condaコマンドが呼ばれた時に初期化
function conda() {
    __conda_lazy_init
    conda "$@"
}

# python実行時もconda環境を考慮
function python() {
    __conda_lazy_init
    command python "$@"
}
# <<< conda initialize <<<

# Added by Windsurf
export PATH="/Users/tanuki/.codeium/windsurf/bin:$PATH"
bindkey -e
bindkey "^K" kill-line

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
# GitHub token is set via environment variables for security