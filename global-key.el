;;-*- Emacs-Lisp -*-

(defun set-key-bindings (action bindingList)
  ""
  (mapcar (lambda(lst)
      ""
      (let ((x (car lst))
        (y (car (last lst))))
        (funcall action x y))) bindingList ))

(defun lm-add-key-binding(key func)
  "增加键位绑定"
  (let ((ori-func (key-binding key))
	ret-lambda)
    (setq ret-lambda (append (lambda()(interactive)) (list (list ori-func)(list func)))    )
    (global-set-key key ret-lambda)
    ))

(set-key-bindings 'global-set-key   
		  (list 
		   (list (kbd "C-x C-f")     'find-file-at-point)
		   (list [(f11)]             'highlight-tail-mode)
		   (list [(f9)]              'switch-vc-backend)
		   (list (kbd "C-]")         'goto-paren)
		   (list [(meta f11)]        'auto-paren-mode)
		   (list (kbd "<M-left>")    'hs-hide-block)
		   (list (kbd "<M-S-left>")  'hs-hide-all)
		   (list (kbd "<M-right>")   'hs-show-block)
		   (list (kbd "<M-S-right>") 'hs-show-all)
		   (list (kbd "<end>")       'end-of-line)
		   (list (kbd "<home>")      'move-beginning-of-line)
		   ))

(provide 'global-key)
