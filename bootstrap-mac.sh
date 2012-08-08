#/bin/bash

# TODO Add command line options for the mis-en-place repo URL, mis-en-place home directory, Homebrew home directory, Ruby version, and repo branch

CMD_LINE_TOOLS_HOME="/usr/llvm-gcc-4.2"
BREW_HOME=$HOME/.homebrew
MIS_HOME=$HOME/.mis

RUBY_VERSION=1.9.3-p194
MIS_GEMSET=mis

BOOTSTRAP_PACKAGES="git rbenv rbenv-gemset ruby-build"

# Download and install the XCode command line tools required by Homebrew ...
if [ ! -d $CMD_LINE_TOOLS_HOME ]; then

  WORK_DIR=`mktemp -d $HOME/mies-work.XXXXXX`

  echo "Downloading the XCode command line tools to $WORK_DIR"
  $CMD_LINE_TOOLS=$WORK_DIR/xcode_command_line_tools.dmg
  curl -o $CMD_LINE_TOOLS http://dl.dropbox.com/u/3254149/command_line_tools_for_xcode_june_2012.dmg

  echo "Installing XCode command line tools from $CMD_LINE_TOOLS"
  hdiutil attach $CMD_LINE_TOOLS
  cd /Volumes/Command\ Line\ Tools/Packages
  sudo /usr/sbin/installer -pkg DeveloperToolsCLI.pkg -target /
  hdiutil detach $CMD_LINE_TOOLS
  
  rm -rf $WORK_DIR

else
  echo "The XCode Command Line tools are already installed in $CMD_LINE_TOOLS_HOME"
fi

echo "Configuring the PATH for Homebrew and rbenv"
PATH=$HOME/.rbenv/bin:$BREW_HOME/bin:$PATH

if [ ! -d $BREW_HOME ]; then
  echo "Installing Homebrew into $BREW_HOME"
  mkdir -p $BREW_HOME
  curl -L https://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C $BREW_HOME
else
  echo "Homebrew is already installed in $BREW_HOME.  Performing an upgrade."
  brew update
  brew upgrade
fi

echo "Installing bootstrap packages $BOOTSTRAP_PACKAGES"
brew install $BOOTSTRAP_PACKAGES

echo "Initializing rbenv and installing Ruby version $RUBY_VERSION"
eval "$(rbenv init -)"

if [ `rbenv versions | grep $RUBY_VERSION | wc -l` -ne 1 ]; then
  rbenv install $RUBY_VERSION
  rbenv rehash
else 
  echo "Ruby version $RUBY_VERSION is already installed."
fi

if [ ! -d $MIS_HOME ]; then
  echo "Pulling mis-en-place from Github into $MIS_HOME"
  mkdir -p $MIS_HOME
  cd $MIS_HOME
  git clone git://github.com/jburwell/mis-en-place.git $MIS_HOME
else
  echo "Updating mis-en-place from Github into $MIS_HOME"
  cd $MIS_HOME
  git pull
fi

echo "Setting the local Ruby version to $RUBY_VERSION in $MIS_HOME and activating the local gemset"
if [ `rbenv gemset list | grep $MIS_NAME | wc -l` -ne 1]; then
  rbenv gemset create $RUBY_VERSION $MIS_GEMSET
fi

if [ -f $MIS_HOME/.rbenv-gemsts ]; then
  > $MIS_HOME/.rbenv-gemsets <<< $MIS_GEMSET
fi

if [ `rbenv local` -eq "rbenv: no local version configured for this directory" ]; then
  rbenv local $RUBY_VERSION
  rbenv rehash
fi

rbenv-gemset active

#echo "Running Puppet to perform local configuration"
#puppet apply config/site.pp --modulepath=config/modules

