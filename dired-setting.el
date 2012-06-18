; -*- mode: Emacs-Lisp; tab-width: 4; -*-

(add-hook 'dired-load-hook
	  (lambda()
	    (load "dired-x")
	    (dired-omit-mode 1)
	    ))

(add-hook 'dired-mode-hook
	  (lambda()
		(dired-omit-mode 1)
	    ))

(setq dired-omit-files "^\\.?#\\|^\\.$\\|^\\.[^\\.]")
;;(setq dired-omit-extensions
;;	  '(".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" )) 

(provide 'dired-setting)