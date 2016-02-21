;;
;; Emacs configuration
;;

;;
;; Personal information
;;
(setq user-full-name    "Eirik Refsdal")
(setq user-mail-address "eirik@gmail.com")

;;
;; Basic bootstrapping
;; Parts copied from https://github.com/oyving/dotfiles
;;
(require 'cl)
(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(defun package-ensure-installed (package)
  (unless (package-installed-p package)
    (package-refresh-contents)
    (package-install package)))

;; http://bytes.inso.cc/2011/08/13/auto-installing-packages-in-emacs-with-elpa-and-el-get/
;; derived from ELPA installation
;; http://tromey.com/elpa/install.html
(defun eval-url (url)
  (let ((buffer (url-retrieve-synchronously url)))
    (save-excursion
      (set-buffer buffer)
      (goto-char (point-min))
      (re-search-forward "^$" nil 'move)
      (eval-region (point) (point-max))
      (kill-buffer (current-buffer)))))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'custom-theme-load-path "~/.emacs.d/el-get/umberto/.emacs.d")

(defun install-el-get ()
  (eval-url
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"))

(unless (require 'el-get nil t)
  (install-el-get))

;; Load packages using ELPA
;; (package-ensure-installed 'apache-mode)
;; (package-ensure-installed 'applescript-mode)
(package-ensure-installed 'coffee-mode)
(package-ensure-installed 'css-mode)
;; (package-ensure-installed 'dart-mode)
(package-ensure-installed 'js2-mode)
;; (package-ensure-installed 'json-mode)
;; (package-ensure-installed 'jsx-mode)
;; (package-ensure-installed 'markdown-mode)
(package-ensure-installed 'php-mode)
;; (package-ensure-installed 'scss-mode)
;; (package-ensure-installed 'sass-mode)
;; (package-ensure-installed 'smarty-mode)
(package-ensure-installed 'yaml-mode)
;; (package-ensure-installed 'rust-mode)
;; (package-ensure-installed 'web-mode)

;; Load specific packages from github using el-get
;; extra recipes for packages unknown to el-get (yet)
(setq el-get-sources
      '((:name umberto
               :type git
               :url "git://github.com/eirikref/dotfiles.git"
               :load ".emacs.d/umberto-theme.el"
               )
      ))


;; list all packages you want installed
(setq my-el-get-packages
      (append
       '(umberto)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-el-get-packages)



;;
;; Turn off some of the more annoying features appearing after Emacs 21
;; Copied from https://github.com/oyving/dotfiles
;;
(when (>= emacs-major-version 21)
  (setf (default-value 'cursor-in-non-selected-windows) nil)
  (blink-cursor-mode 0)
  (if (featurep 'tooltip)
      (tooltip-mode -1))
  (if window-system
      (tool-bar-mode -1)
    (scroll-bar-mode -1)))
;;
;; Theme, font, colors, and behavior
;;
(load-theme 'umberto t)
(setq inhibit-startup-message t) ;; Skip the start page

;;
;; Keyboard configuration
;;
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end]  'end-of-buffer)
(global-set-key [(C n)] 'isearch-repeat-forward)
(global-set-key [(M g)] 'goto-line)

;;
;; Language, encoding and input
;;
(set-language-environment "UTF-8")

;;
;; Tabs, spaces and indentation
;;
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq         c-basic-offset 4)

;;
;; OSX Settings
;;
(setq mac-option-modifier nil
      mac-command-modifier 'meta
      x-select-enable-clipboard t)

;;
;; Preferences for my MacBook Air 13"
;;
(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(top . 0))
(add-to-list 'default-frame-alist '(height . 56))
(add-to-list 'default-frame-alist '(width . 98))

;;
;; Backup files and stuff
;;
(setq make-backup-files nil)
(setq vc-make-backup-files nil)
(setq auto-save-default nil)

;;
;; Tramp
;;
(setq tramp-default-method "ssh")
(setq tramp-terminal-type "dumb")
(setq tramp-debug-buffer t)
(setq tramp-verbose 10)


;;
;; Everything below this mark is just old stuff I have not yet looked
;; through
;;

;;
;; General configuration
;;
;; (setq
;;    backup-by-copying t      ; don't clobber symlinks
;;    backup-directory-alist
;;     '(("." . "/tmp/.eirikref-saves"))    ; don't litter my fs tree
;;    delete-old-versions t
;;    kept-new-versions 6
;;    kept-old-versions 2
;;    scroll-step 1
;;    scroll-margin 5
;;    version-control t)       ; use versioned backups
;; (fset 'yes-or-no-p 'y-or-n-p)
;; (blink-cursor-mode -1)
;; (global-set-key [home] 'beginning-of-buffer)
;; (global-set-key [end]  'end-of-buffer)
;; (setq-default transient-mark-mode t)
;; (setq fill-column 78)
;; (setq c-default-style "gnu")
;; (column-number-mode t)
;; (setq-default mouse-yank-at-point t)

;; (if (fboundp 'global-font-lock-mode)
;; 	(global-font-lock-mode 1)        ; GNU Emacs
;;   (setq font-lock-auto-fontify t))   ; XEmacs

;; (setq require-final-newline nil)
;; (setq inhibit-default-init t)

;; (setq query-replace-highlight t)
;; (setq search-highlight t)
;; (setq font-lock-maximum-decoration t)

;; ;; (autoload 'php-mode "php-mode" "PHP Mode" t)
;; (add-to-list 'auto-mode-alist '("\\.\\(php\\|inc\\)\\'" . php-mode))

;; (defun php-mode-user-hook ()
;;   (setq tab-width 4
;;         c-basic-offset 4
;;         c-hanging-comment-ender-p nil
;;         indent-tabs-mode
;;         font-lock-mode t
;;         (not
;;          (and (string-match "/\\(PEAR\\|pear\\)/" (buffer-file-name))
;;               (string-match "\.php$" (buffer-file-name))))))


;; (defun sacha/increase-font-size ()
;;   (interactive)
;;   (set-face-attribute 'default
;;                       nil
;;                       :height
;;                       (ceiling (* 1.10
;;                                   (face-attribute 'default :height)))))
;; (defun sacha/decrease-font-size ()
;;   (interactive)
;;   (set-face-attribute 'default
;;                       nil
;;                       :height
;;                       (floor (* 0.9
;;                                   (face-attribute 'default :height)))))
;; (global-set-key (kbd "C-+") 'sacha/increase-font-size)
;; (global-set-key (kbd "C--") 'sacha/decrease-font-size)


;; Copied from Oyvind:

;; ;; we want marking of parens
;; ;; (show-paren-mode t)

;; ;; colorize in editing modes
;; ;; (global-font-lock-mode t)

;; ;; remove irritating UI elements
;; ;; (menu-bar-mode -1)

;; ;; show columns as well as lines
;; ;; (column-number-mode t)

;; ;; lazy typist, y or n instead of yes or no
;; ;; (defalias 'yes-or-no-p 'y-or-n-p)

;; ;; we want ido-mode for finding files
;; ;; (ido-mode t)
;; ;; (setq ido-enable-flex-matching t)

;; ;; we do not want "magic" handling of tabs
;; (setf indent-tabs-mode nil)

;; ;; ensure UTF-8
;; (set-language-environment "UTF-8")

;; ;; get custom configuration into a different file
;; ;; (setq custom-file (expand-file-name "~/.emacs.d/custom.el"))

;; ;; keep backup files from littering the file system
;; ;; (setf backup-directory-alist '(("." . "~/.emacs.d/backup")))

;; ;; use org-mode for .org files
;; ;; (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; ;; start the emacs server
;; ;; (server-start)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(package-selected-packages (quote (scss-mode yaml-mode php-mode js2-mode coffee-mode)))
 '(tool-bar-mode nil))

(set-frame-font "Hack 14")
