# Path favoring /usr/local for brew ...
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share/npm.bin:/opt/local/bin:/opt/local/sbin:$PATH

# Java configuration
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home

# Node configuration
export NODE_PATH=/usr/local/lib/node

# Terminal coloration
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

# EC2 Tools Setup
export EC2_PRIVATE_KEY="$(/bin/ls $HOME/.ec2/pk-*.pem)"
export EC2_CERT="$(/bin/ls $HOME/.ec2/cert-*.pem)"
export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.3-57419/jars"

# Pager configuration
export PAGER='/usr/bin/less -N'
export MANPAGER=/usr/bin/less 

# TextMate configuration based on 
# http://manual.macromates.com/en/using_textmate_from_terminal.html
export EDITOR='/usr/local/bin/mate -w'
export SVN_EDITOR=$EDITOR
export GIT_EDITOR='/usr/local/bin/mate -wll'
export LESSEDIT='/usr/local/bin/mate -l %lm %f'

# rvm configuration ...
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# virtualenvwrapper configuration ...
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh