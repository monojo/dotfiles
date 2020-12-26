;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;  `load!' loading external *.el files
;;  `use-package!' for configuring packages
;;  `after!' for running code after a package has loaded
;;  `add-load-path!'
;;  `require' or `use-package'.
;;  `map!' for binding new keys

(load! "+looking")
(load! "+bindings")
(load! "+lsp")

(setq doom-scratch-buffer-major-mode 'emacs-lisp-mode)

;; use-package!
;; :commands - load package after commands
;; :hook - load till hook triggered
;; :after - load after feature
;; :init - run immediately
;; :conifg
;;
;; after! - work on feature or lib inovke
;; add-hook! - work on mode hook trigger

(use-package! avy
  :commands (avy-goto-char-timer)
  :init
  (setq avy-timeout-seconds 0.2)
  (setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?q ?w ?e ?r ?u ?i ?o ?p))
  )

(after! eshell
  (defun eshell/l (&rest args) (eshell/ls "-l" args))
  (defun eshell/e (file) (find-file file))
  (defun eshell/md (dir) (eshell/mkdir dir) (eshell/cd dir))
  (defun eshell/ft (&optional arg) (treemacs arg))

  (defun eshell/up (&optional pattern)
    (eshell-up pattern))

  (defun +my/ivy-eshell-history ()
    (interactive)
    (require 'em-hist)
    (let* ((start-pos (save-excursion (eshell-bol) (point)))
            (end-pos (point))
            (input (buffer-substring-no-properties start-pos end-pos))
            (command (ivy-read "Command: "
                       (delete-dups
                         (when (> (ring-size eshell-history-ring) 0)
                           (ring-elements eshell-history-ring)))
                       :initial-input input)))
      (setf (buffer-substring start-pos end-pos) command)
      (end-of-line)))

  (defun +my/eshell-init-keymap ()
    (evil-define-key 'insert eshell-mode-map
      (kbd "C-r") #'+my/ivy-eshell-history))
  (add-hook 'eshell-first-time-mode-hook #'+my/eshell-init-keymap)
  )

(use-package! evil-nerd-commenter
  :commands (evilnc-comment-or-uncomment-lines))

(setq isearch-lax-whitespace t)
(setq search-whitespace-regexp ".*")

(define-key isearch-mode-map (kbd "DEL") #'isearch-del-char)

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

(after! flycheck
  ;;(setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  (global-flycheck-mode -1))

(setq whitespace-style (quote (trailing space)))

(use-package! treemacs
  :commands (treemacs)
  :config
  (setq treemacs-width 70)
  )

(use-package! symbol-overlay
  :commands (symbol-overlay-put))

(setq which-key-idle-delay 0)

(after! company
  (setq company-minimum-prefix-length 2
        company-quickhelp-delay nil
        company-show-numbers t
        company-global-modes '(not comint-mode erc-mode message-mode help-mode gud-mode)
        company-idle-delay 0.0
        ))

;; sugestions from lsp-mode
;; set 100mb
(setq gc-cons-threshold 200000000)
(setq read-process-output-max (* 2048 1024)) ;; 2mb
;; (setq lsp-prefer-capf t)
(setq lsp-idle-delay 0.500)

(use-package! lsp-mode
  :commands lsp
  )

;; Use clangd as the cc lsp backend
;; (after! lsp-clients
;;   (remhash 'clangd lsp-clients)
(use-package! lsp-ui
  :load-path "~/Dev/lsp-ui"
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

;; Using binding 'K'
;; (set-lookup-handlers! 'emacs-lisp-mode :documentation #'helpful-at-point)

;; (defadvice isearch-search (after isearch-no-fail activate)
;;   (unless isearch-success
;;     (ad-disable-advice 'isearch-search 'after 'isearch-no-fail)
;;     (ad-activate 'isearch-search)
;;     (isearch-repeat (if isearch-forward 'forward))
;;     (ad-enable-advice 'isearch-search 'after 'isearch-no-fail)
;;     (ad-activate 'isearch-search)))
