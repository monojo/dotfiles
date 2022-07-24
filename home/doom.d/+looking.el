;;; ~/.doom.d/+looking.el -*- lexical-binding: t; -*-

;; (setq doom-font (font-spec :family "Monospace" :size 15)
;;       doom-variable-pitch-font (font-spec :family "Monospace")
;;       doom-unicode-font (font-spec :family "Monospace")
;; )
;; (setq doom-big-font (font-spec :family "Monospace" :size 19))

(setq doom-font (font-spec :family "Fantasque Sans Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Fantasque Sans Mono")
      doom-unicode-font (font-spec :family "Fantasque Sans Mono")
)
(setq doom-big-font (font-spec :family "Fantasque Sans Mono" :size 19))

;; (setq doom-font (font-spec :family "Droid Sans Mono" :size 15)
;;       doom-variable-pitch-font (font-spec :family "Droid Sans Mono")
;;       doom-unicode-font (font-spec :family "Droid Sans Mono")
;; )
;; (setq doom-big-font (font-spec :family "Droid Sans Mono" :size 19))

;; (setq doom-font (font-spec :family "Fira Code" :size 15)
;;       doom-variable-pitch-font (font-spec :family "Fira Code")
;;       doom-unicode-font (font-spec :family "Fira Code")
;; )
;; (setq doom-big-font (font-spec :family "Fira Code" :size 19))

(remove-hook 'doom-init-ui-hook #'blink-cursor-mode)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-dracula)
(setq doom-theme 'my-github-modern)
;; (setq doom-theme 'doom-tomorrow-day)
;; (setq doom-theme 'doom-one-light)
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)

(setq display-line-numbers-type 'relative)
(setq global-display-line-numbers-mode t)
