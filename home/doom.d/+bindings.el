;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

(define-inline +my/prefix-M-x (prefix)
  (inline-quote
   (lambda () (interactive)
     (setq unread-command-events (string-to-list ,prefix))
     (call-interactively #'execute-extended-command))))

(define-inline +my/simulate-key (key)
  (inline-quote
   (lambda () (interactive)
     (setq prefix-arg current-prefix-arg)
     (setq unread-command-events (listify-key-sequence (read-kbd-macro ,key))))))

(general-define-key :states '(normal visual motion) "x" nil)

;; Global mapping
;; :m mapping, :n,v,i mode mapping
;; :map ...mode
;; :prefix prefix for following mapping
(map!
 ;; unbind anymap to our localleader
 :m ","    nil

 (:map prog-mode-map
  :n "H"  #'+my/xref-jump-backward-file
  :n "L"  #'+my/xref-jump-forward-file)

 :m "C-h" #'evil-window-left
 :m "C-l" #'evil-window-right
 :m "C-j" #'evil-window-down
 :m "C-k" #'evil-window-up

 :n "M-."  #'+lookup/definition
 ;; Search
 :n "/"  #'swiper
 ;; Search workspace symbol with lsp
 :n "ga"   #'+my/workspace-symbol
 :n "gA"   (λ! (setq current-prefix-arg t) (call-interactively #'+my/workspace-symbol))

 ;; Jump
 :n "f" #'avy-goto-char
 ;; Symbol/word jump
 :n ";"    (λ! (if lsp-mode
                   (progn (+my/avy-document-symbol t)
                          (+my/find-definitions))
                 (avy-goto-word-0 nil)))
 :n "z;"   (λ! (+my/avy-document-symbol nil))

 :n "C-1" #'+popup/raise
 ;; :n "M-j"  #'+my/find-definitions
 ;; :n "C-,"  #'+my/find-references
 ;; :n "gf"   #'+my/ffap

 ;; Get text property
 :n "go"   (λ! (message "%S" (text-properties-at (point))))

 :n "Q" #'kill-current-buffer

 (:prefix "x"
  ;; jump to symbol and xref
  :n ";" (λ! (+my/avy-document-symbol t) (+my/find-references))

  ;; $ccls/inheritance
  :n "b" (λ! (ccls/base 1))
  :n "B" (λ! (ccls/base 3))
  :n "d" (λ! (ccls/derived 1))
  :n "D" (λ! (ccls/derived 3))
  :n "i" #'ccls-inheritance-hierarchy          ; base hierarchy
  :n "I" (λ! (ccls-inheritance-hierarchy t))   ; derived hierarchy

  ;; symbol read, write
  :n "r" #'ccls/references-read
  :n "w" #'ccls/references-write
  ;; $ccls/call
  :n "c" #'ccls/caller
  :n "C" #'ccls/callee
  ;; caller hierarchy
  :n "e" #'ccls-call-hierarchy
  ;; callee hierarchy
  :n "E" (λ! (ccls-call-hierarchy t))

  ;; $ccls/member
  :n "s" (λ! (ccls/member 2))     ; 2 (Type) => nested classes/namespace members
  :n "f" (λ! (ccls/member 3))     ; 3 (Func) => member functions
  :n "m" (λ! (ccls/member 0))     ; other => member variables
  :n "M" #'ccls-member-hierarchy

  :n "L" #'ccls-code-lens-mode
  :n "t" #'lsp-goto-type-definition
  ;; https://github.com/maskray/ccls/blob/master/src/messages/ccls_vars.cc#L15
  :n "v" (λ! (ccls/vars 3))             ; field or local variable
  :n "V" (λ! (ccls/vars 1))             ; field
  :n "C-v" (λ! (ccls/vars 7))           ; any
  :n "x" #'evil-delete-char))

;; SPC
(map! :leader
      (:prefix "b"
       :desc "Last buffer" :n "b" #'evil-switch-to-windows-last-buffer
       "l" #'ivy-switch-buffer          ; List All Buffers
       )
      (:prefix ("e" . "error")
       "n" #'flycheck-next-error
       "p" #'flycheck-previous-error
       )
      (:prefix "g"
       "*" (+my/prefix-M-x "magit-")
       :desc "Magit blame"               "b"   #'magit-blame-addition
       :desc "Magit switch branch"       "B"   #'magit-branch-checkout
       :desc "git-link"                    "q" #'git-link
       )
      (:prefix "h"
       "C" #'helpful-command
       )
      (:prefix ("l" . "lsp")
       "=" #'lsp-format-buffer
       "a" #'lsp-execute-code-action
       "l" #'lsp-ui-sideline-mode
       "d" #'lsp-ui-doc-mode
       "e" #'flymake-show-diagnostics-buffer
       "i" #'lsp-ui-imenu
       "r" #'lsp-rename
       "R" #'lsp-restart-workspace
       "w" #'lsp-ui-peek-find-workspace-symbol
       )
      :desc "lispyville" :n "L" (+my/prefix-M-x "lispyville ")
      (:prefix "o"
       "d" #'+debugger:start
       "o" #'symbol-overlay-put
       "q" #'symbol-overlay-remove-all
       )
      (:prefix "p"
       "e" #'projectile-run-eshell
       "f" #'counsel-projectile-find-file
       "*" (+my/prefix-M-x "projectile-")
       )
      ;; Snippets
      (:prefix ("S" . "snippets")
       :desc "New snippet"            "n" #'yas-new-snippet
       :desc "Insert snippet"         "i" #'yas-insert-snippet
       :desc "Find snippet for mode"  "s" #'yas-visit-snippet-file
       :desc "Find snippet"           "S" #'+default/find-in-snippets)

      ;; Search
      (:prefix ("s" . "search")
       "b" #'swiper-all                 ;Search all buffer
       :desc "Directory"              "d" #'+ivy/project-search-from-cwd
       :desc "Project"                "/" #'+ivy/project-search
       ;; "s" (λ! (minibuffer-with-setup-hook
       ;;             (lambda () (insert ivy--default)) (+ivy/project-search)))
       :desc "Symbols"                "i" #'imenu ;search symbol
       ;; :desc "Symbols across buffers" "I" #'imenu-anywhere
       :desc "Online providers"       "o" #'+lookup/online-select
       :desc "Search Marks/Ivy"       "R" #'counsel-evil-marks
       )

      (:prefix ("t" . "toggle")
       "d" #'toggle-debug-on-error
       "D" #'+my/realtime-elisp-doc
       )
      (:prefix "r"
       "l" #'ivy-resume
       ))

(map!
 (:map go-mode-map
  :localleader
  "r" nil ;;unmap r
  "d" nil
  :n "d" #'+my/find-definitions
  :n "r" #'+my/find-references)
 )

;; Localleader ,
(map! :localleader
      "r" nil
      "d" nil
      :m "w" #'+default/search-project-for-symbol-at-point
      :m "b" #'+ivy/switch-workspace-buffer
      :m "h" #'symbol-overlay-put
      :m "cc" #'evilnc-comment-or-uncomment-lines
      :m "cu" #'evilnc-comment-or-uncomment-lines
      :desc "find-def" "d" #'+my/find-definitions
      :desc "find-ref" "r" #'+my/find-references
      :m "s" #'yas-insert-snippet
      :m "m" #'counsel-evil-marks
      )


;; Mappings when tools invoked
(map!
 (:after evil-collection-info
  :map Info-mode-map
  "/" #'Info-search
  "?" #'Info-search-backward
  )

 (:after company
  (:map company-active-map
   ;; Don't interfere with `evil-delete-backward-word' in insert mode
   ;; "C-v"        #'company-next-page
   ;; "M-v"        #'company-previous-page
   "C-i"        #'company-complete-selection
   [tab]        #'company-complete-selection
   "RET"        nil
   [return]     nil
   "SPC"        nil))
 (:after realgud
  (:map realgud-track-mode-map
    :in ";" #'realgud-window-src-undisturb-cmd
    :in "C-j" (λ! (realgud:cmd-repeat-last) (realgud-window-src-undisturb-cmd)))
  (:map realgud:shortkey-mode-map
   ;; :n "e" (λ! (realgud:cmd-run-command (thing-at-point 'symbol) "eval"))
   :n "i" #'realgud-window-cmd-undisturb-src
   :n "t" #'realgud:cmd-tbreak
   :n "U" #'realgud:cmd-until
   :n "1" (λ! (+my/realgud-eval-nth-name-forward 1))
   :n "2" (λ! (+my/realgud-eval-nth-name-forward 2))
   :n "3" (λ! (+my/realgud-eval-nth-name-forward 3))
   :n "4" (λ! (+my/realgud-eval-nth-name-forward 4))
   :n "5" (λ! (+my/realgud-eval-nth-name-forward 5))
   :n "6" (λ! (+my/realgud-eval-nth-name-forward 6))
   :n "7" (λ! (+my/realgud-eval-nth-name-forward 7))
   :n "8" (λ! (+my/realgud-eval-nth-name-forward 8))
   :n "9" (λ! (+my/realgud-eval-nth-name-forward 9))
   )
  )
 )
;; (:after magit
;;   (:map magit-revision-mode-map
;;   "gq"        #'+my/open-issue-in-browser))

