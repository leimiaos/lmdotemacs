; -*- mode: Emacs-Lisp; tab-width: 4; -*-

;; 配置文件目录
(setq emacs-dot-d-path "~/emacs-config/")

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
			  )) subdirs)))

(my-load-path emacs-dot-d-path '("" "lisps"))

(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(package-initialize)

(package-install 'use-package)
(require 'use-package)

(require 'dev-setting)

(require 'logview-setting)

(require 'dired-setting)

(require 'auto-paren-mode)

;;(require 'dea-emacs)

(require 'mode-line-settings)


;;unicad
(require 'unicad)

;; shutdown vc
;;(setq vc-handled-backends nil)
;; hightlight-tail
(require 'highlight-tail)
(setq highlight-tail-posterior-type t)
(setq highlight-tail-colors '(("yellow" . 0)
							  ("#90d070" . 25)
							  ("white" . 66)))
(setq highlight-tail-steps 100)
(setq highlight-tail-timer 0.5)

;;(require 'emms-setting)

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

;; 默认模式
(setq-default major-mode 'text-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(datetime-timezone 'Asia/Chongqing)
 '(logview-additional-submodes
   '(("Spring"
	  (format . "TIMESTAMP  LEVEL IGNORED --- [THREAD] NAME : MESSAGE")
	  (levels . "SLF4J")
	  (timestamp "Spring")
	  (aliases))))
 '(logview-additional-timestamp-formats '(("Spring" (java-pattern . "yyyy-MM-dd HH:mm:ss.SSS"))))
 '(package-selected-packages '(yaml-mode logview dired-x use-package magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(header-line ((default :inherit mode-line) (((type tty)) :foreground "black" :background "yellow" :inverse-video nil) (((class color grayscale) (background light)) :background "grey90" :foreground "grey20" :box nil) (((class color grayscale) (background dark)) :background "#D58EFFFFFC18" :foreground "blue") (((class mono) (background light)) :background "white" :foreground "black" :inverse-video nil :box nil :underline t) (((class mono) (background dark)) :background "black" :foreground "white" :inverse-video nil :box nil :underline t)))
 '(mode-line-buffer-id ((((class grayscale) (background light)) (:foreground "LightGray" :background "yellow" :weight bold)) (((class grayscale) (background dark)) (:foreground "DimGray" :background "yellow" :weight bold)) (((class color) (min-colors 88) (background light)) (:foreground "Orchid" :background "yellow")) (((class color) (min-colors 88) (background dark)) (:foreground "yellow" :background "HotPink3")) (((class color) (min-colors 16) (background light)) (:foreground "Orchid" :background "yellow")) (((class color) (min-colors 16) (background dark)) (:foreground "LightSteelBlue" :background "yellow")) (((class color) (min-colors 8)) (:foreground "blue" :background "yellow" :weight bold)) (t (:weight bold)))))
