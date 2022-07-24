;;; private/my-python/config.el -*- lexical-binding: t; -*-

(use-package! python
  :init
  (add-hook 'python-mode-local-vars-hook #'lsp!)
  :config
  )

(use-package! lsp-pyright
  :ensure t
  :hook (python-mode . (lambda () (require 'lsp-pyright) (lsp)))
  :config
  (setq lsp-pyright-typechecking-mode "basic")
  )
