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

# カーソルの視認性向上（インタラクティブシェルのみ）
if [[ $- == *i* ]]; then
    echo -ne '\e[2 q'  # ブロックカーソル
fi

# Starshipの設定（無効化）
# export STARSHIP_CONFIG="$HOME/dotfile/starship/starship.toml"
# eval "$(starship init zsh)"

# アーキテクチャに応じてHomebrewプレフィックスを自動判別（Intel / Apple Silicon 共用）
if [[ "$(uname -m)" == "arm64" ]]; then
    export HOMEBREW_PREFIX="/opt/homebrew"
else
    export HOMEBREW_PREFIX="/usr/local"
fi

# Homebrewのパス設定
export PATH="$HOMEBREW_PREFIX/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/sbin:$PATH"

# asdf (v0.16+ Go版) shimの設定
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"
export PATH="$ASDF_DATA_DIR/shims:$PATH"

# 高速化：重要な設定のみ即座に読み込み（zoxide初期化前）
# cdエイリアスはzoxide初期化後に設定するため一時的に除外
source ~/dotfile/zsh/config/alias.zsh

# zsh-completions (Homebrew) — compinit より前にfpathへ追加
if [[ -d $HOMEBREW_PREFIX/share/zsh-completions ]]; then
    fpath=($HOMEBREW_PREFIX/share/zsh-completions $fpath)
fi

# zsh補完システムの有効化（zoxideの前に必要）
# 24時間以上古いダンプは再生成、それ以外はキャッシュ利用で高速起動
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qNmh+24) ]]; then
    compinit
else
    compinit -C
fi

# bracketed paste modeの有効化（ペースト時の200~問題を解決）
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# 基本的な補完設定
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# 補完スタイル
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

# リアルタイム候補表示（zsh-autosuggestions）
if [[ -f $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6B7B8C"  # 控えめな色
fi

# シンタックスハイライト
if [[ -f $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# fzf キーバインド（^r: 履歴検索、^t: ファイル検索、alt-c: ディレクトリ移動）
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)"
fi

# zoxide（z）- スマートディレクトリジャンプ
# cdは標準のまま維持（Claude Codeなどのツールとの互換性のため）
# zoxideのスマートジャンプは`z`コマンドで手動使用
# 例: `z proj` でプロジェクトディレクトリにジャンプ
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
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
        __conda_setup="$("$HOMEBREW_PREFIX/Caskroom/miniconda/base/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        else
            if [ -f "$HOMEBREW_PREFIX/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
                . "$HOMEBREW_PREFIX/Caskroom/miniconda/base/etc/profile.d/conda.sh"
            else
                export PATH="$HOMEBREW_PREFIX/Caskroom/miniconda/base/bin:$PATH"
            fi
        fi
        unset __conda_setup
        export __CONDA_INITIALIZED=1
    fi
}

# condaコマンドが呼ばれた時に初期化
# unfunctionでラッパー自身を先に削除してから初期化→再呼び出しすることで無限再帰を防ぐ
function conda() {
    unfunction conda
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
export PATH="$HOME/.codeium/windsurf/bin:$PATH"
bindkey -e
bindkey "^K" kill-line

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
# GitHub token is set via environment variables for security
# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
