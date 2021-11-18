; -*- mode: Emacs-Lisp; tab-width: 4; -*-

(use-package log4j-mode
  :ensure t
  :disabled t
  :init
  (add-hook #'log4j-mode-hook #'view-mode)
  (add-hook #'log4j-mode-hook #'read-only-mode))

(use-package logview
  :ensure t
  )

(provide 'logview-setting)
  
