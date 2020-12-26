;;; private/my-cc/config.el -*- lexical-binding: t; -*-
(load! "+bindings")

(after! realgud
  (setq realgud-safe-mode nil)
  (evil-collection-define-key 'normal 'realgud:shortkey-mode-map
    "d" #'realgud:cmd-newer-frame
    "D" #'realgud:cmd-delete
    "u" #'realgud:cmd-older-frame
    )
  )

(after! cc-mode
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

;; Define Faces for ccls-sem- for semantic highlighting
;; list of ccls-sem: method, constructor, function, staticmethod
;; namespace, struct==class, enum, typeparameter, typealias,
;; variable, parameter, macro, field, enummember
;; See details in ccls-sematic-highlight.el
(defface my-ccls-sem-parameter-face
  '((t :inherit font-lock-builtin-face :weight light))
  "Parameter face"
  :group 'my-sem)

(defface my-ccls-sem-function-face
  '((t :inherit font-lock-function-name-face :height 1.2))
  "Function face"
  :group 'my-sem)

(defface my-ccls-sem-macro-face
  '((t :inherit font-lock-keyword-face :weight extra-bold))
  "Macro face"
  :group 'my-sem)

(defface my-ccls-sem-static-func-face
  '((t :inherit font-lock-function-name-face :weight extra-bold))
  "Macro face"
  :group 'my-sem)

;; (defface my-ccls-sem-struct-face
;;   '((t :slant italic))
;;   ""
;;   :group 'ccls-sem)

;; (defface my-ccls-sem-type-face
;;   '((t :weight bold :foreground "#a4ffff"))
;;   :group 'ccls-sem)

;; (defface my-ccls-sem-class-field-face
;;   '((t :slant italic))
;;   "Class/struct filed"
;;   :group 'ccls-sem)

(use-package! ccls
  :hook ((c-mode c++-mode) . +ccls|enable)
  :config
  ;; rainbow highlight, will override your theme
  (setq ccls-sem-parameter-faces [my-ccls-sem-parameter-face])
  (setq ccls-sem-function-faces [my-ccls-sem-function-face])
  (setq ccls-sem-macro-faces [my-ccls-sem-macro-face])
  (setq lsp-enable-semantic-highlighting t)
  ;(setq ccls-sem-macro-faces [my-ccls-sem-macro-face])
  ;; (setq ccls-sem-member-faces [my-ccls-sem-macro-face])
  ;; (setq ccls-sem-type-faces [my-ccls-sem-type-face])
  ;; (setq font-lock-type-face [my-ccls-sem-type-face])
  ;; (ccls-use-default-rainbow-sem-highlight)
    ;; https://github.com/maskray/ccls/blob/master/src/config.h
    (setq
      ccls-initialization-options
      `(:clang
         (:excludeArgs
           ;; Linux's gcc options. See ccls/wiki
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

    (after! projectile
      (add-to-list 'projectile-globally-ignored-directories ".ccls-cache"))

  (evil-set-initial-state 'ccls-tree-mode 'emacs))

;; modern c++ highlight
(use-package! modern-cpp-font-lock
  :hook (c++-mode . modern-c++-font-lock-mode))

;; format c++ code
;; only work if there' a .clang-format file
;; (use-package! clang-format
;;   :commands (clang-format-region)
;;   )

;;;###autoload
(defvar +ccls-path-mappings [])

;;;###autoload
(defvar +ccls-initial-blacklist [])

;;;###autoload
(defvar +lsp-blacklist nil)
