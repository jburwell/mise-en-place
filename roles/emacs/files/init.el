; Borrowed from http://tullo.ch/articles/modern-emacs-setup/
(require 'cask "~/.homebrew/opt/cask/cask.el")
(cask-initialize)

(mapc 'load (directory-files "~/.emacs.d/customizations" t "^[0-9]+.*\.el$"))

