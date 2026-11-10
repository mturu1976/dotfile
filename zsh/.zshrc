# Modern zsh configuration - High Performance & Cyberpunk Theme

# Return early if not zsh
if [ -z "$ZSH_VERSION" ]; then
  return
fi

# 視認性向上のためのターミナル設定
export TERM=xterm-256color
export COLORTERM=truecolor

# カーソルの視認性向上（インタラクティブシェルのみ）
if [[ $- == *i* ]]; then
    echo -ne '\e[2 q'  # ブロックカーソル
fi

# アーキテクチャに応じてHomebrewプレフィックスを自動判別（Intel / Apple Silicon 共用）
if [[ $CPUTYPE == arm64 ]]; then
    export HOMEBREW_PREFIX="/opt/homebrew"
else
    export HOMEBREW_PREFIX="/usr/local"
fi

# PATH / FPATH の重複を自動排除（tmux等から継承した重複も消える）
typeset -U path fpath

# PATH（存在しないディレクトリは無害。マシンごとの差はここに出る）
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"
path=(
    "$HOME/.local/bin"
    "$HOME/.antigravity/antigravity/bin"
    "$HOME/.codeium/windsurf/bin"
    "$ASDF_DATA_DIR/shims"
    "$HOMEBREW_PREFIX/sbin"
    "$HOMEBREW_PREFIX/bin"
    $path
)

# FPATH汚染への防御
# tmuxサーバー等から古いzshのFPATHを継承すると、brew upgrade後に消えた
# Cellarパスを指したままになり、標準関数(is-at-least等)が読めず
# oh-my-poshやsyntax-highlightingが壊れる
typeset +x FPATH            # FPATHを子プロセスにexportしない
fpath=(${^fpath}(N-/))      # 存在しないディレクトリを除去
__std_fns=(${^fpath}/is-at-least(N))
if (( ! ${#__std_fns} )); then
    # 標準関数ディレクトリが失われていたら、実行中のzshに合うものを補う
    for __fn_dir in "/usr/share/zsh/${ZSH_VERSION}/functions" "$HOMEBREW_PREFIX/share/zsh/functions"; do
        if [[ -d $__fn_dir ]]; then
            fpath+=("$__fn_dir")
            break
        fi
    done
fi
unset __std_fns __fn_dir

# Oh My Poshの初期化（PATH設定後に実行）
eval "$(oh-my-posh init zsh --config ~/dotfile/.config/oh-my-posh/themes/cyberpunk.omp.json)"

# 基本設定
export EDITOR="cursor --wait"   # git commit 等で Cursor を使用
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export GIT_PAGER="delta"
setopt correct                  # コマンドのタイポを修正提案
setopt nonomatch                # グロブ不一致時にエラーにしない

# キーバインド（プラグインより前に確定させる）
bindkey -e
bindkey "^K" kill-line

# ヒストリー設定
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_ALL_DUPS  # 重複コマンドを全削除
setopt HIST_REDUCE_BLANKS    # 余分なスペースを削除して記録
setopt SHARE_HISTORY         # 複数ターミナル間で履歴をリアルタイム共有
setopt HIST_VERIFY           # !! 展開時に即実行せず確認する
setopt HIST_IGNORE_SPACE     # 先頭にスペースを付けたコマンドは履歴に残さない（秘密を含む入力用）

# 基本的な補完設定
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# 分割設定（すべてサブプロセス無し。マシン差は各ファイル内の存在チェックで吸収）
for __cfg in ~/dotfile/zsh/config/{alias,env-init,other}.zsh; do
    [[ -f $__cfg ]] && source "$__cfg"
done
unset __cfg

# zsh-completions (Homebrew) — compinit より前にfpathへ追加
if [[ -d $HOMEBREW_PREFIX/share/zsh-completions ]]; then
    fpath=($HOMEBREW_PREFIX/share/zsh-completions $fpath)
fi

# zsh補完システムの有効化（zoxideの前に必要）
# 24時間以上古いダンプは再検査、それ以外はキャッシュ利用（-C）で高速起動
# (#q…) は EXTENDED_GLOB が必要なので無名関数内で局所的に有効化
autoload -Uz compinit
() {
    setopt localoptions extendedglob
    local dump=${ZDOTDIR:-$HOME}/.zcompdump
    if [[ -n $dump(#qN.mh+24) ]]; then
        compinit && touch "$dump"   # 再検査後は次回から -C に戻す
    else
        compinit -C
    fi
}

# bracketed paste modeの有効化（ペースト時の200~問題を解決）
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# 補完スタイル
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

# リアルタイム候補表示（zsh-autosuggestions）
if [[ -f $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6B7B8C"  # 控えめな色
fi

# fzf キーバインド（^r: 履歴検索、^t: ファイル検索、alt-c: ディレクトリ移動）
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)"
fi

# direnv（ディレクトリ移動時に .envrc を自動読み込み）
if command -v direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi

# zoxide（z）- スマートディレクトリジャンプ
# cdは標準のまま維持（Claude Codeなどのツールとの互換性のため）
# zoxideのスマートジャンプは`z`コマンドで手動使用
# 例: `z proj` でプロジェクトディレクトリにジャンプ
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

[[ "$TERM_PROGRAM" == "kiro" ]] && command -v kiro &> /dev/null && . "$(kiro --locate-shell-integration-path zsh)"

# シンタックスハイライト（公式推奨: 他のウィジェット定義より後、最後に読む）
if [[ -f $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# マシン固有・秘密の設定（リポジトリ外、権限600）。APIキー等はここに書く
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
