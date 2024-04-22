;;; package --- Settings
;;; Commentary:
;;; Code:
(set-face-attribute 'default nil :family "Hack Nerd Font")
(set-face-attribute 'default nil :height 234)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(column-number-mode t)

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
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

(setq-default tab-width 4)
(setq-default fill-column 80)
(setq-default create-lockfiles nil)
(setq-default indent-tabs-mode nil)
(setq-default make-backup-files nil)


(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package timu-rouge-theme
  :ensure t
  :config
  (load-theme 'timu-rouge t))

(use-package tree-sitter
             :ensure t)
(use-package tree-sitter-langs
             :ensure t)
(global-tree-sitter-mode)

(use-package helm
             :ensure t)

(use-package lsp-mode
             :ensure t
             :init
             (setq lsp-keymap-prefix "C-c l"))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(timu-rouge-theme flycheck helm tree-sitter-langs tree-sitter)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
