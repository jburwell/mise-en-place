ulimit -n 10000

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOCONNECT=true
ZSH_TMUX_AUTOQUIT=false

plugins=(asdf git mvn gradle vagrant lein pip python pyenv rake rbenv rebar ruby sudo zsh-syntax-highlighting aws)

for file in $HOME/.zsh.d/*.sh
do
  source $file
done

. $ZSH/oh-my-zsh.sh

