# 環境変数の設定
export PATH=/usr/local/bin:$PATH
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=50000
export SAVEHIST=600000

# emacs build
#export PATH="/usr/local/opt/texinfo/bin:$PATH"
#export PATH="/usr/local/sbin:$PATH"

# poetry
# export PATH="$HOME/.poetry/bin:$PATH"

# tcl-tk
export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/tcl-tk/lib"
export CPPFLAGS="-I/usr/local/opt/tcl-tk/include"
export PKG_CONFIG_PATH="/usr/local/opt/tcl-tk/lib/pkgconfig"
export PYTHON_CONFIGURE_OPTS="--with-tcltk-includes='-I/usr/local/opt/tcl-tk/include' --with-tcltk-libs='-L/usr/local/opt/tcl-tk/lib -ltcl8.6 -ltk8.6'"

#Tesseractに日本語対応
export TESSDATA_PREFIX=/opt/homebrew/share/tessdata/

# Git
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export GIT_PAGER="less -R"