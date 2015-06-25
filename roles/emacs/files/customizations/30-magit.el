; Borrowed from https://github.com/ajtulloch/dots/blob/cellar-emacs/emacs/customizations/30-magit.el
(require 'magit)

(setq magit-last-seen-setup-instructions "1.4.0")

(defadvice magit-status (around magit-fullscreen activate)
  "Make magit-status run alone in a frame."
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restore the previous window configuration and kill the magit buffer."
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

(provide '30-magit)
