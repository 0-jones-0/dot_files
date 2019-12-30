
;;;; Manual settings
;;smooth scrolling
(setq scroll-step            1
      scroll-conservatively  10000)
;; (setq auto-window-vscroll nil)

;;column numbers
(column-number-mode 1)

;;tab modification
(setq-default indent-tabs-mode nil)
(setq c-basic-offset 4)

;;case statement indent modification
(add-hook 'c-mode-common-hook
          (lambda ()
            (c-set-offset 'case-label '+)))

;;disable splash screen
(setq inhibit-splash-screen t)

;;backup directory management
(setq
   backup-by-copying t            ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.backups/emacs")) ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)             ; use versioned backups

;--------------------------------------------------------------------------------
;; Melpa
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;--------------------------------------------------------------------------------

(add-hook 'after-init-hook
          (lambda ()
            (global-set-key (kbd "C-c <left>")  'windmove-left)
            (global-set-key (kbd "C-c <right>") 'windmove-right)
            (global-set-key (kbd "C-c <up>")    'windmove-up)
            (global-set-key (kbd "C-c <down>")  'windmove-down)

            ;; UI mods
            (global-linum-mode)
            ;;(set-face-attribute 'linum nil :foreground "#A73904") ;; for use with soothe-theme
            (global-hl-line-mode)

            ;; osx home/end key fix
            ;; (global-set-key [home] 'move-beginning-of-line)
            ;; (global-set-key [end] 'move-end-of-line)
            ))


;; ------------------------------
;; general
;; TODO: consider sublimity

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package yasnippet
  :ensure t
  :config (yas-global-mode 1))

(setq tramp-default-method "ssh")

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package anzu
  :ensure t
  :config (global-anzu-mode))

(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

(use-package company
  :ensure t
  :config (global-company-mode))

(use-package neotree
  :ensure t
  :config
  (setq neo-theme 'arrow) ;; icons for osx graphic
  (global-set-key [f8] 'neotree-toggle)
  (setq neo-window-fixed-size nil)
  (setq neo-window-width 35)
  (add-hook 'neotree-mode-hook
            (lambda () (with-current-buffer " *NeoTree*"
                         (setq-local linum-mode nil)))))

(use-package eyebrowse
  :ensure t
  :config
  (setq eyebrowse-mode-line-separator " "
        eyebrowse-new-workspace t)
  (eyebrowse-mode t))

;; Web mode additional setup
;(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
;(add-hook 'web-mode-hook
;          (lambda()
;            (auto-complete-mode t)))


;; ------------------------------
;; lisp editing

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))

(use-package paredit
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook 'paredit-mode))

(use-package clojure-mode
  :ensure t
  :config
  (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'clojure-mode-hook 'paredit-mode)
  (add-hook 'clojure-mode-hook (lambda ()
                                 (setq truncate-lines t))))

(use-package cider
  :ensure t
  :config
  (add-hook 'clojure-mode-hook 'cider-mode)
  (add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'cider-repl-mode-hook 'paredit-mode)
  (add-hook 'cider-repl-mode-hook (lambda ()
                                    (setq truncate-lines t))))

(use-package ielm
  :config
  (add-hook 'ielm-mode-hook #'rainbow-delimiters-mode))


;; ------------------------------
;; fuzzy matching

(use-package counsel
  :ensure t)

(use-package ivy
  :ensure t
  :bind (("\C-s" . swiper)
         ;; ("C-c C-r" . ivy-resume)
         ;; ("<f6>" . ivy-resume)
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ;; ("<f1> f" . counsel-describe-function)
         ;; ("<f1> v" . counsel-describe-variable)
         ;; ("<f1> l" . counsel-find-library)
         ;; ("<f2> i" . counsel-info-lookup-symbol)
         ;; ("<f2> u" . counsel-unicode-char)
         ;; ("C-c g" . counsel-git)
         ;; ("C-c j" . counsel-git-grep)
         ;; ("C-c k" . counsel-ag)
         ;; ("C-x l" . counsel-locate)
         ;; ("C-S-o" . counsel-rhythmbox)
         ;; :map minibuffer-local-map
         ;; ("C-r" . counsel-minibuffer-history)
         )
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))


;; ------------------------------
;; icon modifications

(use-package all-the-icons
  :ensure t)

;; (use-package all-the-icons-ivy
;;   :ensure t
;;   :config
;;   (if (display-graphic-p)
;;       (all-the-icons-ivy-setup)))


;; ------------------------------
;; theme and mode line setup

(use-package doom-themes
  :ensure t
  :init (load-theme 'doom-one t)
  :config
  (doom-themes-neotree-config)
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (doom-themes-visual-bell-config))

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

;; ------------------------------
;; news reader

(use-package elfeed
  :ensure t
  :bind ("C-x w" . elfeed)
  :config
  (setq elfeed-feeds
        '()))

;; (use-package elfeed-org
;;   :ensure t
;;   :init
;;   (setq rmh-elfeed-org-files (list "~/.emacs.d/elfeed.org")))


;; ------------------------------
;; org mode

(use-package org
  :config
  (setq org-src-fontify-natively t)
  (setq org-todo-keywords '((sequence "TODO(t)" "|" "DONE(d)")
                            (sequence "WAITING(w)" "|")
                            (sequence "PENDING(p)" "|")
                            (sequence "|" "CANCELED(c)"))))

(use-package org-bullets
  :ensure t
  :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; active Babel languages
;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((shell . t)
;;    (python . t)
;;    (emacs-lisp . t)))
