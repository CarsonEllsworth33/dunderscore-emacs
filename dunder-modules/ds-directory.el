;;; ds-directory --- all things directory/file navigation related
;;; Commentary:
;;; Code:
(use-package dirvish)

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

(provide 'ds-directory)
;;; ds-directory.el ends here
