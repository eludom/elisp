(defun gmj-set-accounts-property-defaults ()
  "Set ':date*: FOO' dates in first org mode properties list to today's date

I have an org mode file that has account information in a tree-structued list.
The top node has property entries like ':dateCreated: <2016-09-03 Sat>' that
are inherited by lower nodes.   I want to set all of these to today's date
when I visit the files.  This is a function that will do that via
local variable eval.  See http://stackoverflow.com/questions/4356472/emacs-per-file-customization

In future versions, it might make sense to use org mode parsing and navigation functions to get
to the correct block of code rather than simple text search.
"
  (interactive "r") 
  (let (accountsStart accountsEnd propStart propEnd)

    (setq case-fold-search t)
      
  ; find "* Accounts".  This is special purpose code.  This org header is where we start or fail

    (goto-char 1)
    (re-search-forward "^* Accounts")
    (setq accountsStart (point))

  ; find next org header (if any) to use as the upper bound for seraches

    (if (re-search-forward "^*" (point-max) t 1)
	(setq accountsEnd (point))
      (setq accountsEnd (point-max)))


  ; replace anything after the ':dateFOO:' with ' <org-active-timestamp>'

      (save-restriction 
	(narrow-to-region accountsStart accountsEnd)
	(goto-char (point-min))

	(while (re-search-forward "^[[:space:]]+:date[a-zA-Z]*:" nil t)
	  (if (search-forward-regexp ".*$" nil t 1)
	      (progn
		(replace-match " " t)
		(insert (format-time-string "<%Y-%m-%d %a %H:%M>"))))))))
	


(defun accounts.org_file_hook ()
  "Add a per-file hook for accounts.org.gpg to set default date properties"
  (when (string= (file-name-nondirectory (buffer-file-name)) "accounts.org.gpg")
    (gmj-set-accounts-property-defaults)))

(add-hook 'find-file-hook 'accounts.org_file_hook)
