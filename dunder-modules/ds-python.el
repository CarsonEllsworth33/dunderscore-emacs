;;; ds-python --- python config for dunderscore emacs
;;; Commentary:
;;; Code:
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

(defvar ds/python-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "b") #'("buffer" . python-black-buffer))
    (define-key map (kbd "r") #'("region" . python-black-region))
    map))

(use-package python-black
  :after python-mode)

(evil-define-key 'normal 'Python
  (kbd "<leader> l") (cons "format" ds/python-map))

(provide 'ds-python)
;;; ds-python.el ends here
