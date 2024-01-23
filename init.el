(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))
;; ----------------------------------------------------------------------
;;

(set-face-attribute 'default nil :family "AnonymicePro Nerd Font")
(set-face-attribute 'default nil :height 300)

(tool-bar-mode -1)
(scroll-bar-mode -1)

(column-number-mode t)

(global-hl-line-mode t)

(global-auto-revert-mode t)

(display-line-numbers-mode t)

;;
;;


(require 'typescript-mode)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))


(require 'lua-mode)


(require 'js3-mode)


(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-markup-indent-offset 2)

(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-css-colorization t)
(setq web-mode-enable-current-element-highlight t)


(require 'go-mode)
(add-hook 'go-mode-hook 'lsp-deferred)


(require 'rust-mode)
(setq rust-format-on-save t)
(add-hook 'rust-mode-hook #'lsp)
(add-hook 'rust-mode-hook
          (lambda () (prettify-symbols-mode)))
(add-hook 'rust-mode-hook
          (lambda () (setq indent-tabs-mode nil)))


(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))


(use-package elixir-mode
  :ensure t)
(add-hook 'elixir-mode-hook
          (lambda () (add-hook 'before-save-hook 'elixir-format nil t)))


(require 'haskell-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)
(add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
(add-hook 'haskell-mode-hook 'turn-on-haskell-unicode-input-method)
(add-hook 'haskell-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends)
                 (append '((company-capf company-dabbrev-code))
                         company-backends))))
(setq haskell-compile-cabal-build-command "stack build")


(setq-default
  fill-column 100
  load-prefer-newer t
  create-lockfiles nil
  indent-tabs-mode nil
  auto-save-default nil
  inhibit-startup-message t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)


(use-package tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))


(use-package timu-rouge-theme
    :ensure t
    :config
    (load-theme 'timu-rouge t))

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(use-package which-key
  :config
  (which-key-mode))

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

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
