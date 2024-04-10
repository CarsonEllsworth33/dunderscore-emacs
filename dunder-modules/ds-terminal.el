;;; ds-terminal --- my personal config for all things eterminal related
;;; Commentary:
;;; Code:
(use-package term
  :commands term
  :config
  (setq explicit-shell-file-name "bash") ;; can also use zsh etc
  ;;(setq explicit-zsh-args '())
  )

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
  ;;(setq vterm-shell "zsh")                       ;; Set this to customize the shell to launch
  (setq vterm-max-scrollback 10000))

(provide 'ds-terminal)
;;; ds-terminal.el ends here
