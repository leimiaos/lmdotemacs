; -*- mode: Emacs-Lisp; tab-width: 4; -*-

;;;; CC-mode
(defun cc-mode-setting()
  (c-set-offset 'inline-open 0)
  (c-set-offset 'friend '-)
  (c-set-offset 'substatement-open 0)
  (setq c-basic-offset 4)
  (setq c-default-style '((java-mode . "java")
						  (other . "linux")))
  (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
  )

(defun my-c-mode-common-hook()
  (setq tab-width 4 indent-tabs-mode nil)
  (c-toggle-auto-hungry-state 1)
  (require 'util)
  (lm-set-key c-mode-base-map
			  (list
			   ;(list "{"                 (lambda()(interactive)(lm-c-mode-left-brace "{+"))) 
			   ;;(list [(control \`)]   'hs-toggle-hiding)
			   (list [(return)]         'newline-and-indent)
			   (list [(f7)]             'compile)
			   (list [(meta \`)]        'c-indent-command)
			   ;;(list [(tab)] 'my-indent-or-complete)
			   (list [(control B)]      'semantic-mrub-switch-tags)
			   (list [(f12)]            'semantic-ia-fast-jump)
			   (list [(meta f12)]       'semantic-ia-fast-jump-back)
			   (list [(control f12)]    'my-switch-hcpp)
			   ))
  (setq c-macro-shrink-window-flag t)
  (setq c-macro-preprocessor "cpp")
  (setq c-macro-cppflags " ")
  (setq c-macro-prompt-flag t)
  )


(defun skeleton-c-mode-left-brace (arg)
  (interactive "P")
  (if  (c-in-literal (c-most-enclosing-brace (c-parse-state)))
      (self-insert-command 1)
    ;; auto insert complex things.
    (let* ((current-line (delete-and-extract-region (line-beginning-position) (line-end-position)))
           (lines (and arg (mark t) (delete-and-extract-region (mark t) (point))))
           (after-point (make-marker)))
       ;;; delete extra blank begin and after the LINES
      (setq lines (and lines
                       (with-temp-buffer
                         (insert lines)
                         (beginning-of-buffer)
                         (delete-blank-lines)
                         (delete-blank-lines)
                         (end-of-buffer)
                         (delete-blank-lines)
                         (delete-blank-lines)
                         (buffer-string))))
      (save-excursion
        (let* ((old-point (point)))
          (insert (if current-line current-line "")  "{\n")
          (and lines (insert lines))
          (move-marker after-point (point))
          (insert "\n}")
          (indent-region old-point (point) nil)))
      (goto-char after-point)
      (c-indent-line))))

(defun my-c++-mode-hook() 
  (setq tab-width 4 indent-tabs-mode nil)
  (c-set-style "linux"))

(defun my-indent-or-complete ()
  (interactive)
  (if (looking-at "\\>")
	  (hippie-expand nil)
	(indent-for-tab-command))
  )

(defun my-switch-hcpp()
  (interactive)
  (require 'eassist)
  (eassist-switch-h-cpp))

(eval-after-load "cc-mode" 
  '(progn
	 (cc-mode-setting)
	 (require 'cedet)
	 ))

(defun cedet-setting()
  (semantic-load-enable-code-helpers)
  (which-func-mode)

  (defconst user-include-dirs
	(list ".." "../include" "../.." "../../include" "include" "../../.." "../../../include" ;; common
		  "../common" "../src" "../base" "../term" ;; BBS
		  "/usr/include/qt4/Qt" "/usr/include/qt4/QtGui" "/usr/include/qt4/QtCore" "/usr/include/qt4/QtNetwork" ;;Qt
		  ))
  (mapc (lambda (dir)
		  (semantic-add-system-include dir 'c++-mode)
		  (semantic-add-system-include dir 'c-mode))
		user-include-dirs)
  (require 'semantic-tag-folding)
  (global-semantic-tag-folding-mode 1)
  (require 'util)
  (lm-set-key semantic-tag-folding-mode-map 
			  (list 
			   (list (kbd "<M-left>")  'semantic-tag-folding-fold-block)
			   (list (kbd "<M-right>") 'semantic-tag-folding-show-block)
			   (list (kbd "<M-S-left>")       'semantic-tag-folding-fold-all)
			   (list (kbd "<M-S-right>")       'semantic-tag-folding-show-all)
			   )))

(defun semantic-ia-fast-jump-back ()
  (interactive)
  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
	  (error "Semantic Bookmark ring is currently empty"))
  (let* ((ring (oref semantic-mru-bookmark-ring ring))
		 (alist (semantic-mrub-ring-to-assoc-list ring))
		 (first (cdr (car alist))))
	(if (semantic-equivalent-tag-p (oref first tag) (semantic-current-tag))
		(setq first (cdr (car (cdr alist)))))
	(semantic-mrub-switch-tags first)))


(eval-after-load "cedet"
  '(progn
	 (cedet-setting)
	 ))

;; auto-complete
(require 'ahei-misc)
(require 'util)
(require 'auto-complete-settings)

;; php mode
(add-to-list 'load-path (concat emacs-dot-d-path "php-mode"))
(autoload 'php-mode "php-mode" "php mode" t)

;; 括号
(require 'highlight-parentheses)
(setq hl-paren-colors '("red" "yellow" "cyan" "magenta" "green" "red"))
(am-add-hooks
 '(find-file-hook help-mode-hook Man-mode-hook log-view-mode-hook
                  compilation-mode-hook gdb-mode-hook lisp-interaction-mode-hook
                  browse-kill-ring-mode-hook completion-list-mode-hook hs-hide-hook
                  inferior-ruby-mode-hook custom-mode-hook Info-mode-hook svn-log-edit-mode-hook
                  package-menu-mode-hook dired-mode-hook apropos-mode-hook)
 'highlight-parentheses-mode)

;;;###autoload
(defun goto-paren ()
  "跳到匹配的括号"
  (interactive)
  (cond
   ((looking-at "[ \t]*[[\"({]") (forward-sexp) (backward-char))
    ((or (looking-at "[]\")}]") (looking-back "[]\")}][ \t]*")) (if (< (point) (point-max)) (forward-char)) (backward-sexp))
   (t (message "找不到匹配的括号"))))

;; AUCTex 
;; use load instead of autoload because the auctex use autoload inside
(if (load "auctex" t) (progn
					   (load "preview-latex" t)
					   (setq TeX-auto-save t)
					   (setq TeX-parse-self t)
					   (setq-default TeX-master nil)
					   (add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
					   (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

					   (add-hook 'LaTeX-mode-hook (lambda()
													(add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
													(add-to-list 'TeX-command-list '("PdfLaTex" "%`pdflatex%(mode)%' %t" TeX-run-TeX nil t))
													(setq TeX-view-program-list '(("Okular" "okular --unique %o" )))
													(setq TeX-view-program-selection '((output-pdf "Okular")
																					   (output-dvi "Okular")))
													(setq TeX-command-default "XeLaTeX")
													(setq TeX-save-query   nil )
													(setq TeX-show-compilation t)
													)))
  (message "Load Auctex failed"))

;; Asymptote
;;(add-to-list 'load-path "/usr/local/texlive/2009/texmf/asymptote")
(autoload 'asy-mode "asy-mode.el" "Asymptote major mode." t)
(autoload 'lasy-mode "asy-mode.el" "hybrid Asymptote/Latex major mode." t)
(autoload 'asy-insinuate-latex "asy-mode.el" "Asymptote insinuate LaTeX." t)

;; hs-hide-mode
(am-add-hooks 
 '(lisp-interaction-mode-hook emacs-lisp-mode-hook)
 (lambda()
   "Activate the hs-minor-mode"
   (hs-minor-mode t)))

;; vc-backend
(defun switch-vc-backend()
  "版本控制功能开关"
  (interactive)
  (if vc-handled-backends (progn
	  (setq vc-handled-backends-back vc-handled-backends)
	  (setq vc-handled-backends nil)
	  (message "Version Control System disabled"))
	(progn
	  (setq vc-handled-backends vc-handled-backends-back)
	  (message "Version Control System enabled"))))

(switch-vc-backend)

(provide 'dev-setting)
