;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
	     (gnu packages)
	     (gnu services)
	     (gnu home services)
	     (guix gexp)
	     (gnu home services shells))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
 (packages (specifications->packages (list
				      ;; Guix Requirements (Foreign Distro)
				      "glibc-locales"
				      "nss-certs"

				      ;; Custom Fonts
				      "fontconfig"
				      "font-iosevka-term-slab"

				      ;; Git
				      "git"

				      ;; Tree-sitter and grammars
				      "tree-sitter"
				      "tree-sitter-elisp"
				      "tree-sitter-c"
				      "tree-sitter-cpp"
				      "tree-sitter-rust"
				      "tree-sitter-python"
				      "tree-sitter-json"
				      "tree-sitter-yaml"
				      "tree-sitter-toml"

				      ;; C
				      "gcc-toolchain"
				      "clang-toolchain"

				      ;; Rust
				      "rust"
				      "rust-analyzer"

				      ;; Emacs
				      "emacs-pgtk"
				      "emacs-magit"
				      "emacs-vertico"
				      "emacs-corfu"
				      "emacs-cape"
				      "emacs-orderless"
				      "emacs-consult"
				      "emacs-embark"
				      "emacs-eglot"
				      "emacs-paredit"
				      "emacs-rustic"
				      "emacs-yasnippet"
				      "emacs-hl-todo"
				      "emacs-mood-line"
				      "emacs-ultra-scroll"
				      "emacs-ef-themes"
				      "emacs-guix")))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
   (append (list (service home-bash-service-type
			  (home-bash-configuration
			   (aliases '(("egrep" . "grep -E --color=auto")
				      ("fgrep" . "grep -F --color=auto")
				      ("grep" . "grep --color=auto")
				      ("l." . "ls -d .* --color=auto")
				      ("ll" . "ls -l --color=auto")
				      ("ls" . "ls --color=auto")
				      ("which" . "(alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot")
				      ("xzegrep" . "xzegrep --color=auto")
				      ("xzfgrep" . "xzfgrep --color=auto")
				      ("xzgrep" . "xzgrep --color=auto")
				      ("zegrep" . "zegrep --color=auto")
				      ("zfgrep" . "zfgrep --color=auto")
				      ("zgrep" . "zgrep --color=auto")))
			   (bashrc (list (local-file
					  (string-append (getenv "HOME") "/dotfiles/config/home//.bashrc")
					  "bashrc")))
			   (bash-profile (list (local-file
						(string-append (getenv "HOME") "/dotfiles/config/home//.bash_profile")
						"bash_profile")))
			   (bash-logout (list (local-file
					       (string-append (getenv "HOME") "/dotfiles/config/home//.bash_logout")
					       "bash_logout")))))
		 (service
		  home-files-service-type
		  `((".emacs.d/init.el"
		     ,(local-file (string-append (getenv "HOME") "/dotfiles/config/emacs/init.el")))
		    (".config/niri/config.kdl"
		     ,(local-file (string-append (getenv "HOME") "/dotfiles/config/niri/config.kdl")))
		    (".config/fuzzel"
		     ,(local-file (string-append (getenv "HOME") "/dotfiles/config/fuzzel") #:recursive? #t)))))
	   %base-home-services)))
