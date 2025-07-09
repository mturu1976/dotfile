# fzf (Fuzzy Finder) チュートリアル

## 基本概念
fzfは「あいまい検索」ツールです。完全一致でなくても、部分的に一致するものを見つけてくれます。

## 基本的な使い方

### 1. ファイル検索
```bash
# カレントディレクトリ以下のファイルを検索
fzf

# プレビュー付き
fzf --preview 'cat {}'

# batでシンタックスハイライト付きプレビュー
fzf --preview 'bat --style=numbers --color=always {}'
```

### 2. コマンド履歴検索
```bash
# .zshrcに追加済み
# Ctrl+R で履歴検索
```

### 3. ディレクトリ移動
```bash
# zoxide（z）と組み合わせて使用
z <Space><Tab>
```

## fzfの検索パターン

| パターン | 説明 | 例 |
|----------|------|-----|
| `sbtrkt` | あいまい検索 | `sbtrkt` → `subplot_tracker` |
| `'wild` | 前方一致 | `'wild` → `wildcard` |
| `exact$` | 後方一致 | `.md$` → `README.md` |
| `^music` | 完全前方一致 | `^music` → `music.mp3` |
| `!fire` | 否定 | `!test` → testを含まない |
| `!^music` | 否定前方一致 | `!^test` → testで始まらない |

## 便利なキーバインド

| キー | 動作 |
|------|------|
| `Ctrl+j/k` | 上下移動（vimスタイル） |
| `Ctrl+n/p` | 上下移動（emacsスタイル） |
| `Tab` | 複数選択/選択解除 |
| `Ctrl+a` | 全選択 |
| `Ctrl+d` | 選択解除 |
| `Ctrl+/` | プレビュー表示切り替え |

## tmux + extrakto + fzfの実用例

### URLを探してブラウザで開く
1. `prefix + tab` でextrakto起動
2. `Ctrl+u` でURLフィルター
3. 開きたいURLを選択してEnter
4. `Cmd+V`でペーストして開く

### ファイルパスをコピー
1. `prefix + tab` でextrakto起動
2. `Ctrl+p` でパスフィルター
3. パスを選択してコピー

### エラーメッセージから特定の部分を抽出
1. エラーが表示されている画面で`prefix + tab`
2. 必要な部分（エラーコード、ファイル名など）を検索
3. 選択してコピー

## .zshrcに追加する便利な設定

```bash
# fzfのデフォルトオプション
export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border
  --preview-window=:hidden
  --bind='ctrl-/:toggle-preview'
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
"

# ripgrepを使った高速ファイル検索
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# Ctrl+Tでファイル検索（プレビュー付き）
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"

# Alt+Cでディレクトリ移動
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
```

## エイリアス集

```bash
# Git関連
alias gco='git branch | fzf | xargs git checkout'
alias gadd='git status -s | fzf -m | awk "{print \$2}" | xargs git add'

# プロセス管理
alias fkill='ps aux | fzf | awk "{print \$2}" | xargs kill -9'

# Docker
alias dexec='docker ps | fzf | awk "{print \$1}" | xargs -I {} docker exec -it {} bash'
```

## 練習問題

1. tmuxで`ls -la`の出力から特定のファイル名をコピー
2. エラーログからエラーコードだけを抽出
3. 長いコマンドの出力からURLを見つけてコピー

これらを`prefix + tab`で練習してみてください！