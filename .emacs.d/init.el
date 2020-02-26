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

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
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
(add-to-list 'load-path "~/.emacs.d/custom")
(add-to-list 'custom-theme-load-path "~/.emacs.d/el-get/umberto/.emacs.d")

(defun install-el-get ()
  (eval-url
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"))

(unless (require 'el-get nil t)
  (install-el-get))

;; Load packages using ELPA
;; (package-ensure-installed 'apache-mode)
;; (package-ensure-installed 'applescript-mode)
;; (package-ensure-installed 'coffee-mode)
;; (package-ensure-installed 'dart-mode)
;; (package-ensure-installed 'json-mode)
;; (package-ensure-installed 'jsx-mode)
;; (package-ensure-installed 'markdown-mode)
;; (package-ensure-installed 'rust-mode)
;; (package-ensure-installed 'scss-mode)
;; (package-ensure-installed 'smarty-mode)
;; (package-ensure-installed 'web-mode)
;; (package-ensure-installed 'yaml-mode)
(package-ensure-installed 'css-mode)
(package-ensure-installed 'editorconfig)
(package-ensure-installed 'js2-mode)
(package-ensure-installed 'php-mode)
(package-ensure-installed 'sass-mode)
;; (package-ensure-installed 'slim-mode)
(package-ensure-installed 'twig-mode)
(package-ensure-installed 'auto-complete)
;; (package-ensure-installed 'less-css-mode)
(package-ensure-installed 'vue-mode)

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
;; General settings
;; 

;; Turn off some of the more annoying features appearing after Emacs 21
;; Copied from https://github.com/oyving/dotfiles
(when (>= emacs-major-version 21)
  (setf (default-value 'cursor-in-non-selected-windows) nil)
  (blink-cursor-mode 0)
  (if (featurep 'tooltip)
      (tooltip-mode -1))
  (if window-system
      (tool-bar-mode -1)
    (scroll-bar-mode -1)))

;; Theme, font, colors, and behavior
(load-theme 'umberto t)
(setq inhibit-startup-message t) ;; Skip the start page

;; Keyboard configuration
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end]  'end-of-buffer)
(global-set-key [(C n)] 'isearch-repeat-forward)
(global-set-key [(M g)] 'goto-line)

;; Language, encoding and input
(set-language-environment "UTF-8")

;; Tabs, spaces and indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq         c-basic-offset 4)
(setq         js-indent-level 4)

;; OSX Settings
(setq mac-option-modifier nil
      mac-command-modifier 'meta
      x-select-enable-clipboard t)

;; Preferences for my MacBook
(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(top . 0))
(add-to-list 'default-frame-alist '(height . 70))
(add-to-list 'default-frame-alist '(width . 107))

;; Backup files and stuff
(setq make-backup-files nil)
(setq vc-make-backup-files nil)
(setq auto-save-default nil)

;; Font
(set-frame-font "Hack 14")


;;
;; Mode specific settings
;;

;; https://www.gnu.org/software/emacs/manual/html_node/efaq/Displaying-the-current-line-or-column.html
(setq column-number-mode t)

;; https://github.com/editorconfig/editorconfig-emacs
(editorconfig-mode 1)

;; Show matching pair of parentheses, https://www.emacswiki.org/emacs/ShowParenMode
(show-paren-mode t)

;;
(add-to-list 'auto-mode-alist '("\\.scss.spec\\'" . scss-mode))

;; Tramp
;; (setq tramp-default-method "ssh")
;; (setq tramp-terminal-type "dumb")
;; (setq tramp-debug-buffer t)
;; (setq tramp-verbose 10)
