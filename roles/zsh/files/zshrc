source $HOME/.zshenv

# SSH key setup ...
# TODO Move to an oh-my-zsh plugin
KEYCHAIN_CMD=$(type keychain > /dev/null 2>&1)
if [ "$KEYCHAIN_CMD" -eq "0" ]; then
  for KEY_FILE in $HOME/.ssh/*.ssh
  do
    keychain $KEY_FILE
  done

  source $HOME/.keychain/$HOST-sh
fi

# TODO Move to an oh-my-zsh plugin
# Alias definitions ...
alias grep='grep --color=auto'

COLORDIFF_CMD=$(type colordiff > /dev/null 2>&1)
if [ "$COLORDIFF_CMD" -eq "0" ]; then
  alias diff='colordiff'
fi

# TODO Move to an on-my-zsh plugin
HIGHLIGHT_CMD=$(type highlight > /dev/null 2>&1)
if [ "$HIGHLIGHT_CMD" -eq "0" ]; then
  export LESSOPEN="| $(which highlight) %s --out-format xterm256 --line-numbers --quiet --force --style solarized-dark"
else
  alias less='less -m -N -g -i -J --line-numbers --underline-special'
fi

export LESS=" -R"
alias more='less'

# TODO Move to an oh-my-zsh plugin
alias gw='./gradlew'
alias grepl='gw javarepl --console plain --no-daemon'
