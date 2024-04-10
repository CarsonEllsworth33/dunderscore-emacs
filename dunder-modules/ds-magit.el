;;; ds-magit --- my personal config for magit
;;; Commentary:
;;; Code:
(use-package magit-section)
(use-package magit
  :after magit-section
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(provide 'ds-magit)
;;; ds-magit.el ends here
