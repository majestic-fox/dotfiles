#!/bin/sh

# Dotfiles installer
# Installs git, clones repository and symlinks dotfiles to your home directory

e='\033'
RESET="${e}[0m"
BOLD="${e}[1m"
CYAN="${e}[0;96m"
RED="${e}[0;91m"
YELLOW="${e}[0;93m"
GREEN="${e}[0;92m"

# Success reporter
info() {
  echo ; echo "${CYAN}${BOLD}${*}${RESET}" ; echo
}

# Error reporter
error() {
  echo ; echo "${RED}${BOLD}${*}${RESET}" ; echo
}

# Success reporter
success() {
  echo ; echo "${GREEN}${BOLD}${*}${RESET}" ; echo
}

# Set directory
export DOTFILES=${1:-"$HOME/Dotfiles"}

# Preinstall
if ! hash git 2>/dev/null ; then
  if [ `uname` == 'Darwin' ]; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # Install Git
    brew install git
    # Install zsh
    brew install zsh
  elif [ `uname` == 'Linux' ]; then
    # Install Git with apt-get
    sudo apt-get install git zsh xclip
  else
    error "Error: Git and Zsh are required."
    exit
  fi
fi

# Install Powerline fonts
if brew cask ls --versions font-source-code-pro > /dev/null; then
  echo "Cask font-source-code-pro is already installed"
else
  brew tap caskroom/fonts && brew cask install font-source-code-pro
fi


# Registers zsh as a default shell
zsh_path=$(which zsh)
info "Path to Zsh: $zsh_path. Enter your password to change default shell:"
grep -Fxq "$zsh_path" /etc/shells || sudo bash -c "echo $zsh_path >> /etc/shells"
sudo chsh -s "$zsh_path" $USER || error "Error: Cannot set zsh as default shell!"

if [ ! -d $DOTFILES ]; then
  git clone https://github.com/majestic-fox/dotfiles.git $DOTFILES
  if [ -d $DOTFILES ]; then
    cd $DOTFILES && make sync && cd -
  else
    error "Error: Dotfiles weren't installed into $DOTFILES."
    exit
  fi
fi

# Problem with not interactive shell
# http://askubuntu.com/a/77053
PS1='$>'
if [ -d $DOTFILES ]; then
  cd $DOTFILES && make sync && cd -
  success "Dotfiles installed successfully!"
else
  error "Error: Dotfiles didn't installed!"
  exit 1
fi

success "Please restart your terminal!"

echo
echo $RED'-_-_-_-_-_-_-_'$RESET$BOLD',------,'$RESET
echo $YELLOW'_-_-_-_-_-_-_-'$RESET$BOLD'|   /\_/\\'$RESET
echo $GREEN'-_-_-_-_-_-_-'$RESET$BOLD'~|__( ^ .^)'$RESET
echo $CYAN'-_-_-_-_-_-_-_-'$RESET$BOLD'""  ""'$RESET
echo
