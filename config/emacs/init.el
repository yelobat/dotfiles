;;; -*- lexical-binding: t -*-

;; My Emacs Configuration.

;; Identification
(setq user-full-name "Luke Holland"
      user-mail-address "lukeanthonyholland@gmail.com")

;; Menubar, Scrollbar and Toolbar gone
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Remove top frame bar
(add-to-list 'default-frame-alist '(undecorated . t))

;; Line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; Blink cursor
(blink-cursor-mode 1)

;; Current line highlighting
(global-hl-line-mode)

;; Save automatically
(setq auto-save-default t)

;; Performance optimization
(setq gc-cons-threshold (* 256 1024 1024))
(setq read-process-output-max (* 4 1024 1024))
(setq native-comp-async-jobs-number 8)

;; Bell sound
(setq visible-bell t)

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
  :custom
  (setq vertico-count 10
	vertico-cycle t
	vertico-sort-function #'vertico-sort-history-alpha)
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
	completion-category-defaults nil
	completion-category-overrides '((file (styles basic partial-completion orderless)))
	orderless-component-separator #'orderless-escapable-split-on-space
	orderless-matching-styles '(orderless-literal
				    orderless-prefixes
				    orderless-initialism
				    orderless-regexp)))

;; Corfu
(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t))

(use-package corfu-popupinfo
  :after corfu
  :config
  (corfu-popupinfo-mode 1))

;; ElDoc
(setq eldoc-idle-delay 0.2)
(setq eldoc-echo-area-use-multiline-p t)

;; Cape
(use-package cape
  :init
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-dabbrev))

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

;; Org Agenda
(use-package org)
(setq org-directory "~/dotfiles/org")

;;;; Org Agenda Keymap bindings
(keymap-global-set "C-c n a" #'org-agenda)
(keymap-global-set "C-c n c" #'org-capture)
