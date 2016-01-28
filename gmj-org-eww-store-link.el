(add-hook 'org-store-link-functions 'gmj-org-eww-store-link)

(defun gmj-eww-copy-page-title ()
  "Copy the title of the current page into the kill ring."
  (interactive)
  (message "%s" (plist-get eww-data :title))
  (kill-new (plist-get eww-data :title)))


(defun gmj-org-eww-store-link ()
  "Store a link to a eww buffer."
  (when (eq major-mode 'eww-mode)
    (org-store-link-props
     :type "eww"
     :link (eww-copy-page-url)
     :url (url-view-url t)
     :description (or (gmj-eww-copy-page-title) (eww-copy-page-url)))))












