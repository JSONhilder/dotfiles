;;Performance tweaks for modern machines
(setq gc-cons-threshold 100000000) ; 100 mb
(setq read-process-output-max (* 1024 1024)) ; 1mb

;;Remove extra UI clutter by hiding the scrollbar, menubar, and toolbar.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;Set the font. Note: height = px * 100
(set-face-attribute 'default nil :font "Ubuntu Mono" :height 120)

;;Automatically insert closing parens
(electric-pair-mode t)

;;Visualize matching parens
(show-paren-mode 1)

;;Line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;;Disable Splash screen
(setq inhibit-splash-screen t)

;;Open fullscreen
(add-to-list 'default-frame-alist '(fullscreen . maximized))
