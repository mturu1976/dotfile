# HOMEBREW_PREFIX は .zshrc で設定済み（arm64: /opt/homebrew、x86_64: /usr/local）
# 各項目はインストールされているマシンでのみ有効になる（存在チェック）

# tcl-tk（Pythonビルド時の tkinter 対応）
if [[ -d $HOMEBREW_PREFIX/opt/tcl-tk ]]; then
    path=("$HOMEBREW_PREFIX/opt/tcl-tk/bin" $path)
    export LDFLAGS="${LDFLAGS:+$LDFLAGS }-L$HOMEBREW_PREFIX/opt/tcl-tk/lib"
    export CPPFLAGS="${CPPFLAGS:+$CPPFLAGS }-I$HOMEBREW_PREFIX/opt/tcl-tk/include"
    export PKG_CONFIG_PATH="${PKG_CONFIG_PATH:+$PKG_CONFIG_PATH:}$HOMEBREW_PREFIX/opt/tcl-tk/lib/pkgconfig"
    export PYTHON_CONFIGURE_OPTS="--with-tcltk-includes='-I$HOMEBREW_PREFIX/opt/tcl-tk/include' --with-tcltk-libs='-L$HOMEBREW_PREFIX/opt/tcl-tk/lib -ltcl8.6 -ltk8.6'"
fi

# Tesseractに日本語対応
if [[ -d $HOMEBREW_PREFIX/share/tessdata ]]; then
    export TESSDATA_PREFIX="$HOMEBREW_PREFIX/share/tessdata/"
fi
