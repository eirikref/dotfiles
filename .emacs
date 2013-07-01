;;
;; Personal information
;;
(setq user-full-name    "Eirik Refsdal")
(setq user-mail-address "eirikref@gmail.com")



;;
;; Set environment
;;
;; (defvar eirikref-site-lisp-dir (expand-file-name "elisp" eirikref-home-dir))
;; (setq load-path (cons eirikref-site-lisp-dir load-path))
(add-to-list 'load-path "~/.elisp")
(defvar user-temporary-file-directory "/tmp/.eirikref-saves")


;;
;; General configuration
;;
(setq
    inhibit-startup-message t
    scroll-step 1
    scroll-margin 5)
(fset 'yes-or-no-p 'y-or-n-p)
(blink-cursor-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end]  'end-of-buffer)
(setq-default transient-mark-mode t)
(setq fill-column 78)
(setq c-default-style "gnu")
(column-number-mode t)
(setq-default mouse-yank-at-point t)

(if (fboundp 'global-font-lock-mode)
	(global-font-lock-mode 1)        ; GNU Emacs
  (setq font-lock-auto-fontify t))   ; XEmacs

(require 'blank-mode)

(setq query-replace-highlight t)
(setq search-highlight t)
(setq font-lock-maximum-decoration t)



;;
;; Backup files
;;

;; (setq make-backup-files nil)
;; (setq auto-save-default nil)
;; (setq vc-make-backup-files nil)
;; (setq
;;    backup-by-copying t      ; don't clobber symlinks
;;    backup-directory-alist
;;     '(("." . "/tmp/.eirikref-saves")) ; don't litter my fs tree
;;    delete-old-versions t
;;    kept-new-versions 6
;;    kept-old-versions 2
;;    version-control t)       ; use versioned backups
;; (setq auto-save-file-name-transforms
;;           `((".*" ,temporary-file-directory t)))
(defvar backup-dir (expand-file-name "~/.emacs.d/backup/"))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(setq backup-directory-alist (list (cons ".*" backup-dir)))
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))
(setq make-backup-files nil)
(setq vc-make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)



;;
;; Tabs, spaces and indentation
;;
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq         c-basic-offset 4)



;;
;; Language, encoding and input
;;
(set-language-environment "UTF-8")



;;
;; CSS Mode
;;
(autoload 'css-mode "css-mode" "CSS Mode" t)
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))



;;
;; PHP Mode
;;
(autoload 'php-mode "php-mode" "PHP Mode" t)
(add-to-list 'auto-mode-alist '("\\.\\(php\\|inc\\)\\'" . php-mode))

(defun php-mode-user-hook ()
  (setq tab-width 4
        c-basic-offset 4
        c-hanging-comment-ender-p nil
        indent-tabs-mode
        font-lock-mode t
        (not
         (and (string-match "/\\(PEAR\\|pear\\)/" (buffer-file-name))
              (string-match "\.php$" (buffer-file-name))))))



;;
;; YAML Mode
;;
(autoload 'yaml-mode "yaml-mode" "YAML Mode" t)
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))



;;
;; JSON Mode
;;
(autoload 'json-mode "json-mode" "JSON Mode" t)
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))



;;
;; JavaScript Mode
;;
(autoload 'javascript-mode "javascript-mode" "JavaScript Mode" t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))



;;
;; Smarty Mode
;;
(autoload 'smarty-mode "smarty-mode" "Smarty Mode" t)
(add-to-list 'auto-mode-alist '("\\.\\(tpl\\)\\'" . smarty-mode))



;;
;; Apache Mode
;;
(autoload 'apache-mode "apache-mode" "Apache Mode" t)
   (add-to-list 'auto-mode-alist '("\\.htaccess$"   . apache-mode))
   (add-to-list 'auto-mode-alist '("httpd\\.conf$"  . apache-mode))



;;
;; Keyboard shortcuts
;;
(global-set-key [f12] 'isearch-repeat-forward)
(global-set-key [f5] 'php-mode)
(global-set-key [f6] 'html-mode)
(global-set-key [f7] 'smarty-mode)
(global-set-key [f8] 'javascript-mode)
(global-set-key [f9] 'css-mode)
(global-set-key [f10] 'blank-mode)
(global-set-key [(M g)] 'goto-line)


(defun sacha/increase-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (ceiling (* 1.10
                                  (face-attribute 'default :height)))))
(defun sacha/decrease-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (floor (* 0.9
                                  (face-attribute 'default :height)))))
(global-set-key (kbd "C-+") 'sacha/increase-font-size)
(global-set-key (kbd "C--") 'sacha/decrease-font-size)
