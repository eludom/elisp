(defun gmj-shell (arg)
  "Start a shell in a buffer named *shell*<HOSTNAME>

       An attempt is made to parse HOSTNAME out of the
      filename of tramp buffers such as /ssh:FOO@HOSTNAME:/path/path...

      When preceded with 1 `universal-argument' (^u),
      try to create *shell*<HOSTNAME#>a
      where # in 1,2,3,4

      When preceded with 2 `universal-argument' (^u^u),
      prompt for BUFFER name and try to create *shell*<HOSTNAME#>

      "
  (interactive "p")
  (progn
    (message "in gmj-shell")

                                        ;
                                        ; get the hostname
                                        ;

    (setq hostname (system-name))
    (if (string-prefix-p "/ssh:" (buffer-file-name))
        (progn
          (setq file-name (buffer-file-name))
          (setq hostname (replace-regexp-in-string "/ssh:" "" file-name))
          (setq hostname (replace-regexp-in-string ":.*" "" hostname))))

                                        ;
                                        ; determine the shell buffer name
                                        ;


                                        ; if arg is 1, just create (or jump to) *shell*<HOSTNAME>
    (if (= arg 1)
        (setq shell-name (format "*shell*<%s>" hostname))

                                        ; if arg > 4, prompt for buffer name
      (if (> arg 4)
          (setq shell-name (concat "*shell*<" (read-string (format "shell name (%s):" "shell4foo") nil nil "shell4foo") ">"))

                                        ; if arg is 4 (one universal arg)
                                        ; try creating new numbered shell "*<shell>*<HOSTNAME#> for # in 1,2,3,4
        (progn

          (let ((x 1) (lookingForUnusedBuffer t))
            (while (and (<= x 4) lookingForUnusedBuffer)
              (setq tryThis (format "*shell*<%s-%d>" hostname x))
              (unless (get-buffer tryThis)
                (progn
                  (setq lookingForUnusedBuffer nil)
                  (setq shell-name tryThis)))
              (setq x (+ x 1)))))))
                                        ;
                                        ; Try to create the shell
                                        ;

    (message (concat "shell name: " shell-name))
    (shell shell-name)))
