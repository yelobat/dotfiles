;;; -*- lexical-binding: t -*-

;; My Emacs Configuration.

;; Identification
(setq user-full-name "Luke Holland"
      user-mail-address "lukeanthonyholland@gmail.com")

;; Straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq package-enable-at-startup nil)

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
(set-frame-font "Iosevka Term Slab 14" nil t)

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
  (corfu-popupinfo-mode 1)
  :custom
  (corfu-popupinfo-delay '(0.1 . 0.05)))

;; ElDoc
(setq eldoc-idle-delay 0.2)
(setq eldoc-echo-area-use-multiline-p t)

;; Cape
(use-package cape
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

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

;; Syncthing
(use-package syncthing)

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

;; Electric pair mode
(electric-pair-mode)

;; Delete selection mode
(delete-selection-mode)

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
(setq org-directory (expand-file-name "~/dotfiles/org"))
(setq org-agenda-files (list org-directory))

(setq org-agenda-remove-tags t)
(setq org-agenda-block-separator 32)
(setq org-agenda-custom-commands
      '(("d" "Dashboard"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "\n HIGHEST PRIORITY")
                 (org-agenda-prefix-format "   %i %?-2 t%s")))
          (agenda ""
                  ((org-agenda-start-day "+0d")
                   (org-agenda-span 1)
                   (org-agenda-time)
                   (org-agenda-remove-tags t)
                   (org-agenda-todo-keyword-format "")
                   (org-agenda-scheduled-leaders '("" ""))
                   (org-agenda-current-time-string "ᐊ┈┈┈┈┈┈┈┈┈ NOW")
                   (org-agenda-overriding-header "\n TODAY'S SCHEDULE")
                   (org-agenda-prefix-format "   %i %?-2 t%s")))
          (tags-todo  "-STYLE=\"habit\""
                      ((org-agenda-overriding-header "\n ALL TODO")
                       (org-agenda-sorting-strategy '(priority-down))
                       (org-agenda-remove-tags t)
                       (org-agenda-prefix-format "   %i %?-2 t%s")))))))

;; Remove scheduled tag
(setq org-agenda-scheduled-leaders '("" ""))

;; Remove holidays from agenda
(setq org-agenda-include-diary nil)

;; Capture templates
(setq org-capture-templates
      '(("t" "Todo" entry
 	 (file+headline "~/dotfiles/org/inbox.org" "Inbox")
 	 "* TODO %^{Task}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")
 	("w" "Work" entry
 	 (file+headline "~/dotfiles/org/work.org" "Work")
 	 "* %^{Work}\n%^{SCHEDULED}T\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")
	("r" "rent" entry
 	 (file+headline "~/dotfiles/org/finance.org" "Rent")
 	 "* Rent Due: %^{Rent Due}\n%^{SCHEDULED}T\n:PROPERTIES:\n:END:\n%?")
	("s" "spending" entry
 	 (file+headline "~/dotfiles/org/finance.org" "Spending")
 	 "* Spent: £%^{Spent}\n:DATE: %U\n:PROPERTIES:\n:END:\n%?")))

;;;; Org Agenda Keymap bindings
(keymap-global-set "C-c n a" #'org-agenda)
(keymap-global-set "C-c n c" #'org-capture)
