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

(my-load-path emacs-dot-d-path '("" "lisps" "lisps/auto-complete" "lisps/auto-complete/dict" "lisps/cedet-1.0/common" "lisps/cedet-1.0/eieio"))

(require 'auto-paren-mode)
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
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(TeX-command-list (quote (("PdfLaTex" "%`pdflatex%(mode)%' %t" TeX-run-TeX nil t) ("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t) ("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (plain-tex-mode texinfo-mode ams-tex-mode) :help "Run plain TeX") ("LaTeX" "%`%l%(mode)%' %t" TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX") ("Makeinfo" "makeinfo %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with Info output") ("Makeinfo HTML" "makeinfo --html %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with HTML output") ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (ams-tex-mode) :help "Run AMSTeX") ("ConTeXt" "texexec --once --texutil %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt once") ("ConTeXt Full" "texexec %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt until completion") ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX") ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer") ("Print" "%p" TeX-run-command t t :help "Print the file") ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command) ("File" "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file") ("Index" "makeindex %s" TeX-run-command nil t :help "Create index file") ("Check" "lacheck %s" TeX-run-compile nil (latex-mode) :help "Check LaTeX file for correctness") ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document") ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files") ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files") ("Other" "" TeX-run-command t t :help "Run an arbitrary command")))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(header-line ((default :inherit mode-line) (((type tty)) :foreground "black" :background "yellow" :inverse-video nil) (((class color grayscale) (background light)) :background "grey90" :foreground "grey20" :box nil) (((class color grayscale) (background dark)) :background "#D58EFFFFFC18" :foreground "blue") (((class mono) (background light)) :background "white" :foreground "black" :inverse-video nil :box nil :underline t) (((class mono) (background dark)) :background "black" :foreground "white" :inverse-video nil :box nil :underline t)))
 '(mode-line-buffer-id ((((class grayscale) (background light)) (:foreground "LightGray" :background "yellow" :weight bold)) (((class grayscale) (background dark)) (:foreground "DimGray" :background "yellow" :weight bold)) (((class color) (min-colors 88) (background light)) (:foreground "Orchid" :background "yellow")) (((class color) (min-colors 88) (background dark)) (:foreground "yellow" :background "HotPink3")) (((class color) (min-colors 16) (background light)) (:foreground "Orchid" :background "yellow")) (((class color) (min-colors 16) (background dark)) (:foreground "LightSteelBlue" :background "yellow")) (((class color) (min-colors 8)) (:foreground "blue" :background "yellow" :weight bold)) (t (:weight bold)))))
