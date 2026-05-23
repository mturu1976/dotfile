alias ls='eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions'
alias ll='ls --git --time-style=long-iso -gl'
alias la='ls --git --time-style=long-iso -agl'
alias l1='eza -1'

# cdは標準のまま維持（Claude Codeなどのツールとの互換性のため）
# zoxideのスマートジャンプは`z`コマンドで手動使用
# 例: `z proj` でプロジェクトディレクトリにジャンプ

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

alias cot="open -a /Applications/CotEditor.app"

alias vim='nvim'
alias sakiokuri0="timer 8m && terminal-notifier -message 'Pomodoro'\
-title 'ワークタイマー作動 休憩 😀'\
-appIcon ' -/Pictures/pumpkin.png'\
-sound Crystal"

alias work="timer 8m && terminal-notifier -message 'Pomodoro'\
-title 'work Timer is up! Take a Break 😀'\
-appIcon ' -/Pictures/pumpkin.png'\
-sound Crystal"

# 他のalias

# Git
# fgc (git checkout) - checkout git branch including remote branches
# ref: https://qiita.com/kamykn/items/aa9920f07487559c0c7e
fgc() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# flog - git commit browser
# ref: https://qiita.com/kamykn/items/aa9920f07487559c0c7e
flog() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(#C0C0C0)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
              (grep -o '[a-f0-9]\{7\}' | head -1 |
              xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
              {}
              FZF-EOF
             "
}

# fd - cd to selected directory
# https://qiita.com/kamykn/items/aa9920f07487559c0c7e
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fadd: git add / diff をインタラクティブに．Ctrl-d で diff, Enter で add
# https://qiita.com/reviry/items/e798da034955c2af84c5
fadd() {
  local out q n addfiles
  while out=$(
      git status --short |
      awk '{if (substr($0,2,1) !~ / /) print $2}' |
      fzf-tmux --multi --exit-0 --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    n=$[$(wc -l <<< "$out") - 1]
    addfiles=(`echo $(tail "-$n" <<< "$out")`)
    [[ -z "$addfiles" ]] && continue
    if [ "$q" = ctrl-d ]; then
      git diff --color=always $addfiles | less -R
    else
      git add $addfiles
    fi
  done
}

# fzf

# zoxide の履歴からディレクトリを fzf で選んで移動（^z）
fzf-z-search() {
    local res=$(zoxide query --list | fzf)
    if [ -n "$res" ]; then
        BUFFER+="cd $res"
        zle accept-line
    else
        return 1
    fi
}

zle -N fzf-z-search
bindkey '^z' fzf-z-search
