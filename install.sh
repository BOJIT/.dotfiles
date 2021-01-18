#!/bin/sh

# Prerequisites:
# - git

# Check we are running as root:
if [ "$(id -u)" -ne "0" ]; then
   echo "Script must be run with root privileges!"
   exit 1
fi

# Repository Directory (for later)
starting_dir=$(pwd)

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo "Platform: ${machine}"

# Install Powerline Fonts:
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# Install Homebrew (if not present) - MacOS Only:
case $machine in
    Mac)
	if test ! $(command -v brew); then
            echo "Installing Homebrew..."
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        fi
        brew update
        ;;
    Linux)
        apt update
esac

# Install zsh (Only MacOS and Debian for now)
case $machine in
    Mac)
        brew install zsh
        ;;
    Linux)
        apt install zsh
        ;;
esac

# Set zsh as Current shell (temporary, should be changed in terminal settings)
# @TODO find way to automate this across Iterm2, Windows Terminal (WSL) and XTerm
chsh -s /bin/zsh

# Symlink dotfiles:
ln -s -f ./.config ~/.config
ln -s -f ./.oh-my-zsh ~/.oh-my-zsh
ln -s -f ./.gitconfig ~./.gitconfig
ln -s -f ./.zshrc ~/.zshrc
