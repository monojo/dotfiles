;; -*- no-byte-compile: t; -*-
;;; private/my-cc/packages.el

;; ccls client
;; :lang (cc +lsp) will install ccls
;; (package! ccls)
;; modern cpp syntax
;; (package! modern-cpp-font-lock)
;;highlight for CMakeLists.txt and .cmake
;; (package! cmake-mode :recipe (:host github :repo "emacsmirror/cmake-mode" :files (:defaults "*")))
;; debugger support
;; formater based on clang-format
;; (package! clang-format)
;; All above installed in :lang cc module
;;
;; demangle-mode help demangle cc symbols
;; disaster disamble code under cursor
;; glsl-mode for opengl shading language
(package! realgud)
