(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(TeX-DVI-via-PDFTeX nil)
 '(TeX-PDF-mode nil)
 '(TeX-show-compilation t)
 '(buffer-encoding (quote utf-8))
 '(debug-on-error t)
 '(htmlize-view-print-visible t t)
 '(ispell-program-name "aspell")
 '(javascript-shell-command "jsdb");;Javascript Shell from jsdb.org
 '(javascript-shell-command-args (quote ("eval")))
 '(menu-bar-mode nil)
 '(nxhtml-default-encoding (quote utf-8))
 '(nxhtml-load t);;Autoloading NXHTML Mode with css-js-php support
 '(nxhtml-skip-welcome t)
 '(nxml-slash-auto-complete-flag t)
 '(pr-gs-command "c:\\gs\\gs8.56\\bin\\gswin32c.exe")
 '(pr-gv-command "C:\\Program Files\\Ghostgum\\gsview\\gsview32.exe")
 '(prefer-coding-system (quote utf-8))
 '(recentf-mode t)
 '(scroll-bar-mode nil)
 '(selection-coding-system (quote utf-8-dos))
 '(show-paren-mode t)
 '(speedbar-show-unknown-files t);;All file can view inside speedbar
 '(tidy-shell-command "c:/WINDOWS/tidy.exe");; For html tidy
 '(tool-bar-mode nil)
 '(transient-mark-mode t)
 '(tumme-cmd-create-temp-image-program "c:/ImageMagick/convert.exe");;Picture vieving emacs inside (Emacs w32 Mode Addition
 '(tumme-cmd-create-thumbnail-program "c:/ImageMagick/convert.exe")
 '(tumme-cmd-rotate-thumbnail-program "c:/ImageMagick/mogrify.exe")
 '(unibyte-display-via-language-environment t)
 '(unify-8859-on-decoding-mode t)
 '(utf-8-compose-scripts t)
 '(utf-fragment-on-decoding t)
 '(w32-print-menu-show-print nil)
 '(w32-print-menu-show-ps-print nil)
 '(w32shell-cygwin-bin "C:\\cygwin\\bin") ;;Emacs W32 Cygwin Shell Support
 '(w32shell-msys-bin "C:\\msys\\1.0\\bin");;Emacs W32 MSYS Shell Support
 '(w32shell-shell (quote cmd));;Emacs W32 Shell support
 '(w3m-command "C:\\cygwin\\bin\\w3m.exe");;Emacs W32 W3M Support
 '(w3m-use-tab t))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(set-default-font "-outline-Bitstream Vera Sans Mono-normal-r-normal-normal-13-97-96-96-c-*-utf-8")

(require 'color-theme)

;; Extra Color Themes from org mode author

(load "color-theme-cl-frame.el")
(load "color-theme-rlx.el")
(load "color-theme-colorful-obsolescence")

;(color-theme-charcoal-black)
;(color-theme-rlx)
;(color-theme-cl-frame)
(color-theme-colorful-obsolescence)
;(color-theme-blippblopp)
;(color-theme-charcoal-black)
;(color-theme-infodoc)
;(color-theme-jb-simple)
;(color-theme-digital-ofs1)
;(color-theme-goldenrod)
;(color-theme-comidia)

(setq query-replace-highlight t)
(setq search-highlight t)
(setq font-lock-maximum-decoration t)


;; My Global Key shorcuts

(global-set-key [f5]   'smarty-mode)
(global-set-key [(C f5)]   'surround-region-with-tag)

(global-set-key [f6]   'php-mode)
(global-set-key [(M f6)]   'list-colors-display)
(global-set-key [(shift f6)]   'tinypair-mode)
(global-set-key [(C f6)] 'cua-mode)


(global-set-key [f7]           'fold-dwim-toggle)
(global-set-key [(shift f7)]   'fold-dwim-show-all)
(global-set-key [(C f7)] 'fold-dwim-hide-all)
(global-set-key [(M f7)] 'setnu-mode)

(global-set-key [(shift f8)] 'color-theme-colorful-obsolescence)
(global-set-key [(C f8)]   'color-theme-rlx)
(global-set-key [(M f8)]   'color-theme-cl-frame)

(global-set-key [f9] 'nxhtml-mode)
(global-set-key [(shift f9)]   'html-mode)
(global-set-key [(C f9)] 'comment-region)
(global-set-key [(M f9)] 'uncomment-region)

(global-set-key [(f11)] 'pabbrev-mode)
(global-set-key [(shift f11)]   'hs-minor-mode)
(global-set-key [(C f11)]   'imenu-add-menubar-index)
(global-set-key [(M f11)] 'javascript-shell)

(global-set-key [(shift f12)] 'php-browse-manual)
(global-set-key [(M f12)] 'php-search-documentation)
(global-set-key [(f12)] 'php-check-syntax)
(global-set-key [(C f12)] 'speedbar)


;; Hexcolour Mode, showing colors inside css mode

(require 'palette);; This is palette.el

(autoload 'hexcolour-mode "hexcolour" nil t nil)
 (defvar hexcolour-keywords
   '(("#[abcdef[:digit:]]\\{6\\}"
      (0 (put-text-property (match-beginning 0)
                         (match-end 0)
                         'face (list :background
                                  (match-string-no-properties 0)))))))

 (defun hexcolour-add-to-font-lock ()
   (font-lock-add-keywords nil hexcolour-keywords))


(add-hook 'css-mode-hook 'hexcolour-add-to-font-lock)
(add-hook 'css-mode-hook 'imenu-add-menubar-index)


;;rnc mode - nxml dosyalarini duzenleme icin

(autoload 'rnc-mode "rnc-mode")
   (setq auto-mode-alist
         (cons '("\\.rnc\\'" . rnc-mode) auto-mode-alist))

;; DTD mode
  (autoload 'dtd-mode "tdtd" "Major mode for SGML and XML DTDs." t)
  (autoload 'dtd-etags "tdtd"
    "Execute etags on FILESPEC and match on DTD-specific regular expressions."
    t)
  (autoload 'dtd-grep "tdtd" "Grep for PATTERN in files matching FILESPEC." t)
  (setq auto-mode-alist (append (list
                                 '("\\.dcl$" . dtd-mode)
                                 '("\\.dec$" . dtd-mode)
                                 '("\\.dtd$" . dtd-mode)
                                 '("\\.ele$" . dtd-mode)
                                 '("\\.ent$" . dtd-mode)
                                 '("\\.mod$" . dtd-mode))
                                auto-mode-alist))

;;open office ve mozilla arsiv dosyalarýný diredde acik gormek icin

(setq auto-mode-alist (cons '("\\.xpi$" . archive-mode) auto-mode-alist))

(setq auto-mode-alist (cons '("\\.sx$" . archive-mode) auto-mode-alist))

;; Ctrl+Tab for buffer switching

(require 'swbuff)

 (require 'wcy-swbuff)
 (global-set-key (kbd "<C-tab>") 'wcy-switch-buffer-forward)
 (global-set-key (kbd "<C-S-kp-tab>") 'wcy-switch-buffer-backward)


;; PHP Mode handling drupal module and other content-types

 (setq auto-mode-alist
       (append '(("\\.\\(php\\|module\\|engine\\|inc\\|thtml\\)\\'" . php-mode)) auto-mode-alist))

 (setq interpreter-mode-alist (append '(("php" . php-mode))
     				     interpreter-mode-alist))


;; Po files edit mode

(autoload 'po-mode "po-mode"
             "Major mode for translators to edit PO files" t)
   (setq auto-mode-alist (cons '("\\.po\\'\\|\\.po\\." . po-mode)
				  auto-mode-alist))

;; CSS, Javascript, php and txt mode use  tinypair mode for automatic insert brackets, " characters, this tinypair.el file comes with tinytools

(require 'tinypair)

;; Match Paren function

(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))

;; Cygwin w3m loading

(require 'w3m)
(setq browse-url-browser-function 'w3m-browse-url)

(require 'w3m-load)
(require 'pabbrev)
(require 'setnu)

;; show ascii table
;; optained from http://www.chrislott.org/geek/emacs/dotemacs.html
(defun ascii-table ()
  "Print the ascii table. Based on a defun by Alex Schroeder <asc@bsiag.com>"
  (interactive)
  (switch-to-buffer "*ASCII*")
  (erase-buffer)
  (insert (format "ASCII characters up to number %d.\n" 254))
  (let ((i 0))
    (while (< i 254)
      (setq i (+ i 1))
      (insert (format "%4d %c\n" i i))))
  (beginning-of-buffer))

;; For HTML Mode surrounding region with any tag

(defun surround-region-with-tag (tag-name beg end)
      (interactive "sTag name: \nr")
      (save-excursion
        (goto-char beg)
        (insert "<" tag-name ">")
        (goto-char (+ end 2 (length tag-name)))
        (insert "</" tag-name ">")))


;;Apache Mode-Handling Apache files

(autoload 'apache-mode "apache-mode" "autoloaded" t)
   (add-to-list 'auto-mode-alist '("\\.htaccess$"   . apache-mode))
   (add-to-list 'auto-mode-alist '("httpd\\.conf$"  . apache-mode))
   (add-to-list 'auto-mode-alist '("srm\\.conf$"    . apache-mode))
   (add-to-list 'auto-mode-alist '("access\\.conf$" . apache-mode))


;; Automatic imenu support for some modules

(setq javascript-load-hook (quote (imenu-add-menubar-index)))
(setq javascript-mode-hook (quote (imenu-add-menubar-index)))
(setq html-load-hook (quote (imenu-add-menubar-index)))
(setq html-mode-hook (quote (imenu-add-menubar-index)))
(setq emacs-lisp-load-hook (quote (imenu-add-menubar-index)))
(setq emacs-lisp-mode-hook (quote (imenu-add-menubar-index)))
(setq latex-load-hook (quote (imenu-add-menubar-index)))


;; Mozilla javascript console connection

    (add-hook 'javascript-mode-hook 'js-mode)
     (autoload 'js-mode "js-mode" nil t)
    
    
;; MSF-ABBREVS Mode- Textmate like snippets:)

;; ensure abbrev mode is always on

(setq-default abbrev-mode t)

;(msf-abbrev-load-tree "c:/Program Files/Emacs/site-lisp/mode-abbrevs") 

(require 'msf-abbrev)
(setq msf-abbrev-verbose t) ;; optional
(setq msf-abbrev-root "c:/Program Files/Emacs/site-lisp/mode-abbrevs")
(global-set-key (kbd "C-c l") 'msf-abbrev-goto-root)
(global-set-key (kbd "C-c a") 'msf-abbrev-define-new-abbrev-this-mode)
(msf-abbrev-load)

;;Linkd Mode : Very useful for project managament-form org mode author 

(require 'linkd)

(setq linkd-use-icons t)
 (setq linkd-icons-directory "~/.linkd-icons")

 (add-hook 'emacs-lisp-mode-hook 'linkd-mode)
 (add-hook 'lisp-mode-hook 'linkd-mode)
 (add-hook 'sh-mode-hook 'linkd-mode)
 (add-hook 'text-mode-hook 'linkd-mode)

 (global-set-key [(control \&)] 'linkd-follow-on-this-line)
 (global-set-key [(control f3)] 'linkd-process-block)
 (global-set-key (kbd "M-[") 'linkd-previous-link)
 (global-set-key (kbd "M-]") 'linkd-next-link)
 (global-set-key (kbd "M-RET") 'linkd-follow-at-point)

;; Paredit Mode for Lisp and Elisp

(require 'paredit)

  (autoload 'paredit-mode "paredit"
    "Minor mode for pseudo-structurally editing Lisp code."
    t)


(mapc (lambda (mode)
	(let ((hook (intern (concat (symbol-name mode)
				    "-mode-hook"))))
	  (add-hook hook (lambda () (paredit-mode +1)))))
      '(emacs-lisp lisp inferior-lisp))

 (load "auctex.el" nil t t)
          (load "preview-latex.el" nil t t)


;; Auctex Mode Conf with Reftex support

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq mode-line-format nil)

;; CSV Files viewing and editing

(require 'csv-mode)


(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
(autoload 'csv-mode "csv-mode"
  "Major mode for editing comma-separated value files." t)


(require 'csv)

(load "csv.el" nil t t)

;; ERC Extras

(add-to-list 'load-path "/erc-extras" t)

(require 'erc)

;; Very funny window effects:)

(require 'windzoom);;This is windzoom.el from Japan:)

;; Tramp extras- I use tramp for ftp connections

(require 'tramp-util)

;;Textile file editing

(require 'textile-mode)

(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))


;; XML-RPC Service for Blog Software

(require 'weblogger)


(require 'keywiz)

;;Drupal Minor Mode

(defun drupal-minor-mode ()
  (interactive)
  (php-mode)
  (setq c-basic-offset 2)
  (setq indent-tabs-mode nil)
  (setq fill-column 78)
  (c-set-offset 'case-label 2)
  (c-set-offset 'arglist-close 0))


 (setq auto-mode-alist
        (append '(("\\.\\(php\\|module\\|template\\|engine\\|inc\\|thtml\\)\\'" . drupal-minor-mode)) auto-mode-alist))

(autoload 'drupal-minor-mode "drupal-minor-mode" nil t)

;; Smarty Mode
(require 'smarty-mode)

(autoload 'smarty-mode "smarty-mode" "SmartyMode" t)

 (setq auto-mode-alist
       (append '(("\\.\\(template\\|tpl\\)\\'" . smarty-mode)) auto-mode-alist))


;; Note: PHP-Javascript and CSS Modes load with nxhtml-mode start file...
;; Auctex Mode have self conf files...