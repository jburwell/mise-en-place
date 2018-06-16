#!/bin/bash

INITIAL_DIR="$(pwd)"

# Bail on error ...
set -e

# TODO Add command line options for the mis-en-place repo URL, mis-en-place home directory, Homebrew home directory, Ruby version, and repo branch

echo -n "Sudo password: "
read -s SUDO_PASSWORD
echo

MISE_HOME="$HOME/.mise"
MISE_REPO="git@github.com:jburwell/mis-en-place.git"
MISE_BRANCH="master"

PYTHON_VERSION="system"

OPTIND=1

while getopts "hd" opt; do
  case "$opt" in
    h)
      show_help
      exit 0
      ;;
    d)
      echo "Debug mode enabled"
      set -x
      ;;
    *) 
      show_help >&2
      exit 1
      ;;
  esac
done

shift "$((OPTIND-1))"

show_help() {
cat << EOF
Usage: ${0##*/} [-hd]
Bootstrap a mise-en-place Debian environment.

    -h   display this help and exit
    -d   enable debug mode to output all shell script commands
EOF
}

add_line_to_file() {
  local line="$1"
  local filename="$2"

  echo "Checking if $line is in $filename"
  if [ ! $(grep -q $line $filename) ]; then
    echo "Adding $line to $filename"
    echo "$line" >> "$filename"
  fi
}

install_bootstrap_packages() {
  echo "$SUDO_PASSWORD" | sudo -S apt-get install curl git
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
  local pyenv_home="$HOME/.pyenv"
  echo "Checking that pyenv is installed in $pyenv_home"
  if [ ! -d "$pyenv_home" ]; then
    echo "Installing pyenv into $pyenv_home"
    git clone https://github.com/pyenv/pyenv.git "$pyenv_home"
  fi

  local pyenv_bin_dir="$pyenv_home/bin"
  echo "Checking that $pyenv_bin_dir is in the PATH"
  if [ ! $(echo "$PATH" | grep -q "$pyenv_bin_dir") ]; then
    echo "Adding $pyenv_home to the beginning of the PATH"
    PATH="$pyenv_bin_dir:$PATH"
  fi

  local pyenv_virtualenv_root="$(pyenv root)/plugins/pyenv-virtualenv"
  echo "Checking for the pyenv virtualenv plugin in $pyenv_virtualenv_root"
  if [ ! -d "$pyenv_virtualenv_root" ]; then
    echo "Installing the pyenv virtualenv plugin into $pyenv_virtualenv_root"
    git clone https://github.com/pyenv/pyenv-virtualenv.git "$pyenv_virtualenv_root"
  fi

  add_line_to_file "export PYENV_ROOT=$pyenv_home" $HOME/.bash_profile
  add_line_to_file 'export PATH="$PYENV_ROOT/bin:$PATH"' $HOME/.bash_profile
  add_line_to_file "$(pyenv init -)" $HOME/.bash_profile
  add_line_to_file "$(pyenv virtualenv-init -)" $HOME/.bash_profile

  echo "Checking for Python $PYTHON_VERSION installed into pyenv"
  if [ ! $(pyenv versions | grep -q "$PYTHON_VERSION") ]; then
    if [ "$PYTHON_VERSION" != "system" ]; then
      echo "$SUDO_PASSWORD" | sudo -S apt-get install build-essential libbz2-dev libreadline-dev libssl-dev
      pyenv install -v "$PYTHON_VERSION"
      pyenv rehash
    fi
  fi
  
  if [ "$PYTHON_VERSION" == "system" ]; then
    echo "$SUDO_PASSWORD" | sudo -S apt-get install python-pip virtualenv
  fi

  local env_name="mise"
  add_line_to_file $env_name "$MISE_HOME/.python-version"
  echo "Checking that the $env_name pyenv has been created"
  if [ ! $(pyenv virtualenvs | grep -q $env_name) ]; then
    pyenv virtualenv $PYTHON_VERSION $env_name
    pyenv rehash
  fi

  cd "$MISE_HOME"
  pip install --upgrade pip
  pip install -r requirements.txt
}

install_bootstrap_packages
clone_mise_repo
install_python_and_mise_dependencies

cd "$INITIAL_DIR"

exit 0
