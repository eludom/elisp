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
    (setq wikiTerm (replace-regexp-in-string " " "_" linkText))
    (setq checkURL (concat "http://en.wikipedia.org/wiki/" wikiTerm))
    (if (url-http-file-exists-p checkURL)
	(progn
	  (save-excursion
	    (delete-region p1 p2)

	    (if (= arg 1)
		(setq insertThisLink (concat "<a href=\"http://en.wikipedia.org/wiki/" wikiTerm "\">" linkText "</a> "))
	      (setq insertThisLink (concat "[[http://en.wikipedia.org/wiki/" wikiTerm "][" linkText "]] ")))

	    (insert insertThisLink))

          ; move to just past what we inserted to allow rapid movement through a file

	  (forward-char (length insertThisLink))))))



(global-set-key (kbd "M-1") 'gmj-word-to-wikipedia-linkify)


(forward-char)
