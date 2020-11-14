(defun gmj-man (&optional @word)
  "Run man for current word or text selection.

 Derived from xah-lookup-word-on-internet
 URL `http://ergoemacs.org/emacs/xah-lookup.html'
Version 2017-08-15"
  (interactive)
  (let ($word $refUrl $myUrl)
    (setq $word
	  (if @word
	      @word
	    (if (region-active-p)
		(buffer-substring-no-properties (region-beginning) (region-end))
	      (current-word))))

    (man $word)
    ))

(define-key help-map (kbd "0") 'gmj-man)
