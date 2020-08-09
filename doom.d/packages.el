;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
;; To install a package with Doom you must declare them here, run 'doom sync' on
;; the command line, then restart Emacs for the changes to take effect.
;; Alternatively, use M-x doom/reload.

;; ==== Motion ====
;; char jump motion
(package! avy)

;; ==== LSP ====
;; set :tools lsp will install lsp-ui, lsp-mode, company-lsp, lsp-ivy
;; set :lang (cc +lsp) install ccls, irony*(disabled), modern-cpp-font-lock
(package! spinner)                      ; required by lsp-mode

;; ==== Finder ====
;; e-ctags using counsel, symbol search
(package! rg)
;; (package! counsel-etags)
;; company lsp backend
(package! company-lsp)

;; ==== MISC ====
;; comment
(package! evil-nerd-commenter)
;; symbol highlighting and more
(package! symbol-overlay)
;; z jump in eshell
(package! eshell-autojump)
;; more complete evil binding
(package! evil-collection)
;; edit chrome text in emacs
(package! atomic-chrome)
;; lisp evil plug
(package! lispyville)
;; another man
(package! tldr)
;; open link avy
(package! link-hint)
;; convert buffer content to html
(package! htmlize)
;; try a package
(package! try)
;; a lsp client
(package! eglot :disable t)
;; buffer selection tool
(package! frog-jump-buffer :disable t)
;; motion based on syntax
(package! smart-forward :disable t)
;; highlight current word through buffer
(package! highlight-symbol :disable t)
;; d lang
(package! d-mode :disable t)
;; generate git linkage
(package! git-link :disable t)
;; Buffer tab, and num selection
(package! awesome-tab :recipe (:host github :repo "manateelazycat/awesome-tab") :disable t)

;;;; ==== Disabled packages ====
(disable-packages! company-prescient)
