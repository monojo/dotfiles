;;; private/my-python/config.el -*- lexical-binding: t; -*-

(use-package! python
  :init
  (add-hook 'python-mode-local-vars-hook #'lsp!)
  :config
  ;(lsp-register-custom-settings
   ;'(("pyls.plugins.pyls_mypy.enabled" t t)
     ;("pyls.plugins.pyls_mypy.live_mode" t t)
     ;("pyls.plugins.pyls_black.enabled" t t)
     ;("pyls.plugins.pyls_isort.enabled" t t)
     ;))
  )
