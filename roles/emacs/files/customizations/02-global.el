;; Keeps ~Cask~ file in sync with the packages
;; that you install/uninstall via ~M-x list-packages~
(require 'pallet)
(require 'color-theme)

(defconst user-home-directory
          (or (getenv "HOME")
              (expand-file-name ".." user-emacs-directory))
          "The user's home directory.")

;; Don't show startup screen
(setq inhibit-startup-screen t)

;; Display line numbers ...
(global-linum-mode t)

;; TODO Mac OS specific -- only load on Mac OS X
(osx-clipboard-mode +1)

(load-theme 'solarized t)
(set-terminal-parameter nil 'background-mode 'dark)

;; Load theme ... 
(add-hook 'after-make-frame-functions
                    (lambda (frame)
                      (load-theme 'solarized t)
                      (setq solarized-broken-srgb nil)
                      (set-frame-parameter frame
                                           'background-mode 'dark)
                      (enable-theme 'solarized)
                     ))

;; shell scripts
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; Configure backup location and behavior
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))
(setq backup-by-copying t)
(setq delete-old-versions t
        kept-new-versions 6
          kept-old-versions 2
            version-control t)

;; Set left alt key as meta
(set-keyboard-coding-system nil)
(setq ns-left-alternate-modifier 'meta)

(provide '02-global.el)
