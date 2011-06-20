

(mapcar (lambda(ele)
	  (add-to-list 'auto-mode-alist ele))
	'(("SConstruct" . python-mode)
	  ("SConscript" . python-mode)
	  ("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode)
	  ("\\.ebuild" . shell-script-mode)
	  ("\\.asy$"   . asy-mode)
	  ("\\.h$"     . c++-mode)
	  ))

(provide 'mode-map-setting)

