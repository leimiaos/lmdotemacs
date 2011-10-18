;; -*- emacs-lisp -*-

;; 自动插入括号函数
;;;###autoload
(defun lm-c-mode-left-brace(arg)
(interactive)
  (let ((bracelist '(("[" "[" "]" ) 
		     ("{" "{" "}" )
		     ("\"" "\"" "\"" )
		     ("(" "(" ")" ))))
    (dolist (ele bracelist)
      (let ((charin (nth 0 ele))
	    (left (nth 1 ele))
	    (right (nth 2 ele)))
	(when (string= arg charin)
	  (insert left)
	  (save-excursion
	    (insert right))
	  )))))

;;;###autoload
(defun lm-c-mode-right-brace(arg)
  (let ((curr-pos (point))
	char-find)
    (setq char-find 
	  (and (char-after curr-pos)
	       (string (char-after curr-pos))))
    (if (string= arg char-find)
	(goto-char (+ 1 curr-pos))
      (insert arg)))
  )

;;;###autoload
(defun auto-paren-bs(arg)
  (interactive "p")
  (let ((left (string (preceding-char)))
	(right (string (following-char))))
    (if (or (and (string= left "(") (string= right ")"))
	    (and (string= left "[") (string= right "]"))
	    (and (string= left "{") (string= right "}"))
	    (and (string= left "\"") (string= right "\"")))
	(progn
	  (delete-char 1)
	  (delete-char -1))	  
      (funcall auto-paren-backspace-cmd arg)
      )
    ))
;;(global-set-key (kbd "<backspace>") 'auto-paren-bs)

(define-minor-mode auto-paren-mode
  "Toggle auto-paren-mode"
  :group 'auto-paren
  :keymap
  '(("[" .  (lambda()(interactive)(lm-c-mode-left-brace "[")))
    ("(" .  (lambda()(interactive)(lm-c-mode-left-brace "(")))
    ("{" .  (lambda()(interactive)(lm-c-mode-left-brace "{")))
    ("]" .  (lambda()(interactive)(lm-c-mode-right-brace "]")))
    (")" .  (lambda()(interactive)(lm-c-mode-right-brace ")")))
    ("}" .  (lambda()(interactive)(lm-c-mode-right-brace "}")))
    ("\"" . (lambda()(interactive)(lm-c-mode-right-brace "\"")))
    ([backspace] . auto-paren-bs)
    )
  )

(setq auto-paren-backspace-cmd (or (key-binding [backspace])
				   (lambda(arg)(delete-char -1))))

;; (setq auto-paren-mode nil)
;; (setq auto-paren-mode-map (make-sparse-keymap))
;; (require 'util)
;; (lm-set-key auto-paren-mode-map
;; 	    (list
;; 	     (list "["   (lambda()(interactive)(lm-c-mode-left-brace "[")))
;; 	     (list "("   (lambda()(interactive)(lm-c-mode-left-brace "(")))
;; 	     (list "{"   (lambda()(interactive)(lm-c-mode-left-brace "{")))
;; 	     (list "]"   (lambda()(interactive)(lm-c-mode-right-brace "]")))
;; 	     (list ")"   (lambda()(interactive)(lm-c-mode-right-brace ")")))
;; 	     (list "}"   (lambda()(interactive)(lm-c-mode-right-brace "}")))
;; 	     (list "\""  (lambda()(interactive)(lm-c-mode-right-brace "\"")))
;; 	     (list [backspace]  'auto-paren-bs)))

;; (add-to-list 'minor-mode-map-alist '(auto-paren-mode . auto-paren-mode-map))

;; (defun auto-paren-mode(&optional arg)
;;   "Toggle auto-paren-mode"
;;   (interactive)
;;   (let ((local-mode 
;; 	 (if (null arg) (not auto-paren-mode)
;;                   (> (prefix-numeric-value arg) 0))))
;;     (when (and local-mode (not auto-paren-mode))
;;       (setq auto-paren-backspace-cmd (key-binding [backspace])))
;;     (setq auto-paren-mode local-mode))
;;   (add-to-list 'minor-mode-alist '(auto-paren-mode " AP"))
;;   (message "%s" auto-paren-mode)
;;   )

(provide 'auto-paren-mode)

