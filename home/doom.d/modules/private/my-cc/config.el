;;; private/my-cc/config.el -*- lexical-binding: t; -*-
(load! "+bindings")

(after! cc-mode
  ;; disable rainbow delimiters for cc-mode
  (remove-hook 'c-mode-common-hook #'rainbow-delimiters-mode)
  ;; https://github.com/radare/radare2
  (c-add-style
   "radare2"
   '((c-basic-offset . 4)
     (indent-tabs-mode . t)
     (c-auto-align-backslashes . nil)
     (c-offsets-alist
      (arglist-intro . ++)
      (arglist-cont . ++)
      (arglist-cont-nonempty . ++)
      (statement-cont . ++)
      )))
  (c-add-style
   "my-cc" '("user"
             (c-basic-offset . 2)
             (c-offsets-alist
              . ((innamespace . 0)
                 (access-label . -)
                 (case-label . 0)
                 (member-init-intro . +)
                 (topmost-intro . 0)
                 (arglist-cont-nonempty . +)))))
  ;; cc code style
  (setq cc-default-style "radare2")
  (add-hook 'c-mode-common-hook
            (lambda ()
              ;; TODO work around https://github.com/hlissner/doom-emacs/issues/1006
              ;; (when (and buffer-file-name (string-match-p "binutils\\|glibc" buffer-file-name))
              ;;   (setq tab-width 8)
              ;;   (c-set-style "gnu"))
              (setq flymake-diagnostic-functions '(lsp--flymake-backend t))
              (modify-syntax-entry ?_ "w")
              ))

  (add-to-list 'auto-mode-alist '("\\.inc\\'" . +cc-c-c++-objc-mode)))

;; Custom Faces for ccls-sem-...-faces in semantic highlighting
;; ccls-sem-...-faces:
;; function -> Method, Constructor, local function, Static Method
;; macro -> Macros
;; namespace -> Namespace
;; parameter -> Parameter
;; type -> Struct, Class, Enum, TypeParameter, TypeAliases
;; variable -> variables
;; See details in ccls-sematic-highlight.el
(defface my-ccls-sem-parameter-face
  ;; '((t :inherit font-lock-builtin-face :slant italic))
  '((t :slant italic))
  "Parameter face"
  :group 'my-sem)

(defface my-ccls-sem-function-face
  ;; height 1.2 seems too big
  '((t :inherit font-lock-function-name-face :height 1.1))
  "Function face"
  :group 'my-sem)

(defface my-ccls-sem-macro-face
  '((t :inherit font-lock-keyword-face :weight normal))
  "Macro face"
  :group 'my-sem)

;; (defface my-ccls-sem-type-face
;;   '((t :weight bold :foreground "#a4ffff"))
;;   :group 'ccls-sem)

(use-package! ccls
  :hook ((c-mode-local-vars c++-mode-local-vars) . +ccls|enable)
  ;;:hook ((c-mode c++-mode) . (lambda () (require 'ccls)(require 'lsp-ui) (lsp)))
  :init
  (after! projectile
    (add-to-list 'projectile-globally-ignored-directories ".ccls-cache")
    (add-to-list 'projectile-project-root-files-bottom-up ".ccls-root"))
  (after! lsp-mode (require 'ccls))
  :config
  (evil-set-initial-state 'ccls-tree-mode 'emacs)
  ;; setq works for these custom variable after ccls loaded
  (setq ccls-sem-parameter-faces [my-ccls-sem-parameter-face])
  (setq ccls-sem-function-faces [my-ccls-sem-function-face])
  (setq ccls-sem-macro-faces [my-ccls-sem-macro-face])
  (setq ccls-sem-highlight-method 'font-lock)
  (setq
   ccls-initialization-options
   `(:clang
     (:excludeArgs
      ;;Linux's gcc options. See ccls/wiki
      ["-falign-jumps=1" "-falign-loops=1" "-fconserve-stack" "-fmerge-constants" "-fno-code-hoisting" "-fno-schedule-insns" "-fno-var-tracking-assignments" "-fsched-pressure"
       "-mhard-float" "-mindirect-branch-register" "-mindirect-branch=thunk-inline" "-mpreferred-stack-boundary=2" "-mpreferred-stack-boundary=3" "-mpreferred-stack-boundary=4" "-mrecord-mcount" "-mindirect-branch=thunk-extern" "-mno-fp-ret-in-387" "-mskip-rax-setup"
       "--param=allow-store-data-races=0" "-Wa arch/x86/kernel/macros.s" "-Wa -"]
      :extraArgs []
      :pathMappings ,+ccls-path-mappings)
     :completion
     (:include
      (:blacklist
       ["^/usr/(local/)?include/c\\+\\+/[0-9\\.]+/(bits|tr1|tr2|profile|ext|debug)/"
        "^/usr/(local/)?include/c\\+\\+/v1/"
        ]))
     :index (:initialBlacklist ,+ccls-initial-blacklist :parametersInDeclarations :json-false :trackDependency 1)
     :cache (:directory "/tmp/ccls-cache")
     ))
  )

;; modern c++ highlight
(use-package! modern-cpp-font-lock
  :hook (c++-mode . modern-c++-font-lock-mode))

;; format c++ code
;; only work if there' a .clang-format file
;; (use-package! clang-format
;;   :commands (clang-format-region)
;;   )

