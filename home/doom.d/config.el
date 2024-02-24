;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;  `load!' loading external *.el files
;;  `use-package!' for configuring packages
;;  `after!' for configuring after a package/feature has loaded
;;  `add-load-path!'
;;  `require' or `use-package'.
;;  `map!' for binding new keys
;;  Avoid using `Customize', use `setq', `setq!' in doom emacs

;; Theme, Font
(load! "+looking")
;; Keybindings
(load! "+bindings")

(setq doom-scratch-buffer-major-mode 'emacs-lisp-mode)

(set-default-coding-systems 'utf-8)

;;use command as meta
(setq mac-command-modifier 'meta)

;; `use-package!' Usage
;; All the flowings indicate the timing of loading the package
;; :commands - load package after commands executed
;; :hook - load package till hook triggered
;; :after - load package after feature
;; :init - run immediately
;; :conifg - the actual configuration
;; add-hook! - work when a mode-hook triggered

;; Motion jump
(use-package! avy
  :commands (avy-goto-char-timer)
  :init
  (setq avy-timeout-seconds 0.2)
  (setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?q ?w ?e ?r ?u ?i ?o ?p))
  )

;; eshell
(after! eshell
  (defun eshell/l (&rest args) (eshell/ls "-l" args))
  (defun eshell/e (file) (find-file file))
  (defun eshell/md (dir) (eshell/mkdir dir) (eshell/cd dir))
  (defun eshell/ft (&optional arg) (treemacs arg))

  (defun eshell/up (&optional pattern)
    (eshell-up pattern))

  ;; (defun +my/ivy-eshell-history ()
  ;;   (interactive)
  ;;   (require 'em-hist)
  ;;   (let* ((start-pos (save-excursion (eshell-bol) (point)))
  ;;          (end-pos (point))
  ;;          (input (buffer-substring-no-properties start-pos end-pos))
  ;;          (command (ivy-read "Command: "
  ;;                             (delete-dups
  ;;                              (when (> (ring-size eshell-history-ring) 0)
  ;;                                (ring-elements eshell-history-ring)))
  ;;                             :initial-input input)))
  ;;     (setf (buffer-substring start-pos end-pos) command)
  ;;     (end-of-line)))

  ;; (defun +my/eshell-init-keymap ()
  ;;   (evil-define-key 'insert eshell-mode-map
  ;;     (kbd "C-r") #'+my/ivy-eshell-history))
  ;; (add-hook 'eshell-first-time-mode-hook #'+my/eshell-init-keymap)
  )

;; Comment code
(use-package! evil-nerd-commenter
  :commands (evilnc-comment-or-uncomment-lines))

(setq isearch-lax-whitespace t)
(setq search-whitespace-regexp ".*")

(define-key isearch-mode-map (kbd "DEL") #'isearch-del-char)

;; Search symbol, file, & everything
(use-package! ivy
  :config
  (setq
   ;; use regex-plus finding
   ;; space as wild card
   ;; everything should be match before '!'
   ivy-re-builders-alist '((swiper . ivy--regex-plus)
                           (swiper-isearch . ivy--regex-plus)
                           (counsel-rg . ivy--regex-plus)
                           (t . ivy--regex-plus))))

;; error check on the fly
(after! flycheck
  ;;(setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  (global-flycheck-mode -1))

(setq whitespace-style (quote (trailing space)))

;; Show hierarchycal folders & symbols
(use-package! treemacs
  :commands (treemacs)
  :config
  (setq treemacs-width 70)
  )

;; Highlight the current word & more
(use-package! symbol-overlay
  :commands (symbol-overlay-put))

;; Show keybindings on the fly
(setq which-key-idle-delay 0)

;; Completion popup
(after! company
  (setq company-minimum-prefix-length 3
        company-quickhelp-delay nil
        company-show-numbers nil
        company-global-modes '(not comint-mode erc-mode message-mode help-mode gud-mode)
        company-idle-delay 0.8
        ;;company-idle-delay nil
        ;;company-dabbrev-downcase 0
        ))

;; Garbage collection setting
;; sugestions from lsp-mode
;; set 100mb
(setq gc-cons-threshold 200000000)
(setq read-process-output-max (* 2048 1024)) ;; 2mb
;; (setq lsp-prefer-capf t)
;; This may affect scrolling
(setq lsp-idle-delay 0.200)

;; Debug support
;; (use-package! dap-mode
;;   :config
;;   (setq dap-gdb-lldb-path "~/Downloads/debug"))

;; lsp-mode settings
(use-package! lsp-mode
  :commands lsp
  :config
  (setq lsp-semantic-tokens-enable t)
  (setq lsp-auto-guess-root t lsp-eldoc-prefer-signature-help nil)
  (setq lsp-enable-links nil)
  (setq lsp-prefer-flymake nil)
  (setq lsp-enable-file-watchers nil)
  (setq lsp-keep-workspace-alive nil)
  (setq lsp-headerline-breadcrumb-enable t
        lsp-headerline-breadcrumb-enable-symbol-numbers t
        lsp-lens-enable nil)
  (setq lsp-ui-doc-enable nil)
  )
  ;;(lsp-register-custom-settings
  ;; '(("gopls.semanticTokens" t t)
  ;;   ("gopls.staticcheck" t t)))

  ;)
;; (after! lsp-mode
;;   (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

;; Use clangd as the cc lsp backend
;; (after! lsp-clients
;;   (remhash 'clangd lsp-clients)

;; Use official lsp-ui
(use-package! lsp-ui
  :commands lsp-ui-mode
  :config
  (setq
   lsp-ui-sideline-enable t
   lsp-ui-sideline-ignore-duplicate t
   lsp-ui-doc-header nil
   lsp-ui-doc-include-signature nil
   lsp-ui-doc-background (doom-color 'base4)
   lsp-ui-doc-border (doom-color 'fg)

   lsp-ui-peek-expand-function (lambda (xs) (mapcar #'car xs))
   )

  (map! :after lsp-ui-peek
        :map lsp-ui-peek-mode-map
        "h" #'lsp-ui-peek--select-prev-file
        "j" #'lsp-ui-peek--select-next
        "k" #'lsp-ui-peek--select-prev
        "l" #'lsp-ui-peek--select-next-file
        )
  )
;; need this to make ccls semantic highlighting work
;; (setq lsp-enable-semantic-highlighting t)

;; Setup org-mode
;; Use icloud
(setq org-directory "/Users/xzhang/Library/Mobile Documents/com~apple~CloudDocs/org")
(after! org
  :config
  ;; open org link in a new window
  (setq org-link-frame-setup
        '((file . find-file-other-window)
          ))
  )

;; Custom faces per theme
(custom-theme-set-faces! 'doom-dracula
  ;;type to light ocean blue
  '(font-lock-type-face :foreground "#8be9fd")
  '(font-lock-variable-name-face :foreground "white")
  )
(custom-theme-set-faces! 'my-github-modern
  ;; purple
  '(font-lock-builtin-face :foreground "#6f42c1")
  '(highlight-numbers-number :foreground "#005cc5")
  )
(custom-theme-set-faces! 'doom-plain
  ;; purple
  '(font-lock-function-name-face :slant normal :weight bold)
  )

;; Custom ccls & lsp faces
;; Some ccls-faces are customized in my-cc/config.el
;; List:
;; ...-global-varirable-face
;; ...-local-face
;; ...-local-function-face
;; ...-member-face
;; ...-static-face
;; ...-static-field-face
;; ...-static-method-face
;; or use face-spec-set?
;;;; These following settings depend on `doom-load-theme-hook'. The ccls-sem-... are void at that time
;;;; So this can only be used to change the existing doom-theme
(custom-set-faces!
  '(ccls-sem-global-variable-face :weight bold :height 1.1)
  '(ccls-sem-member-face :slant normal)
  '(ccls-sem-static-method-face :inherit font-lock-function-name-face :weight bold)
  ;;
  '(lsp-ui-peek-highlight :inherit lsp-ui-peek-header :background "gray" :foreground "#282a36" :box 1)
  ;; Note: Some lsp-face seems overwrite by ccls-faces
  ;;'(lsp-face-semhl-function :inherit font-lock-function-name-face :height 1.1)
  ;;'(lsp-face-semhl-parameter :weight light :slant italic)
  ;;'(lsp-face-highlight-read :background "sea green")
  ;;'(lsp-face-highlight-write :background "brown4")
  ;; '(lsp-face-semhl-macro-face :inherit font-lock-keyword-face :weight bold)
  ;; '(lsp-face-semhl-method :height 1.1)
  )
