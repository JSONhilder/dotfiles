;;; init.el --- Emacs configuration -*- lexical-binding: t -*-
;; ---------------------------------------
;; UI STUFF
;; ---------------------------------------
;; Performance tweaks for modern machines
(setq gc-cons-threshold 100000000) ; 100 mb
(setq read-process-output-max (* 1024 1024)) ; 1mb

;; Remove extra UI clutter by hiding the scrollbar, menubar, and toolbar.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Set the font. Note: height = px * 100
(set-face-attribute 'default nil :font "Ubuntu Mono" :height 120)
;; Automatically insert closing parens
(electric-pair-mode t)
;; Visualize matching parens
(show-paren-mode 1)
;; Line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
;; Disable Splash screen
(setq inhibit-splash-screen t)
;; Open fullscreen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; ---------------------------------------
;; MISC STUFF
;; ---------------------------------------
;; Add unique buffer names in the minibuffer where there are many
;; identical files. This is super useful if you rely on folders for
;; organization and have lots of files with the same name,
;; e.g. foo/index.ts and bar/index.ts.
(require 'uniquify)

;; Prefer spaces to tabs
(setq-default indent-tabs-mode nil)

;; Automatically save your place in files
(save-place-mode t)

;; Save history in minibuffer to keep recent commands easily accessible
(savehist-mode t)

;; Keep track of open files
(recentf-mode t)

;; Keep files up-to-date when they change outside Emacs
(global-auto-revert-mode t)

;; y/n and not yes/no
(setopt use-short-answers t) 

;; dired must not make so many buffers
(setf dired-kill-when-opening-new-dired-buffer t)

;; Tab settings
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq c-default-style "linux") 
(setq c-basic-offset 4) 
(c-set-offset 'comment-intro 0)

;; Minibuffer size
(setq resize-mini-windows  t)
(setq resize-mini-frames  t)
(setq max-mini-window-height 0.85)

;; The `setq' special form is used for setting variables. Remember
;; that you can look up these variables with "C-h v variable-name".
(setq uniquify-buffer-name-style 'forward
      window-resize-pixelwise t
      frame-resize-pixelwise t
      load-prefer-newer t
      backup-by-copying t
      ;; Backups are placed into your Emacs directory, e.g. ~/.config/emacs/backups
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))
      ;; I'll add an extra note here since user customizations are important.
      ;; Emacs actually offers a UI-based customization menu, "M-x customize".
      ;; You can use this menu to change variable values across Emacs. By default,
      ;; changing a variable will write to your init.el automatically, mixing
      ;; your hand-written Emacs Lisp with automatically-generated Lisp from the
      ;; customize menu. The following setting instead writes customizations to a
      ;; separate file, custom.el, to keep your init.el clean.
      custom-file (expand-file-name "custom.el" user-emacs-directory))

;; ---------------------------------------
;; Packages
;; ---------------------------------------
;; Bring in package utilities so we can install packages from the web.
(require 'package)

;; Add MELPA, an unofficial (but well-curated) package registry to the
;; list of accepted package registries. By default Emacs only uses GNU
;; ELPA and NonGNU ELPA, https://elpa.gnu.org/ and
;; https://elpa.nongnu.org/ respectively.
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Unless we've already fetched (and cached) the package archives,
;; refresh them.
;;(unless package-archive-contents
;;(package-refresh-contents))

;; Add the :vc keyword to use-package, making it easy to install
;; packages directly from git repositories.
(unless (package-installed-p 'vc-use-package)
    (package-vc-install "https://github.com/slotThe/vc-use-package"))
(require 'vc-use-package)

;; A quick primer on the `use-package' function (refer to
;; "C-h f use-package" for the full details).
;;
;; (use-package my-package-name
;;   :ensure t    ; Ensure my-package is installed
;;   :after foo   ; Load my-package after foo is loaded (seldom used)
;;   :init        ; Run this code before my-package is loaded
;;   :bind        ; Bind these keys to these functions
;;   :custom      ; Set these variables
;;   :config      ; Run this code after my-package is loaded

;; A package with a great selection of themes:
;; https://protesilaos.com/emacs/ef-themes
(use-package ef-themes
    :ensure t
    :config
    (ef-themes-select 'ef-autumn))

(use-package exec-path-from-shell
  :ensure t
  :init
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs '("PATH")))

;; Minibuffer completion is essential to your Emacs workflow and
;; Vertico is currently one of the best out there. There's a lot to
;; dive in here so I recommend checking out the documentation for more
;; details: https://elpa.gnu.org/packages/vertico.html. The short and
;; sweet of it is that you search for commands with "M-x do-thing" and
;; the minibuffer will show you a filterable list of matches.
(use-package vertico
    :ensure t
    :custom
    (vertico-cycle t)
    (read-buffer-completion-ignore-case t)
    (read-file-name-completion-ignore-case t)
    (completion-styles '(basic substring partial-completion flex))
    :init
    (vertico-mode))

;; Improve the accessibility of Emacs documentation by placing
;; descriptions directly in your minibuffer. Give it a try:
;; "M-x find-file".
(use-package marginalia
    :after vertico
    :ensure t
    :init
    (marginalia-mode))

;; Adds intellisense-style code completion at point that works great
;; with LSP via Eglot. You'll likely want to configure this one to
;; match your editing preferences, there's no one-size-fits-all
;; solution.
(use-package corfu
    :ensure t
    :init
    (global-corfu-mode)
    :custom
    (corfu-auto t)
    ;; You may want to play with delay/prefix/styles to suit your preferences.
    (corfu-auto-delay 0)
    (corfu-auto-prefix 0)
    (completion-styles '(basic)))

;; Adds vim emulation. Activate `evil-mode' to swap your default Emacs
;; keybindings with the modal editor of great infamy. There's a ton of
;; keybindings that Evil needs to modify, so this configuration also
;; includes `evil-collection' to fill in the gaps.
(use-package evil
    :ensure t
    :init
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
    :config
    (evil-mode 1))

(use-package evil-collection
    :after evil
    :ensure t
    :config
    (evil-collection-init))

;; https://github.com/emacs-evil/evil-surround
(use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode 1))

;; An extremely feature-rich git client. Activate it with "C-c g".
(use-package magit
    :ensure t)

(with-eval-after-load 'magit
    (setq magit-log-section-commit-count 100)
    (setq magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1))

;; ---------------------------------------
;; Programming
;; ---------------------------------------

(setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go" "v0.19.1")
     (gomod "https://github.com/camdencheek/tree-sitter-go-mod")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")))
;;(mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))

(add-to-list 'auto-mode-alist '("\\.c\\'" . c-ts-mode))
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-ts-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

;; Adds LSP support. Note that you must have the respective LSP
;; server installed on your machine to use it with Eglot. e.g.
;; rust-analyzer to use Eglot with `rust-mode'.
(use-package eglot
    :ensure t
    ;; Add your programming modes here to automatically start Eglot,
    ;; assuming you have the respective LSP server installed.
    ;;:hook ((go-mode . eglot-ensure))
    :bind (("s-<mouse-1>" . eglot-find-implementation)
            ("C-c ." . eglot-code-action-quickfix)))

;; In cases where you need to change the language server commands
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(tsx-ts-mode . ("bunx" "--bun" "typescript-language-server" "--stdio"))))

;; Disable ts mode debug logging for performance reason
;; Comment out if needing to debug
;;(defun jsonrpc--log-event (connection message &optional type))

;; ---------------------------------------
;; Functions
;; ---------------------------------------

(defun google-this ()
  "Search LibreWolf using the currently highlighted region in Emacs."
  (interactive)
  (if (use-region-p)
      (let ((query (buffer-substring-no-properties (region-beginning) (region-end))))
        (let ((url (concat "https://www.google.com/search?q=" (url-hexify-string query))))
          (start-process "librewolf" nil "librewolf" url)))
    (message "No region selected.")))

(defun open-emacs-config ()
  "Open the Emacs configuration file."
  (interactive)
  (find-file (expand-file-name "~/.emacs.d/init.el")))

(defun xterm ()
  "Open an XFCE4 terminal in i3 at the current buffer's directory."
  (interactive)
  (let ((current-directory (if (buffer-file-name)
                               (file-name-directory (buffer-file-name))
                             default-directory)))
    (start-process "xfce4-terminal" nil "xfce4-terminal" "--working-directory" current-directory)))

(defun switch-p-buffer ()
    "Switch to the previous buffer."
    (interactive)
    (switch-to-buffer nil))

;; ---------------------------------------
;; Keybinds
;; ---------------------------------------

(defun visual-shift-right ()
    (interactive)
    (evil-shift-right evil-visual-beginning evil-visual-end)
    (evil-normal-state)
    (evil-visual-restore))

(defun visual-shift-left ()
    (interactive)
    (evil-shift-left evil-visual-beginning evil-visual-end)
    (evil-normal-state)
    (evil-visual-restore))

;; MISC BINDS
(with-eval-after-load 'dired
    (evil-define-key 'normal dired-mode-map (kbd "<backspace>") 'dired-up-directory)
    (evil-define-key 'normal dired-mode-map (kbd "f") 'find-file))

;; EVIL BINDS
(with-eval-after-load 'evil
    (evil-set-leader nil (kbd "SPC"))
    (define-key evil-normal-state-map (kbd "<leader>j") 'kill-buffer-and-window)

    (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
    (define-key evil-normal-state-map (kbd "C-c i") 'ibuffer)
    (define-key evil-normal-state-map (kbd "C-c p") 'dired-jump)
    (define-key evil-normal-state-map (kbd "C-c d") 'dired)

    (define-key evil-normal-state-map (kbd "C-c g") 'magit)
    (define-key evil-normal-state-map (kbd "C-c c") 'compile)
    (define-key evil-normal-state-map (kbd "C-c w") 'open-emacs-config)

    (define-key evil-normal-state-map (kbd "C-c f") 'find-file)
    (define-key evil-normal-state-map (kbd "C-c r") 'restart-emacs)
    (define-key evil-normal-state-map (kbd "C-c l") 'switch-p-buffer)

    (define-key evil-normal-state-map (kbd "<tab>") 'evil-shift-right)
    (define-key evil-normal-state-map (kbd "<backtab>") 'evil-shift-left)
    (define-key evil-insert-state-map (kbd "<tab>") 'evil-shift-right)
    (define-key evil-insert-state-map (kbd "<backtab>") 'evil-shift-left)

    (evil-define-key 'visual global-map (kbd "<tab>") 'visual-shift-right)
    (evil-define-key 'visual global-map (kbd "<backtab>") 'visual-shift-left)

    (define-key evil-normal-state-map (kbd "C-j") 'vterm))

;; MAGIT BINGS
(with-eval-after-load 'magit
    (define-key magit-mode-map (kbd "<tab>") 'magit-section-toggle))

;;@TODO move xfce4 theme to dotfiles
