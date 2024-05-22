# ~/.zshrc

# 補完機能の初期化
# autoload -Uz compinit
# compinit -u

# asdfの初期化
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Poetry の設定
export PATH="$HOME/.poetry/bin:$PATH"

# Load all config files from ~/dotfile/zsh/config
for config_file in ~/dotfile/zsh/config/*.zsh; do
  source $config_file
done

PATH=~/.console-ninja/.bin:$PATH