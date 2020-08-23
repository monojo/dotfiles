;; -*- no-byte-compile: t; -*-
;;; private/my-lsp/packages.el

(unpin! lsp-ui)
(package! lsp-ui :recipe (:host github :repo "monojo/lsp-ui"))
