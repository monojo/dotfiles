;;; ~/.doom.d/+looking.el -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "Monospace" :size 25)
      doom-variable-pitch-font (font-spec :family "Monospace")
      doom-unicode-font (font-spec :family "Monospace")
)
(setq doom-big-font (font-spec :family "Monospace" :size 27))

(remove-hook 'doom-init-ui-hook #'blink-cursor-mode)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)

(setq display-line-numbers-type 'relative)
(setq global-display-line-numbers-mode t)
