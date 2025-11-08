;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

(setq user-full-name "Luke Holland"
      user-mail-address "lukeanthonyholland@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(load-theme 'ef-tritanopia-dark t)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(set-frame-parameter (selected-frame) 'alpha 95)

(menu-bar-mode -1)
(tool-bar-mode -1)

(set-default 'cursor-type '(hbar . 3))
(blink-cursor-mode 0)

;; LLM
(defconst OLLAMA-API-KEY (getenv "OLLAMA_API_KEY"))

(setq
 gptel-expert-commands t
 gptel-model 'kimi-k2:1t-cloud
 gptel-backend (gptel-make-ollama "Ollama"
                 :host "ollama.com"
                 :protocol "https"
                 :header `(("Authorization" . ,OLLAMA-API-KEY))
                 :stream t
                 :models '(kimi-k2:1t-cloud)))

(setq doom-modeline-window-width-limit fill-column
      doom-modeline-icon (display-graphic-p)
      doom-modeline-major-mode-icon t
      doom-modeline-major-mode-color-icon t
      doom-modeline-buffer-state-icon t
      doom-modeline-buffer-modification-icon t
      doom-modeline-unicode-fallback nil
      doom-modeline-minor-modes nil
      doom-modeline-enable-word-count nil
      doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode)
      doom-modeline-buffer-encoding t
      doom-modeline-indent-info t
      doom-modeline-checker-simple-format t
      doom-modeline-number-limit 99
      doom-modeline-vcs-max-length 12
      doom-modeline-workspace-name t
      doom-modeline-persp-name t
      doom-modeline-display-default-persp-name nil
      doom-modeline-persp-icon t
      doom-modeline-lsp t
      doom-modeline-github t
      doom-modeline-github-interval (* 30 60)
      doom-modeline-modal-icon t
      doom-modeline-mu4e t
      doom-modeline-gnus t
      doom-modeline-battery t
      doom-modeline-gnus-timer 2
      doom-modeline-irc t
      doom-modeline-irc-stylize 'identity
      doom-modeline-env-version t
      doom-modeline-env-enable-python t
      doom-modeline-env-enable-ruby t
      doom-modeline-env-enable-perl t
      doom-modeline-env-enable-go t
      doom-modeline-env-enable-elixir t
      doom-modeline-env-enable-rust t
      doom-modeline-env-python-executable "python"
      doom-modeline-env-ruby-executable "ruby"
      doom-modeline-env-perl-executable "perl"
      doom-modeline-env-go-executable "go"
      doom-modeline-env-elixir-executable "iex"
      doom-modeline-env-rust-executable "rustc"
      doom-modeline-env-load-string "..."
      doom-modeline-before-update-env-hook nil
      doom-modeline-after-update-env-hook nil
      doom-modeline-height 30
      doom-modeline-bar-width 10
      inhibit-compacting-font-caches t
      find-file-visit-truename t)

;; Iosevka Font
(setq doom-font (font-spec :family "Iosevka Slab" :size 15))
(if (facep 'mode-line-active)
    (set-face-attribute 'mode-line-active nil :family "Iosevka Slab" :height 106) ; For 29+
  (set-face-attribute 'mode-line nil :family "Iosevka Slab" :height 106))
(set-face-attribute 'mode-line-inactive nil :family "Iosevka Slab" :height 106)

;; Bevy Remote Protocol
(use-package! brpel)

;; mullvadel
(use-package! mullvadel)

;; runel
(use-package! runel)

;; wgsl-mode
(use-package! wgsl-mode)

;; ef-themes
(use-package! ef-themes)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
