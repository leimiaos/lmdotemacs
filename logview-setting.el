; -*- mode: Emacs-Lisp; tab-width: 4; -*-

(use-package logview
  :ensure t
  :config
  (add-hook 'logview-mode-hook 'read-only-mode)
  (add-to-list 'auto-mode-alist '("\\.log$" . logview-mode))
  (add-to-list 'auto-mode-alist '("\\.log\\.[-\\d]+\\.\\d+\\.gz$" . logview-mode))
  )

(provide 'logview-setting)
  
