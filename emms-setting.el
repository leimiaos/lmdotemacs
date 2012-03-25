;;-*- Emacs-Lisp -*-

(require 'emms-setup)

(emms-standard)
(emms-default-players)

(defun bigclean-emms-info-track-description (track)
  "Return a description of the current track."
  (let ((artist (emms-track-get track 'info-artist))
        (title (emms-track-get track 'info-title))
        (album (emms-track-get track 'info-album))
        (ptime (emms-track-get track 'info-playing-time)))
    (if title 
        (format 
         "%s-%s-%s %5s:%-5s"
         (if artist artist "")
         (if album album "")
         (if title title "")
         (/ ptime 60)
         (% ptime 60)))))

(setq emms-track-description-function
      'bigclean-emms-info-track-description)
(setq emms-repeat-playlist t)
(add-to-list 'emms-player-finished-hook 'emms-random)
;;(setq emms-player-finished-hook nil)
(require 'emms-volume)
(require 'emms-score)
(require 'emms-i18n)
(require 'emms-history)

(provide 'emms-setting)

