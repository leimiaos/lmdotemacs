; -*- mode: Emacs-Lisp; tab-width: 4; -*-

;; (add-hook 'dired-load-hook
;; 	  (lambda()
;; 	    (load "dired-x")
;; 	    ))

;; (add-hook 'dired-mode-hook
;; 	  (lambda()
;; 		(dired-omit-mode 1)
;;	    ))

(setq dired-omit-files "^\\.?#\\|^\\.$\\|^\\.[^\\.]")

(provide 'dired-setting)
