# HOMEBREW_PREFIX は .zshrc で設定済み（arm64: /opt/homebrew、x86_64: /usr/local）

# ヒストリー設定は .zshrc で起動時に定義済み

# tcl-tk（Pythonビルド時の tkinter 対応）
export PATH="$HOMEBREW_PREFIX/opt/tcl-tk/bin:$PATH"
export LDFLAGS="-L$HOMEBREW_PREFIX/opt/tcl-tk/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/tcl-tk/include"
export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/tcl-tk/lib/pkgconfig"
export PYTHON_CONFIGURE_OPTS="--with-tcltk-includes='-I$HOMEBREW_PREFIX/opt/tcl-tk/include' --with-tcltk-libs='-L$HOMEBREW_PREFIX/opt/tcl-tk/lib -ltcl8.6 -ltk8.6'"

# Tesseractに日本語対応
export TESSDATA_PREFIX="$HOMEBREW_PREFIX/share/tessdata/"

# Git
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export GIT_PAGER="less -R"