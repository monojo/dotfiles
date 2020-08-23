(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
  '(c-font-lock-extra-types
     (quote
       ("\\sw+_t" "bool" "complex" "imaginary" "FILE" "lconv" "tm" "va_list" "jmp_buf" "Lisp_Object")))
 '(lsp-ui-doc-border "#f8f8f2")
 '(lsp-ui-doc-enable nil)
 '(lsp-ui-doc-max-height 8)
 '(lsp-ui-doc-max-width 35)
 '(lsp-ui-sideline-ignore-duplicate t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ccls-sem-global-variable-face ((t (:weight extra-bold :height 1.1))))
 '(ccls-sem-static-method-face ((t (:inherit font-lock-function-name-face :weight bold))))
 '(font-lock-type-face ((t (:foreground "#8be9fd"))))
 '(lsp-ui-peek-highlight ((t (:inherit lsp-ui-peek-header :background "gray" :foreground "#282a36" :box 1)))))
