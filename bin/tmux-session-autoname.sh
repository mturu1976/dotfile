#!/bin/zsh
# 番号だけの名前のセッション（名前なし new-session で作られたもの）を
# カレントディレクトリ名にリネームする。既存名と衝突すれば name-2, name-3 … を付ける。
#
# 使い方:
#   tmux-session-autoname.sh <session_name>   そのセッションだけ処理（session-created フック用）
#   tmux-session-autoname.sh --all            今ある番号セッションを全部処理

set -u

rename_one() {
  local sess="$1" base name n
  [[ "$sess" =~ '^[0-9]+$' ]] || return 0
  # "=name:" で「そのセッションのアクティブウィンドウ」を明示（"=name" だけだとペイン指定扱いで空になる）
  base="$(tmux display-message -p -t "=${sess}:" '#{b:pane_current_path}' 2>/dev/null)"
  [[ -z "$base" ]] && return 0
  name="$base"
  n=1
  while tmux has-session -t "=${name}" 2>/dev/null; do
    n=$((n + 1))
    name="${base}-${n}"
  done
  tmux rename-session -t "=${sess}" "$name" && print -r -- "${sess} -> ${name}"
}

case "${1:-}" in
  --all)
    tmux list-sessions -F '#{session_name}' \
      | grep -E '^[0-9]+$' | sort -n \
      | while IFS= read -r s; do rename_one "$s"; done
    ;;
  "")
    print -u2 -r -- "usage: $0 <session_name> | --all"; exit 2 ;;
  *)
    rename_one "$1" ;;
esac
