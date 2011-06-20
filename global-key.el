;;-*- Emacs-Lisp -*-

(defun set-key-bindings (action bindingList)
  ""
  (mapcar (lambda(lst)
      ""
      (let ((x (car lst))
        (y (car (last lst))))
        (funcall action x y))) bindingList ))

(set-key-bindings 'global-set-key   
		  (list 
		   (list "{"                 (lambda()(interactive)(lm-c-mode-left-brace "{")))
		   (list "["                 (lambda()(interactive)(lm-c-mode-left-brace "[")))
		   (list "("                 (lambda()(interactive)(lm-c-mode-left-brace "(")))
		   (list "\""                (lambda()(interactive)(lm-c-mode-left-brace "\"")))
		   (list "}"                 (lambda()(interactive)(lm-c-mode-right-brace "}")))
		   (list "]"                 (lambda()(interactive)(lm-c-mode-right-brace "]")))
		   (list ")"                 (lambda()(interactive)(lm-c-mode-right-brace ")")))
		   (list (kbd "C-j")         'goto-line)
		   (list (kbd "C-x C-f")     'find-file-at-point)
		   (list [(f11)]             'highlight-tail-mode)
		   (list (kbd "C-]")         'goto-paren)
		   ))

(provide 'global-key)
