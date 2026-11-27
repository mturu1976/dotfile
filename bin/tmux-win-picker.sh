#!/bin/zsh
# prefix+w のウィンドウ/セッション一覧（fzf）
#   ★   = 現在地（開いた瞬間にカーソルが乗る / C-g で戻る）
#   🤖  = Claude Code が動いているウィンドウ（いずれかのペインの実行コマンドが claude）
#   C-r = カーソル行のセッション名を変更
#   C-e = カーソル行のセッションにメモ（@note）を付ける（空=維持, -=削除）
#
# サブコマンド:
#   list          一覧を出力
#   jump          ★ の行番号を fzf の pos() アクションとして出力（transform 用）
#   rename <行>   セッション名変更（fzf の execute から呼ばれる）
#   note   <行>   メモ編集（同上）
#   (なし)        fzf を起動

set -u
SELF="${0:A}"

# 一覧の 1 行から "session:window" を取り出す
target_of() {
  setopt localoptions extendedglob   # 下の `#` 量指定子に必要
  local line="$1"
  line="${line##[ 0-9]#[0-9] }"   # 行頭の通し番号
  line="${line#(★ |  )}"          # 現在地マーカー（非該当行は空白 2 個）
  line="${line#(🤖 |   )}"        # Claude Code マーカー（非該当行は空白 3 個）
  print -r -- "${line%% | *}"
}

# "session:window" からセッション名を取り出す
session_of() {
  local t
  t="$(target_of "$1")"
  print -r -- "${t%:*}"
}

cmd_list() {
  # 行頭に通し番号を付ける（今いる行が一目で分かるように）
  # 🤖: ウィンドウ内のどこかのペインで claude が動いていれば付ける
  #     （#{P:…} で全ペインの pane_current_command を並べ、#{m:…} で glob 一致。外部コマンド不要）
  tmux list-windows -a -F \
    '#{?#{&&:#{session_attached},#{window_active}},★ ,  }#{?#{m:*claude*,#{P:#{pane_current_command} }},🤖 ,   }#{session_name}:#{window_index} | #{window_name} | [#{window_panes}panes] | #{b:pane_current_path}#{?@note, | 📝 #{@note},}' \
  | awk '{ printf "%2d %s\n", NR, $0 }'
}

cmd_jump() {
  local n
  n="$(cmd_list | grep -n '★' | head -1 | cut -d: -f1)"
  print -r -- "pos(${n:-1})"
}

cmd_rename() {
  local sess name
  sess="$(session_of "$1")"
  [[ -z "$sess" ]] && return 0
  read -r "name?新しいセッション名 [現在: ${sess}] (空=維持): "
  [[ -z "$name" ]] && return 0
  if tmux has-session -t "=${name}" 2>/dev/null; then
    print -r -- "「${name}」は既に存在します。変更しません。"
    sleep 1
    return 0
  fi
  tmux rename-session -t "=${sess}" "$name"
}

cmd_note() {
  local sess cur note
  sess="$(session_of "$1")"
  [[ -z "$sess" ]] && return 0
  cur="$(tmux show-option -t "=${sess}:" -qv @note 2>/dev/null)"
  read -r "note?メモ [現在: ${cur:-なし}] (空=維持, -=削除): "
  [[ -z "$note" ]] && return 0
  if [[ "$note" == "-" ]]; then
    tmux set-option -t "=${sess}:" -u @note
  else
    tmux set-option -t "=${sess}:" @note "$note"
  fi
}

cmd_pick() {
  local sel
  sel="$(cmd_list | fzf \
    --prompt=' WIN> ' --border --reverse --ansi --sync \
    --info=inline-right \
    --info-command='printf "\e[33;1m%s\e[m行目 / %s件%s" "$FZF_POS" "$FZF_MATCH_COUNT" "$( [ "$FZF_MATCH_COUNT" != "$FZF_TOTAL_COUNT" ] && printf " (全%s)" "$FZF_TOTAL_COUNT" )"' \
    --header='ウィンドウ切り替え (★=現在地 / 🤖=Claude Code / C-g=★へ / C-r=名前変更 / C-e=メモ / 番号入力で絞り込み)' \
    --color=fg:#a9b1d6,hl:#f5c2e7,fg+:#a6e3a1,bg+:#1a1b26,hl+:#fab387 \
    --bind "start:transform(${SELF:q} jump)" \
    --bind "ctrl-g:transform(${SELF:q} jump)" \
    --bind "ctrl-r:execute(${SELF:q} rename {})+reload-sync(${SELF:q} list)+transform(${SELF:q} jump)" \
    --bind "ctrl-e:execute(${SELF:q} note {})+reload-sync(${SELF:q} list)+transform(${SELF:q} jump)" \
  )" || return 0
  [[ -z "$sel" ]] && return 0
  tmux switch-client -t "$(target_of "$sel")"
}

case "${1:-}" in
  list)   cmd_list ;;
  jump)   cmd_jump ;;
  rename) shift; cmd_rename "${1:-}" ;;
  note)   shift; cmd_note "${1:-}" ;;
  "")     cmd_pick ;;
  *)      print -u2 -r -- "usage: $0 [list|jump|rename <line>|note <line>]"; exit 2 ;;
esac
