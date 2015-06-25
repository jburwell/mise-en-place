; Borrowed from https://github.com/ajtulloch/dots/blob/cellar-emacs/emacs/customizations/50-misc.el
(add-hook 'markdown-mode-hook '(lambda ()
                                 (setq paragraph-start "\\*\\|$"
                                       paragraph-separate "$")
                                 (local-set-key [tab] 'yas/expand)))

(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(provide '20-markdown.el)
