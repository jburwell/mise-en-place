(add-to-list 'load-path "/Users/jburwell/bin/erlang-R16B02-bash04/lib/erlang/lib/eqc-1.30.5/emacs/")
(autoload 'eqc-erlang-mode-hook "eqc-ext" "EQC Mode" t)
(add-hook 'erlang-mode-hook 'eqc-erlang-mode-hook)
(setq eqc-max-menu-length 30)
(setq eqc-root-dir "/Users/jburwell/bin/erlang-R16B02-bash04/lib/erlang/lib/eqc-1.30.5")

(provide '50-eqc)
