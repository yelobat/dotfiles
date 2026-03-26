;; My Emacs Configuration.

;; Menubar, Scrollbar and Toolbar gone.
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Set Iosevka Font
(set-frame-font "Iosevka Term Slab 14" t)

;; use-package
(require 'use-package)

;; Guix
(use-package guix-emacs)

;; Magit
(use-package magit)

;; Vertico
(use-package vertico
  :init
  (vertico-mode)
  :bind (:map vertico-map
	      ("TAB" . minibuffer-complete)
	      ("M-g M-c" . switch-to-completions)
	      ("M-TAB" . vertico-insert)))

;; Eglot
(use-package eglot
  :hook ((c-ts-mode . eglot-ensure)
	 (c++-ts-mode . eglot-ensure)
	 (rust-ts-mode . eglot-ensure)
	 (emacs-lisp-mode . eglot-ensure))
  :bind (:map eglot-mode-map
	      ("C-c c a" . eglot-code-actions)
	      ("C-c c d" . eglot-find-declaration)
	      ("C-c c f" . eglot-format-buffer)))

;; Orderless
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
	completion-category-defaults nil))

;; Corfu
(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  )

;; Cape
(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

;; Yasnippet
(use-package yasnippet
  :init
  (yas-global-mode 1))

;; Whitespace
(use-package whitespace
  :hook (prog-mode . whitespace-mode)
  :custom
  (whitespace-style '(face trailing tabs)))

(add-hook 'before-save-hook #'delete-trailing-whitespace)

;; Ultra Scroll
(use-package ultra-scroll)

;; Hl-todo
(use-package hl-todo
  :init
  (global-hl-todo-mode))

;; Mood-line
(use-package mood-line
  :config
  (mood-line-mode))

;; Tree sitter
(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
(add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
(add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode))

;; ef-themes
(use-package ef-themes
  :init
  (load-theme 'ef-tritanopia-dark t))
