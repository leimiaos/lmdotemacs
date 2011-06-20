; -*- mode: Emacs-Lisp; tab-width: 4; -*-

;; 配置文件目录
(setq emacs-dot-d-path "~/.lisp/")

;; gentoo 的bug，过滤掉emacs自带的cedet
(setq load-path (let (local-path)
				  (dolist (path load-path)
					(unless (string-match "cedet$" path)
					  (add-to-list 'local-path path)))
				  local-path))

(defun my-load-path(root-path subdirs) 
  "自动加入子目录"
  (let ((rootp root-path))
  (mapcar (lambda(lst) 
			"LAMBDA"
			(let ((childdir (concat rootp lst)))
			  (add-to-list 'load-path childdir)
			  ;;(message childdir)
			  )) subdirs)))

(my-load-path emacs-dot-d-path '("" "lisps" "lisps/auto-complete" "lisps/auto-complete/dict" "lisps/cedet-1.0/common"))

(require 'dev-setting)
;;(require 'dea-emacs)

(require 'mode-line-settings)

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
													(setq TeX-command-default "XeLaTeX")
													(setq TeX-save-query   nil )
													(setq TeX-show-compilation t)
													)))
  (message "Load Auctex failed"))

;; Asymptote
(add-to-list 'load-path "/usr/local/texlive/2009/texmf/asymptote")
(autoload 'asy-mode "asy-mode.el" "Asymptote major mode." t)
(autoload 'lasy-mode "asy-mode.el" "hybrid Asymptote/Latex major mode." t)
(autoload 'asy-insinuate-latex "asy-mode.el" "Asymptote insinuate LaTeX." t)

;;unicad
(require 'unicad)

;; shutdown vc
(setq vc-handled-backends nil)

;; hightlight-tail
(require 'highlight-tail)
(setq highlight-tail-posterior-type t)
(setq highlight-tail-colors '(("yellow" . 0)
							  ("#90d070" . 25)
							  ("white" . 66)))
(setq highlight-tail-steps 100)
(setq highlight-tail-timer 0.5)

;; global key binding
(require 'global-key)
(require 'mode-map-setting)

;;misc
;; 支持emacs和外部程序的粘贴
(setq x-select-enable-clipboard t)

;;cursor type\
(setq-default cursor-type 'hbar)

;; 开启行号
(global-linum-mode)

;; 提前滚屏
(setq scroll-margin 3
      scroll-conservatively 10000)

;; 光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。
(mouse-avoidance-mode 'animate)

(setq-default ispell-program-name "aspell")