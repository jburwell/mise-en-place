#!/bin/bash

INITIAL_DIR="$(pwd)"

# Bail on error ...
set -e

# TODO only prompt if the SUDO_PASSWORD environment variable is not set or it is not passed through a temp file
echo -n "Sudo password: "
read -s SUDO_PASSWORD
echo

MISE_HOME="$HOME/.mise"
MISE_REPO="git@github.com:jburwell/mis-en-place.git"
MISE_BRANCH="master"

PYTHON_VERSION="system"

OPTIND=1

while getopts "b:dhp:r:" opt; do
  case "$opt" in
    b)
      MISE_BRANCH="$OPTARG"
      ;;
    d)
      echo "Debug mode enabled"
      set -x
      ;;
    h)
      show_help
      exit 0
      ;;
    p)
      PYTHON_VERSION="$OPTARG"
      ;;
    r)
      MISE_REPO="$OPTARG"
      ;;
    *)
      echo "Unknown command line option: $opt" >&2
      show_help >&2
      exit 1
      ;;
  esac
done

shift "$((OPTIND-1))"

show_help() {
cat << EOF
Usage: ${0##*/} [-b branch name] [-dh] [-p python version] [-r repo_url]
Bootstrap a mise-en-place Debian environment

    -b    mise-en-place branch from which to operate (default: $MISE_BRANCH)
    -d    enable debug mode to output all shell script commands
    -h    display this help message and exit
    -p    pyenv-compatible Python version for Ansible (default: $PYTHON_VERSION)
    -r    the git URL of the mise-en-place repository (default: $MISE_REPO)
EOF
}

add_line_to_file() {
  local line="$1"
  local filename="$2"

  if [ ! -e $filename ]; then
    echo "Creating $filename with line $line"
    echo "$line" > "$filename"
  fi

  echo "Checking if $line is in $filename"
  if ! $(grep -qx "$line" $filename > /dev/null); then
    echo "Adding $line to $filename"
    echo "$line" >> "$filename"
  fi
}

install_packages() {
  echo "$SUDO_PASSWORD" | sudo -S apt-get -y install $* > /dev/null
}

install_bootstrap_packages() {
  install_packages curl git
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
  local bash_profile_path="$HOME/.bash_profile"

  echo "Checking that pyenv is installed in $pyenv_home"
  if [ ! -d "$pyenv_home" ]; then
    echo "Installing pyenv into $pyenv_home"
    git clone https://github.com/pyenv/pyenv.git "$pyenv_home"
  fi

  local pyenv_bin_dir="$pyenv_home/bin"
  echo "Checking that $pyenv_bin_dir is in the PATH"
  if [ ! $(echo "$PATH" | grep -q "$pyenv_bin_dir" > /dev/null) ]; then
    echo "Adding $pyenv_home to the beginning of the PATH"
    PATH="$pyenv_bin_dir:$PATH"
  fi

  local pyenv_virtualenv_root="$(pyenv root)/plugins/pyenv-virtualenv"
  echo "Checking for the pyenv virtualenv plugin in $pyenv_virtualenv_root"
  if [ ! -d "$pyenv_virtualenv_root" ]; then
    echo "Installing the pyenv virtualenv plugin into $pyenv_virtualenv_root"
    git clone https://github.com/pyenv/pyenv-virtualenv.git "$pyenv_virtualenv_root"
  fi

  echo "Adding pyenv configuration to $bash_profile_path"
  add_line_to_file "export PYENV_ROOT=$pyenv_home" $bash_profile_path
  add_line_to_file 'export PATH="$PYENV_ROOT/bin:$PATH"' $bash_profile_path
  add_line_to_file "pyenv init -" $bash_profile_path
  add_line_to_file "pyenv virtualenv-init -" $bash_profile_path

  echo "Loading $bash_profile_path into the current shell"
  source $bash_profile_path > /dev/null

  echo "Checking for Python version $PYTHON_VERSION installed into pyenv"
  if ! $(pyenv versions | grep -q "$PYTHON_VERSION" > /dev/null); then
    if [ "$PYTHON_VERSION" != "system" ]; then
      echo "Installing dependencies required by python build"	
      install_packages build-essential libbz2-dev libreadline-dev libssl-dev
      pyenv install -v "$PYTHON_VERSION"
      pyenv rehash
    fi
  fi
  
  if [ "$PYTHON_VERSION" == "system" ]; then
    install_packages python-pip virtualenv
  fi

  local env_name="mise"
  add_line_to_file $env_name "$MISE_HOME/.python-version"
  echo "Checking that the $env_name pyenv has been created"
  if ! $(pyenv virtualenvs | grep -q $env_name > /dev/null); then
    pyenv virtualenv $PYTHON_VERSION $env_name
    pyenv rehash
  fi

  cd "$MISE_HOME"
  if [ "$PYTHON_VERSION" != "system" ]; then
    echo "Upgrading pip"
    pip install --upgrade pip
  fi
  echo "Installing mise Python requirements"
  pip install -r requirements.txt
}

install_bootstrap_packages
clone_mise_repo
install_python_and_mise_dependencies

cd "$INITIAL_DIR"

exit 0
