(progn
  (defun gmj-set-property-defaults ()
    "Set ':date*: FOO' dates in first org mode properties list to today's date

I have an org mode files that has account information in a tree-structued list.
The top node has property entries like ':dateCreated: <2016-09-03 Sat>' that
are inherited by lower nodes.   I want to set all of these to today's date
when I visit the files.  This is a function that will do that via
local variable eval.  See http://stackoverflow.com/questions/4356472/emacs-per-file-customization

In future versions, it might make sense to use org mode parsing and navigation functions to get
to the correct block of code rather than simple text search
"
    (interactive)
    (let (start end)

  ; find "* Accounts".  This is special purpose code.  This org header is whre we start or fail

      (goto-char 1)
      (setq case-fold-search t)
      (re-search-forward "^* Accounts")
      (setq accountsStart (point))

  ; find next org header (if any) to use as the upper bound for seraches

      (save-excursion
	(if (re-search-forward "^* " (point-max) t 1)
	    (setq accountsEnd (point))
	  (setq accountsEnd (point-max))))

      (message "accountsStart %d" accountsStart)      
      (message "accountsEnd %d" accountsEnd)      
      
      (if (re-search-forward "^[[:space:]]+:PROPERTIES:")
	  (progn
	    (setq propStart (point))
	    (message "propStart at %d" propStart)))

      (save-excursion      
	(if (re-search-forward "^[[:space:]]+:END:")  
	    (progn
	      (setq propEnd (point))
	      (message "propEnd at %d" propEnd))))))

  (gmj-set-property-defaults))

foo

* AccountS
  :PROPERTIES:
  :system:   foo
  :type_ALL: social email cloud
  :username: foo
  :authType_ALL: password google
  :password: foo
  :email_ALL:    eludom@gmail.com gmj@pobox.com
  :securityQuestions:
  :url:      foo
  :dateCreated: <2016-09-03 Sat>
  :dateAccessed: <2016-09-03 Sat>
  :dateUpdated:
  :dateExpires:
  :accountInfo:
  :comments:
  :END:

bar
