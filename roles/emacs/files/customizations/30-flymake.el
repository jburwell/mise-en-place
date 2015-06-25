(require 'flymake)
(setq flymake-log-level 5)
(setq flymake-start-syntax-check-on-newline nil)
(setq flymake-no-changes-timeout 240)
 
(defun flymake-compile-script-path (path)
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list path (list local-file))))

(custom-set-faces
   '(flymake-errline ((((class color)) (:underline "red"))))
   '(flymake-warnline ((((class color)) (:underline "yellow")))))

(provide '30-flymake)
