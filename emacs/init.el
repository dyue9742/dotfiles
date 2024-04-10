(setq frame-resize-pixelwise t)
(set-frame-position nil 0 0)
(set-frame-size nil (display-pixel-width) (display-pixel-height) t)

(set-face-attribute 'default nil :family "Hack Nerd Font")
(set-face-attribute 'default nil :height 200)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(column-number-mode t)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(electric-pair-mode +1)

(global-hl-line-mode t)

(global-auto-revert-mode t)

(global-set-key (kbd "C-+") #'text-scale-increase)

(global-set-key (kbd "C--") #'text-scale-decrease)

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))
(global-set-key [(meta shift up)] 'move-line-up)

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))
(global-set-key [(meta shift down)] 'move-line-down)

(add-hook 'text-mode-hook #'untabify)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq-default tab-width 4
	      fill-column 80
	      create-lockfiles nil
	      indent-tabs-mode nil
	      make-backup-files nil)


(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(use-package helm
  :ensure t
  :config
  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "C-x C-f") #'helm-find-files)
  (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
  (helm-mode 1))

(use-package magit
  :ensure t
  :init (global-set-key (kbd "C-x g") 'magit-status))

(use-package company
  :ensure t
  :init (add-hook 'after-init-hook 'global-company-mode))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package yasnippet
  :ensure t
  :init (yas-global-mode 1))

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :commands lsp)
(use-package lsp-ui
  :ensure t)

(use-package tree-sitter)
(use-package tree-sitter-langs)
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(use-package timu-rouge-theme
  :ensure t
  :config (load-theme 'timu-rouge t))

(use-package multiple-cursors
  :config
  (setq mc/always-run-for-all t)
  :bind
  ;; Use multiple cursor bindings only when a region is active
  (:map region-bindings-mode-map
        ("C->" . mc/mark-next-like-this)
        ("C-<" . mc/mark-previous-like-this)
        ("C-c a" . mc/mark-all-like-this)
        ("C-c h" . mc-hide-unmatched-lines-mode)
        ("C-c l" . mc/edit-lines)))

(use-package which-key)
(which-key-mode)
(which-key-setup-side-window-bottom)

(use-package rainbow-delimiters
  :ensure t)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(yasnippet flycheck company magit which-key web-mode typescript-mode tree-sitter-langs timu-rouge-theme rust-mode rainbow-delimiters multiple-cursors lua-mode lsp-mode js3-mode indent-guide haskell-mode go-mode elixir-mode cmake-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
