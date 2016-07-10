;; From http://emacs.stackexchange.com/questions/390/display-pdf-images-in-org-mode

; Example setup
; 
; In this example setup I have the following files:
; 
; An org file like below that includes an image file.
; A pdf file myimage.pdf. As shown in the below org example, you include an image file like .png that you would like to convert the pdf to.
; #+TITLE: PDF Image
;  #+STARTUP: inlineimages
;  #+NAME: fig:myimage 
;  #+HEADER: :convertfrompdf t
;  # The below caption line is optional
;  #+CAPTION: My image
;  [[./myimage.png]]

;; Execute the `modi/org-include-img-from-pdf' function just before saving the file
(add-hook 'before-save-hook #'modi/org-include-img-from-pdf)
;; Execute the `modi/org-include-img-from-pdf' function before processing the
;; file for export
(add-hook 'org-export-before-processing-hook #'modi/org-include-img-from-pdf)

(defun modi/org-include-img-from-pdf (&rest ignore)
  "Convert the pdf files to image files.

Only looks at #HEADER: lines that have \":convertfrompdf t\".
This function does nothing if not in org-mode, so you can safely
add it to `before-save-hook'."
  (interactive)
  (when (derived-mode-p 'org-mode)
    (save-excursion
      (goto-char (point-min))
      (while (search-forward-regexp
              "^\\s-*#\\+HEADER:.*\\s-:convertfrompdf\\s-+t"
              nil 'noerror)
        (let* (filenoext imgext imgfile pdffile cmd)
          ;; Keep on going on to the next line till it finds a line with
          ;; `[[FILE]]'
          (while (progn
                   (forward-line 1)
                   (not (looking-at "\\[\\[\\(.*\\)\\.\\(.*\\)\\]\\]"))))
          (when (looking-at "\\[\\[\\(.*\\)\\.\\(.*\\)\\]\\]")
            (setq filenoext (match-string-no-properties 1))
            (setq imgext (match-string-no-properties 2))
            (setq imgfile (expand-file-name (concat filenoext "." imgext)))
            (setq pdffile (expand-file-name (concat filenoext "." "pdf")))
            (setq cmd (concat "convert -density 96 -quality 85 "
                              pdffile " " imgfile))
            (when (file-newer-than-file-p pdffile imgfile)
              ;; This block is executed only if pdffile is newer than imgfile
              ;; or if imgfile does not exist
              ;; Source: https://www.gnu.org/software/emacs/manual/html_node/elisp/Testing-Accessibility.html
              (message "%s" cmd)
              (shell-command cmd))))))))
