* [] create asdf role to manage versions of java, ruby, node, python, and 
* [] depend on node.js role to install and configure node and npm -> asdf role
* [] depend on git role to install and configure git -> asdf role
* [] depend on ruby role to install and configure ruby and gem -> asdf role
* [] depend on python role to install and configure python and pip -> asdf role

xclip
clipster -> xclip
vim (vimdiff) -> Clipboard Manager
kdiff
zsh
git -> kdiff, vim
oh-my-zh -> zsh, git
asdf -> oh-my-zsh, git
node -> oh-my-zsh, git, asdf
pythoni (pyenv, pip) -> asdf, oh-my-zsh
ruby -> oh-my-zsh, asdf
emacs -> node, python, ruby, git, clipster
java -> asdf, oh-my-zsh
clojure -> asdf, java, oh-my-zsh, emacs
tmux -> oh-my-zsh
maven -> java
gradle -> java
intellij -> java, maven, gradle
pycharm -> python
