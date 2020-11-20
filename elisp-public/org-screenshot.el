;; https://www.reddit.com/r/emacs/comments/jlynfq/take_screenshot_of_region_on_linux_for_org_mode/

;; (defun my-insert-clipboard-png ()  
;;       (interactive)  
;;       (let  
;;           ;; Read Filename from Minibuffer  
;;           ((filename (read-from-minibuffer "image file name: "))  
;;            (directory "_media"))  
       
;;         ;; Use maim to screenshot  
;;         (shell-command (format "mkdir -p %s/%s" default-directory directory))  
;;         (shell-command (format "xclip -selection clipboard -t image/png -o > %s/%s/%s.png" default-directory directory  
;;                                filename ))  
        
;;         ;; Insert formatted link at point  
;;         (save-excursion (insert(format  
;;                                 "#+attr_html: :width 400px \n #+attr_latex: :width 0.4\\textwidth \n [[file:%s/%s.png]]"  
;;                                 directory filename)))  
        
;;         ;; Message success to the minibuffer  
;;         (message "saved to %s as %s.png" directory filename)  
;;         )  
;;       )

;;     (defun my-take-screenshot ()  
;;       (interactive)  
;;       (let  
;;           ;; Read Filename from Minibuffer  
;;           ((filename (read-from-minibuffer "image file name: "))  
;;            (directory "_media"))  
        
;;         ;; Use maim to screenshot  
;;         (shell-command (format "maim --select %s/%s/%s.png" default-directory directory filename ))  
        
;;         ;; Insert formatted link at point  
;;         (save-excursion (insert(format  
;;                                 "#+attr_html: :width 400px \n #+attr_latex: :width 0.4\\textwidth \n [[file:%s/%s.png]]"  
;;                                 directory filename)))  
        
;;         ;; Message success to the minibuffer  
;;         (message "saved to %s as %s.png" directory filename)  
;;         )
