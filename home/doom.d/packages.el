;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; Install: doom sync

;(package! some-package)
;  :recipe (:host github :repo "username/repo"))

;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; `:disable' means purge
;(package! builtin-package :disable t)

;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")

;(unpin! pinned-package)
;(unpin! pinned-package another-pinned-package)

;; ==== Packages ====
(package! rg)
;; treemacs with lsp
(package! lsp-treemacs)
;; symbol highlighting and more
(package! symbol-overlay)
;; generate git linkage
(package! git-link)


;;;; ==== Temp Disabled ====
;; disable since ui bug
;; (package! lsp-ui :disable t)
;; z jump in eshell
(package! eshell-autojump :disable t)
;; convert buffer content to html
(package! htmlize :disable t)
;; open link avy
(package! link-hint :disable t)
;; another man
(package! tldr :disable t)
;; a lsp client
(package! eglot :disable t)
;; buffer selection tool, ivy good enough for me
(package! frog-jump-buffer :disable t)
;; motion based on syntax
(package! smart-forward :disable t)
;; highlight current word through buffer
(package! highlight-symbol :disable t)
;; d lang
(package! d-mode :disable t)
;; Buffer tab, and num selection
(package! awesome-tab :recipe (:host github :repo "manateelazycat/awesome-tab") :disable t)
;; edit chrome text in emacs
(package! atomic-chrome :disable t)
;; try a package
(package! try :disable t)
;; new theme
(package! xcode-theme :recipe (:host github :repo "juniorxxue/xcode-theme") :disable t)
;;;; ==== Disabled packages ====
(disable-packages! company-prescient)
