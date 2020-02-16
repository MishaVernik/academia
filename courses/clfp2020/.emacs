;;;;----------------------------------------------------------------------------
;;;; emacs init file
;;;;----------------------------------------------------------------------------

(defvar bootstrap-version)

(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;;-----------------------------------------------------------------------------
;;; initialize general settings
;;;-----------------------------------------------------------------------------
(tool-bar-mode -1)                    ; no toolbar
(menu-bar-mode -1)                    ; no menu
(scroll-bar-mode -1)                  ; no scrollbar
(setq inhibit-splash-screen t)        ; no splash screen
(global-display-line-numbers-mode 1)  ; line numbering
(column-number-mode 1)                ; column numbers

;; frame settings
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; font settings
(setq-default indent-tabs-mode nil)

;; dynamic abbreviation
(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
(define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

;; autoindentation
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-<tab>") 'other-frame)

;; enable disabled by default command
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
;;;-----------------------------------------------------------------------------


;;;-----------------------------------------------------------------------------
;;; init packages
;;;-----------------------------------------------------------------------------
(straight-use-package 'use-package)

(use-package kaolin-themes
  :straight t
  :config
  (load-theme 'kaolin-mono-dark t))

(use-package ido
  :straight t
  :config
  (ido-mode t)
  (setq ido-default-buffer-method 'selected-window))

(use-package paredit
  :straight t
  :init
  (autoload 'enable-paredit-mode "paredit")
  :hook
  ((lisp-mode . enable-paredit-mode)
   (emacs-lisp-mode . enable-paredit-mode)
   (eval-expression-minibuffer-setup . enable-paredit-mode)
   (ielm-mode . enable-paredit-mode)
   (lisp-interaction-mode . enable-paredit-mode)
   (scheme-mode . enable-paredit-mode)
   (clojure-mode . enable-paredit-mode)))

(use-package lisp-mode
  :mode "\\.cl\\'"
  :config (setq inferior-lisp-program "sbcl"))

(use-package slime
  :straight t
  :hook (lisp-mode-hook . slime-setup)
  :bind (:map
         slime-mode-map
         ("C-c h" . 'hyperspec-lookup)
         :map
         slime-repl-mode-map
         ("C-c h" . 'hyperspec-lookup))
  :config
  (setq browse-url-browser-function 'eww-browse-url)
  (setq slime-description-autofocus t)
  (setq
   slime-lisp-implementations
   `((sbcl  ("sbcl"))
     (clisp ("clisp"))))
  (slime-setup '(slime-fancy)))
;;;-----------------------------------------------------------------------------


(provide 'init)
