;; The dunderscore emacs config
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

;; Code


;; Initializing Emacs Environment
;; ----------------------------------------------------------
;; ----------------------------------------------------------
;; ----------------------------------------------------------

;; Inhibit startup message
(setq inhibit-startup-message t)



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

;; Initialize package sources
(require 'package)
(setq package-archives `(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Init use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


;; Packages to be used by the config
;; ----------------------------------------------------------
;; ----------------------------------------------------------
;; ----------------------------------------------------------

;; (load dunderpackages.el)
;; For now just load packages in init.el

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package no-littering)

(setq auto-save-file-name-transforms
      `((".*",(no-littering-expand-var-file-name "auto-save/") t)))


(use-package which-key
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  ;; (define-key evil-motion-state-map (kbd "l") 'evil-forward-char)
  ;; (define-key evil-motion-state-map (kbd "h") 'evil-backward-char)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package command-log-mode
  :commands command-log-mode)

(use-package doom-themes
  :init (load-theme 'doom-palenight t))

(use-package all-the-icons)

(use-package magit-section)
(use-package magit
  :after magit-section
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

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

(use-package dap-mode
  ;; Uncomment the config below if you want all UI panes to be hidden by default!
  ;; :custom
  ;; (lsp-enable-dap-auto-configure nil)
  ;; :config
  ;; (dap-ui-mode 1)
  :commands dap-debug
  :config
  ;; Set up Node debugging
  (require 'dap-node)
  (dap-node-setup)) ;; Automatically installs Node debug adapter if needed

(use-package python-mode
  :ensure t
  :hook (python-mode . lsp-deferred)
  :custom
  ;; NOTE: Set these if Python 3 is called "python3" on your system!
  ;; (python-shell-interpreter "python3")
  ;; (dap-python-executable "python3")
  (dap-python-debugger 'debugpy)
  :config
  (require 'dap-python))

(use-package pyvenv
  :after python-mode
  :config
  (pyvenv-mode 1))

(use-package ripgrep)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/workspace/git-repos")
    (setq projectile-project-search-path '("~/workspace/git-repos")))
  (setq projectile-switch-project-action #'projectile-dired))

;; Enable vertico
(use-package vertico
  :init
  (vertico-mode 1)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode 1))

(use-package orderless
  :ensure t
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (icomplete-mode)
  :custom (completion-styles '(orderless flex)))

(use-package ivy-rich
  :ensure counsel
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :after helpful
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil) ;; Don't start searches with ^
  (setq counsel-describe-function-function #'helpful-callable)
  (setq counsel-describe-variable-function #'helpful-variable))

(use-package helpful)

(use-package corfu
  ;; Optional customizations
  ;; :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  :init
  (global-corfu-mode))

(use-package dirvish)


;; Tree-sitter 
;; ----------------------------------------------------------
;; ----------------------------------------------------------
;; ----------------------------------------------------------

;; Language Aliases
(setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (toml "https://github.com/tree-sitter/tree-sitter-toml")
     
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

;; Check to see if language is installed
;; (treesit-language-available-p '<language>)
;; example: (treesit-language-available-p 'python)

;; Configuration
(setq major-mode-remap-alist
 '((yaml-mode . yaml-ts-mode)
   ;; (docker-mode . docker-ts-mode)
   (bash-mode . bash-ts-mode)
   (js2-mode . js-ts-mode)
   (typescript-mode . typescript-ts-mode)
   (json-mode . json-ts-mode)
   (css-mode . css-ts-mode)
   (python-mode . python-ts-mode)))


;; Defuns
;; ----------------------------------------------------------
;; ----------------------------------------------------------
;; ----------------------------------------------------------

(setq dunderscore-theme-list '(doom-tokyo-night doom-palenight doom-old-hope doom-snazzy doom-gruvbox))
(setq dunderscore-theme-iterator 0)
(defun dunderscore-swap-theme () (interactive)
  (setq dunderscore-theme-iterator (mod (+ dunderscore-theme-iterator 1) (length dunderscore-theme-list)))
  (load-theme (nth dunderscore-theme-iterator dunderscore-theme-list)))


;; Key Bindings
;; ----------------------------------------------------------
;; ----------------------------------------------------------
;; ----------------------------------------------------------

(defun my-prefix-translations (_mode mode-keymaps &rest _rest)
  (evil-collection-translate-key 'normal mode-keymaps
    "C-SPC" "SPC"))

(add-hook 'evil-collection-setup-hook #'my-prefix-translations)

;; Helpful Key Bindings
(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
(global-set-key (kbd "C-h x") #'helpful-command)
(global-set-key (kbd "C-h F") #'helpful-function)
(global-set-key (kbd "C-c C-d") #'helpful-at-point)

;; Unset Bindings
(keymap-unset evil-motion-state-map "<SPC>")
