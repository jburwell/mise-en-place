#!/bin/bash

INITIAL_DIR="$(pwd)"

# Bail on error ...
set -e

# TODO Add command line options for the mis-en-place repo URL, mis-en-place home directory, Homebrew home directory, Ruby version, and repo branch

echo -n "Sudo password: "
read -s SUDO_PASSWORD
echo

BREW_HOME="$HOME/.homebrew"

MISE_HOME="$HOME/.mise"
MISE_REPO="git@github.com:jburwell/mis-en-place.git"
MISE_BRANCH="master"

BOOTSTRAP_PACKAGES="git asdf readline openssl xz"

install_xcode_cmdln_tools() {
  if [ ! "$(xcode-select --print-path 2>/dev/null)" ]; then
    echo "$SUDO_PASSWORD" | sudo -S /usr/bin/xcode-select --install 2>/dev/null
    sleep 5
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
}

install_bootstrap_packages() {
  if [ ! -d "$BREW_HOME" ]; then
    echo "Installing Homebrew into $BREW_HOME"
    mkdir -p "$BREW_HOME"
    curl -L https://github.com/mxcl/homebr -alw/tarball/master | tar xz --strip 1 -C "$BREW_HOME"
  else
    echo "Homebrew is already installed in $BREW_HOME."
  fi

  INSTALLED_PACKAGES="$(brew list)"

  export PATH="$BREW_HOME/bin:$PATH"
  INSTALLED_PACKAGES=$(brew list)
  PACKAGES_TO_INSTALL=()
  for PACKAGE in "$BOOTSTRAP_PACKAGES"
  do
    if ! [[ "$(echo $INSTALLED_PACKAGES | grep -c -s $PACKAGE)" -eq "0" ]]; then
      PACKAGES_TO_INSTALL+="$PACKAGE"
    fi
  done

  if [[ ${#PACKAGES_TO_INSTALL[@]} -gt 0 ]]; then
    brew install "$PACKAGES_TO_INSTALL"
  else
    echo "All bootstrap packages are installed"
  fi
}

clone_mise_repo() {
  if [ ! -d "$MISE_HOME/.git" ]; then
    echo "Cloning mise-en-place $MISE_REPO into $MISE_HOME"
    git clone "$MISE_REPO $MISE_HOME"
    echo "Switching to mis-en-place branch $MISE_BRANCH"
    cd "$MISE_HOME"
    git checkout "$MISE_BRANCH"
  fi
}

install_python_and_mise_dependencies() {

  source "$BREW_HOME/opt/asdf/asdf.sh"
  asdf plugin-add python
  asdf install

#  cd $HOME
#  eval "$(pyenv init -)"
#
#  if [ ! "$(pyenv versions | grep $PYTHON_VERSION)" ]; then
#    pyenv install -v 2.7.11
#    pip install --upgrade pip
#    pyenv rehash
#  fi

#  ENV_NAME="$(cat $MISE_HOME/.python-version)"
#  if [ ! "$(pyenv versions | grep $ENV_NAME > /dev/null)" ]; then
#    pyenv virtualenv $PYTHON_VERSION $ENV_NAME
#    pyenv rehash
#  fi

#  cd "$MISE_HOME"
#  pip install -r requirements.txt
}

install_xcode_cmdln_tools
install_bootstrap_packages
clone_mise_repo
install_python_and_mise_dependencies

cd "$INITIAL_DIR"
