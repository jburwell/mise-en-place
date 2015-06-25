#!/bin/bash

INITIAL_DIR="$(pwd)"

# Bail on error ...
set -e

# TODO Add command line options for the mis-en-place repo URL, mis-en-place home directory, Homebrew home directory, Ruby version, and repo branch

echo -n "Sudo password: "
read -s SUDO_PASSWORD
echo

BREW_HOME="$HOME/.homebrew"
BREW_CASK_HOME="$HOME/.brew-cask"

MISE_HOME="$HOME/.mise"
MISE_REPO="git@github.com:jburwell/mis-en-place.git"
MISE_BRANCH="master"

BOOTSTRAP_PACKAGES="git ansible caskroom/cask/brew-cask"

# Download and install the XCode command line tools required by Homebrew ...
if [ ! "$(xcode-select --print-path 2>/dev/null)" ]; then
  echo $SUDO_PASSWORD | sudo -S /usr/bin/xcode-select --install 2>/dev/null
  sleep 1
  osascript <<EOD
    tell application "System Events"
      tell process "Install Command Line Developer Tools"
        keystroke return
        click button "Agree" of window "License Agreement"
      end tell
    end tell
EOD

  while true; do
    sleep 5

    if [ -n "$(xcode-select --print-path 2>/dev/null)" ]; then
      break;
    fi
  done
else
  echo "The XCode Command Line tools are already installed in $(xcode-select --print-path)"
fi

export PATH=$BREW_HOME/bin:$PATH
if [ ! -d $BREW_HOME ]; then
  echo "Installing Homebrew into $BREW_HOME"
  mkdir -p $BREW_HOME
  curl -L https://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C $BREW_HOME
  brew update
else
  echo "Homebrew is already installed in $BREW_HOME."
fi

brew install $BOOTSTRAP_PACKAGES

# Force initialization of Caskroom ...
mkdir -p $BREW_CASK_HOME
echo $SUDO_PASSWORD | sudo -S brew cask help > /dev/null

if [ ! -d $MISE_HOME/.git ]; then
  echo "Cloning mise-en-place $MISE_REPO into $MISE_HOME"
  git clone $MISE_REPO $MISE_HOME
  echo "Checkout mis-en-place branch $MISE_BRANCH"
  cd $MISE_HOME
  git checkout $MISE_BRANCH
else
  echo "Updating mise-en-place from Github into $MISE_HOME"
  cd $MISE_HOME
  git fetch
  git rebase
fi

cd $MISE_HOME
ansible-playbook -i inventory --connection=local -e homebrew_home=$BREW_HOME -K site.yml

cd $INITIAL_DIR
