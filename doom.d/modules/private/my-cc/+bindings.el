;;; private/my-cc/+bindings.el -*- lexical-binding: t; -*-

(map! :after ccls
      :map (c-mode-map c++-mode-map)
      (:localleader
       :desc "Preprocess file"        "lp" #'ccls-preprocess-file
       :desc "Reload cache & CCLS"    "lf" #'ccls-reload)
      (:after lsp-ui-peek
       (:localleader
        :desc "References (address)"  "a" #'+cc/ccls-show-references-address
        :desc "References (not call)" "f" #'+cc/ccls-show-references-not-call
        :desc "References (Macro)"    "m" #'+cc/ccls-show-references-macro
        :desc "find-ref" "r" #'+my/find-references
        :m "w" #'+default/search-project-for-symbol-at-point
        :desc "List Ctags Symbol" :m "T" #'counsel-etags-list-tag
        :m "c" nil
        (:prefix ("c" . "Comment")
         "c" #'evilnc-comment-or-uncomment-lines
         "u" #'evilnc-comment-or-uncomment-lines))))
