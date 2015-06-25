; Borrowed from https://github.com/flyingmachine/emacs-for-clojure/blob/master/vendor/clojure.el
(require 'paredit)
(require 'starter-kit-lisp)
(require 'clojure-mode)
; Re-enable when a 24.5.1 compatible package is available
;(require 'clojure-test-mode)

(font-lock-add-keywords
 'clojure-mode
 (mapcar
  (lambda (pair)
    `(,(car pair)
      (0 (progn (compose-region
                 (match-beginning 0) (match-end 0)
                 ,(cadr pair))
                nil))))
  '(("\\<fn\\>" ?ƒ)
    ("\\<comp\\>" ?∘)
    ("\\<partial\\>" ?þ)
    ("\\<complement\\>" ?¬))))

; Re-enable when a 24.5.1 compatible package is available
;(add-to-list 'ac-modes 'nrepl-mode)
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))

(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook 'paredit-mode)
(add-hook 'ielm-mode-hook 'paredit-mode)
(add-hook 'lisp-mode-hook 'paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'paredit-mode)
(add-hook 'scheme-mode-hook 'paredit-mode)

(provide '20-clojure)

