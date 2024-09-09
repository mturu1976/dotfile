# Dotfiles

```zsh
# .zshrc.dを作成
mkdir -p ~/.zshrc.d

#シンボリックリンク
ln -s ~/dotfile/zsh/alias/alias-init.zsh ~/.zshrc.d/alias-init.zsh
ln -s ~/dotfile/zsh/env/env-init.zsh ~/.zshrc.d/env-init.zsh
ln -s ~/dotfile/zsh/completion/completion-init.zsh ~/.zshrc.d/completion-init.zsh


# StartShip設定
#mkdir /Users/$USERNAME/.config/starship/
#ln -s /Users/$USERNAME/dotfile/starship/starship.toml /Users/$USERNAME/.config/starship/starship.toml

```
