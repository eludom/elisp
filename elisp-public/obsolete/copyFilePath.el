; http://ergoemacs.org/emacs/emacs_copy_file_path.html

(defun xah-copy-file-path (&optional φdir-path-only-p)
  "Copy the current buffer's file path or dired path to `kill-ring'.
If `universal-argument' is called, copy only the dir path."
  (interactive "P")
  (let ((fPath
         (if (equal major-mode 'dired-mode)
             default-directory
           (buffer-file-name))))
    (kill-new
     (if (equal φdir-path-only-p nil)
         fPath
       (file-name-directory fPath))))
  (message (concat "File path copied: " " " (car kill-ring-yank-pointer) )))

(global-set-key (kbd "<f6> <f6>") 'xah-copy-file-path)


