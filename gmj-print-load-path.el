  ; For debugging load path
  ;
  ; From http://svn.donarmstrong.com/don/trunk/lib/emacs_el/tiny-tools/tiny/load-path.el

(defun gmj-load-path-print (&optional function eval)
  "Print `load-path' using `function'.
Default is `message'. Eval optional EVAL."
  (let ((i 0))
    (if eval
        (eval eval))
    (dolist (path load-path)
      (if function
          (funcall function "  %d %s" i path)
        (message "  %d %s" i path))
      (incf i))))
