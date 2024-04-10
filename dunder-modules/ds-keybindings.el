;;; ds-keybindings --- these are global keybindings that are not major mode specific
;;; Commentary:
;;; Code:
(defun my-prefix-translations (_mode mode-keymaps &rest _rest)
  (evil-collection-translate-key 'normal mode-keymaps
    (kbd "C-SPC") (kbd "SPC")))

(add-hook 'evil-collection-setup-hook #'my-prefix-translations)

(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
(global-set-key (kbd "C-h x") #'helpful-command)
(global-set-key (kbd "C-h F") #'helpful-function)
(global-set-key (kbd "C-c C-d") #'helpful-at-point)

(defvar ds/files-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "f") #'("find" . find-file))
    map))

(defvar ds/buffers-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "n") #'("next" . evil-next-buffer))
    (define-key map (kbd "p") #'("prev" . evil-prev-buffer))
    (define-key map (kbd "N") #'("new" . evil-buffer-new))
    (define-key map (kbd "k") #'("kill" . kill-this-buffer))
    (define-key map (kbd "b") #'("switch" . counsel-switch-buffer))
    map))

(defvar ds/windows-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "d") #'("delete" . delete-window))
    (define-key map (kbd "|") #'("split right" . split-window-right))
    (define-key map (kbd "/") #'("split below" . split-window-below))
    map))

(evil-set-leader 'normal (kbd "SPC"))

(evil-define-key 'normal 'global
  (kbd "<leader> f") (cons "files" ds/files-map)
  (kbd "<leader> TAB") (cons "switch window" 'ace-window)
  (kbd "<leader> b") (cons "buffers" ds/buffers-map)
  (kbd "<leader> w") (cons "windows" ds/windows-map)
  )

(evil-define-key 'normal 'global
  (kbd "<leader> SPC") 'counsel-M-x)
(provide 'init)

(provide 'ds-keybindings)
;;; ds-keybindings.el ends here
