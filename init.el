;;; dunderscore.el --- my personal config
;;; Commentary:
;; ----------------------------------------------------------
;; Table of Contents
;; 1 - Initializing Environment
;; 2 - Packages
;; 3 - Key Bindings
;; ----------------------------------------------------------
;; Contributor(s)
;; Carson Ellsworth
;; ----------------------------------------------------------
;; ----------------------------------------------------------
;; ----------------------------------------------------------

;;; Code:


;; 1.
;; Initializing Emacs Environment
;; ----------------------------------------------------------
;; ----------------------------------------------------------
;; ----------------------------------------------------------

;; Inhibit startup message
(setq inhibit-startup-message t)
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacs_saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)

(scroll-bar-mode -1)      ; Disable visible scrollbar
(tool-bar-mode -1)        ; Disable visible toolbar
(tooltip-mode -1)         ; Disable tooltips
(set-fringe-mode nil)     ; Set fringe to default 8 pixels

(menu-bar-mode -1)        ; Disable the menu bar

;; Set up Visual Bell
(setq visual-bell t)

(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

;; 2.
;; Packages to be used by the config
;; ----------------------------------------------------------
;; ----------------------------------------------------------
;; ----------------------------------------------------------


;; (load dunderpackages.el)
;; For now just load packages in init.el
(setq dunderscore-module-path-prefix "~/workspace/git-repos/dunderscore-emacs/dunder-modules/")
(load (concat dunderscore-module-path-prefix "ds-package-manager.el"))

(use-package no-littering)
(setq auto-save-file-name-transforms
      `((".*",(no-littering-expand-var-file-name "auto-save/") t)))

(use-package which-key
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3))

(use-package command-log-mode
  :commands command-log-mode)

(use-package doom-themes
  :init (load-theme 'doom-palenight t))

(use-package all-the-icons)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(load (concat dunderscore-module-path-prefix "ds-lsp.el"))
(load (concat dunderscore-module-path-prefix "ds-evil.el"))
(load (concat dunderscore-module-path-prefix "ds-keybindings.el"))
(load (concat dunderscore-module-path-prefix "ds-completion.el"))
(load (concat dunderscore-module-path-prefix "ds-directory.el"))
(load (concat dunderscore-module-path-prefix "ds-flycheck.el"))
(load (concat dunderscore-module-path-prefix "ds-magit.el"))
(load (concat dunderscore-module-path-prefix "ds-python.el"))
(load (concat dunderscore-module-path-prefix "ds-rust.el"))
(load (concat dunderscore-module-path-prefix "ds-terminal.el"))
(load (concat dunderscore-module-path-prefix "ds-treesit.el"))

;; Defuns
;; ----------------------------------------------------------
;; ----------------------------------------------------------
;; ----------------------------------------------------------
(setq dunderscore-theme-list '(doom-tokyo-night doom-palenight doom-old-hope doom-snazzy doom-gruvbox))
(setq dunderscore-theme-iterator 0)
(defun dunderscore-swap-theme () (interactive)
  (setq dunderscore-theme-iterator (mod (+ dunderscore-theme-iterator 1) (length dunderscore-theme-list)))
  (load-theme (nth dunderscore-theme-iterator dunderscore-theme-list)))

(provide 'init)
;;; init.el ends here
