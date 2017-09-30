(require 'xah-fly-keys)

(xah-fly-keys-set-layout "qwerty") ; required if you use qwerty
;; (xah-fly-keys-set-layout "workman") ; required if you use workman
;; (xah-fly-set-layout "dvorak") ; by default, it's dvorak

(xah-fly-keys 1)

(add-to-list 'load-path "path/to/which-key.el")
(require 'which-key)
(which-key-mode)
