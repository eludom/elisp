; These three key definitons allow you to quickly add wiki links to a text
;
; The goal is to have 3 yes that let you move through a file adding links.
;

(global-set-key (kbd "M-1") 'gmj-mark-next-word)
(global-set-key (kbd "M-2") 'gmj-forward-word)
(global-set-key (kbd "M-3") 'gmj-word-to-wikipedia-linkify)

(defun gmj-mark-next-word ()
  "Mark the next word (skip whitespace first)"
  (interactive)
  (progn
    (skip-chars-forward "[:cntrl:]") ; we don't care

    (if (thing-at-point 'whitespace)
	(skip-chars-forward "[:space:]"))
    (set-mark (point))
    (skip-chars-forward "[:graph:]")))

(defun gmj-forward-word ()
  "Move forward one word (skip whitespace first)"
  (interactive)
  (progn
    (skip-chars-forward "[:cntrl:]") ; we don't care

    (if (thing-at-point 'whitespace)
	(skip-chars-forward "[:space:]"))
    (skip-chars-forward "[:graph:]")))


(defun gmj-word-to-wikipedia-linkify (arg)
  "Make the current word or text selection into a org mode Wikipedia link if the entry exists.

By default it adds an HTML style href, e.g.

   <a href=\"http://en.wikipedia.org/wiki/Victor_Hugo\">Victor Hugo</a>

When preceeded by one universal argument (^u), it inserts an org-mode sytle link, e.g.

    [[http://en.wikipedia.org/wiki/Victor_Hugo][Victor Hugo]]

Adapted from From http://xahlee.blogspot.com/2014/10/emacs-lisp-change-current-word-to.html

TODO List
   - Check to see if the page exists first
" 
  (interactive "p")
  (let (linkText bds p0 p1 p2 wikiTerm insertThisLink)

    (if (region-active-p)
        (progn
          (setq p1 (region-beginning))
          (setq p2 (region-end)))
      (progn
        (setq p0 (point))
        (skip-chars-backward "^ \t\n")
        (setq p1 (point))
        (goto-char p0)
        (skip-chars-forward "^ \t\n")
        (setq p2 (point))))

    (setq linkText (buffer-substring-no-properties p1 p2))

    
  ; cleanup before wiki lokkup

    (setq wikiTerm (replace-regexp-in-string " " "_" linkText))
    (setq wikiTerm (replace-regexp-in-string "[[:punct:]]$" "" wikiTerm))
  ; TODO save trailing punctuation and insert after link, as is, it removes the punctuation
    
  ; wiki lookup
	  
	  (setq checkURL (concat "http://en.wikipedia.org/wiki/" wikiTerm))
	  (if (url-http-file-exists-p checkURL)
	      (progn
		(message "Found wiki entry for /%s/" wikiTerm)
		(save-excursion
		  (delete-region p1 p2)

		  (if (= arg 1)
		      (setq insertThisLink (concat "<a href=\"http://en.wikipedia.org/wiki/" wikiTerm "\">" wikiText "</a>"))
		    (setq insertThisLink (concat "[[http://en.wikipedia.org/wiki/" wikiTerm "][" wikiText "]]")))

		  (insert insertThisLink))

  ; move to just past what we inserted to allow rapid movement through a file

		(forward-char (length insertThisLink))

  ; insure we have a least one space
		(if (not (thing-at-point 'whitespace)) (insert " ")))    
	    (progn
	      (message "No wikipedia entry for /%s/" wikiTerm)))

	  (progn
   
  ; move past space

	    (skip-chars-forward "[:cntrl:]") ; we don't care

	    (if (thing-at-point 'whitespace)
		(skip-chars-forward "[:space:]"))

  ; set mark and move to end of next word
    
	    (set-mark (point))
	    (skip-chars-forward "[:graph:]"))))





