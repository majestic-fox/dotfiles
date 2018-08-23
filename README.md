# majestic-fox's dotfiles
Home sweet $HOME 🏠

This is my dotfiles for zsh

# Installation

### Install the theme used in these dotfiles

Clone this repo:

```zsh
git clone https://github.com/majestic-fox/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
```

Symlink `spaceship.zsh-theme` to your oh-my-zsh custom themes directory:

```zsh
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

### Install the dotfiles

If you want to install my dotfiles on your machine, just copy this command and execute in the terminal:

```sh
wget -O - https://raw.githubusercontent.com/majestic-fox/dotfiles/master/installer.sh | sh
```
