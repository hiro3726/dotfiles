;;; -*- coding: utf-8 -*-
;;; Last modified: 2010/03/07 21:22:59

;;;
; Language and Coding system
;;;
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq file-name-coding-system 'utf-8)

;;;
; Loadpath
;;;
(setq load-path (cons "~/.emacs.d/elisp/" load-path))

;;;
; Keybinding
;;;
;(global-set-key "\C-m" 'reindent-then-newline-and-indent)
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-j" 'newline)
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\C-x\C-h" 'help)

;;;
; Misc
;;;
(setq kill-whole-line t)
(setq next-line-add-newline nil)
(setq inhibit-startup-message t)
(setq inhibit-startup-screen t)
(setq make-backup-files nil)
(setq auto-save-list-file-prefix nil)
(setq require-final-newline t)
(setq scroll-conservatively 35
       scroll-margin 0
       scroll-step 1)
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;;;
; Appearances
;;;
(if window-system
    (tool-bar-mode 0))
(menu-bar-mode 0)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(show-paren-mode t)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-string-forms
      '(year "/" month "/" day "(" dayname ") " 24-hours ":" minutes))
(display-time)
(line-number-mode t)
(column-number-mode t)
(transient-mark-mode t)
(setq visual-bell t)
;(require 'hl-line)
;(global-hl-line-mode)
;(defface hlline-face
;  '((((class color)
;      (background dark))
;     (:background "blue" :foreground "white"))
;    (((class color)
;      (background light))
;     (:background "ForestGreen"))
;    (t
;     ()))
;  "*Face used by hl-line.")
;(setq hl-line-face 'hlline-face)

;;;
; Color Theme
;;;
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-clarity)))

;;;
; Template
;;;
(require 'autoinsert)
(setq auto-insert-directory "~/.emacs.d/template/")
(setq auto-insert-alist
      (nconc '(("\\.c$" . "template.c")
               ("\\.cc$" . "template.cc")
               ("\\.cpp$" . "template.cc")
               ("\\.py$" . "template.py")
               ) auto-insert-alist))
(add-hook 'find-file-not-found-hooks 'auto-insert)

;;;
; Timestamp
;;;
(require 'time-stamp)
(add-hook 'write-file-hooks 'time-stamp)
(setq time-stamp-active t)
(setq time-stamp-start "Last modified:[ \t]")
(setq time-stamp-format "%04y/%02m/%02d %02H:%02M:%02S")
(setq time-stamp-end "$")
(defadvice time-stamp (around time-stamp-around activate)
    (let (buffer-undo-list)
          ad-do-it))

;;;
; Indentation
;;;
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)
;cc-mode
(require 'cc-mode)
(setq c-default-style "k&r")
(add-hook 'c-mode-common-hook
          '(lambda ()
             (progn
               (c-toggle-hungry-state t)
               (c-toggle-auto-state t)
               (setq c-basic-offset 4 indent-tabs-mode nil)
               (let ()
                 (c-set-offset 'statement-cont 'c-lineup-math))
               (setq comment-start "//")
               (setq comment-end "")
               )))

;;;
; Auto-completion
;;;
(require 'auto-complete)
(global-auto-complete-mode t)

;;;
; smart-comple
;;;
(require 'smart-compile)
(global-set-key "\C-c\C-c" 'smart-compile)
(add-hook 'c-mode-common-hook
          (lambda ()(local-set-key "\C-c\C-c" 'smart-compile)))

;;;
; Shell
;;;
(require 'shell-command)
(shell-command-completion-mode)
(when (require 'shell-history nil t)
    (when (require 'anything-complete nil t)
      (add-hook 'shell-mode-hook  (lambda ()
                                    (define-key shell-mode-map (kbd "C-r") 'anything-complete-shell-history)))

      (use-anything-show-completion 'anything-complete-shell-history  '(length anything-c-source-complete-shell-history))))
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;;
; install-elisp.el and auto-install.el
;;;
;(require 'install-elisp)
;(setq install-elisp-repository-directory "~/.emacs.d/elisp/")
;(require 'auto-install)
;(setq auto-install-directory "~/.emacs.d/elisp/")
;(auto-install-update-emacswiki-package-name t)
;(auto-install-compatibility-setup)


;;;
; iswitchb
;;;
(iswitchb-mode 1)
(defun iswitchb-my-keys ()
  "Add my keybindings for iswitchb."
  (define-key iswitchb-mode-map [right] 'iswitchb-next-match)
  (define-key iswitchb-mode-map [left] 'iswitchb-prev-match)
  (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
  (define-key iswitchb-mode-map " " 'iswitchb-next-match)
  (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)
  )
 	
(defun iswitchb-possible-new-buffer (buf)
  "Possibly create and visit a new buffer called BUF."
  (interactive)
  (message (format
            "No buffer matching `%s', "
            buf))
  (sit-for 1)
  (call-interactively 'find-file buf))

(defun iswitchb-buffer (arg)
  "Switch to another buffer.

The buffer name is selected interactively by typing a substring.  The
buffer is displayed according to `iswitchb-default-method' -- the
default is to show it in the same window, unless it is already visible
in another frame.
For details of keybindings, do `\\[describe-function] iswitchb'."
  (interactive "P")
  (if arg
      (call-interactively 'switch-to-buffer)
    (setq iswitchb-method iswitchb-default-method)
    (iswitchb)))

(defadvice iswitchb-exhibit
  (after
   iswitchb-exhibit-with-display-buffer
   activate)
  "選択している buffer を window に表示してみる。"
  (when (and
         (eq iswitchb-method iswitchb-default-method)
         iswitchb-matches)
    (select-window
     (get-buffer-window (cadr (buffer-list))))
    (let ((iswitchb-method 'samewindow))
      (iswitchb-visit-buffer
       (get-buffer (car iswitchb-matches))))
    (select-window (minibuffer-window))))

;;;
; dired
;;;
(require 'dired-x)
;code-system conversion inside dired
(require 'dired-aux)
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key (current-local-map) "T"
              'dired-do-convert-coding-system)))

(defvar dired-default-file-coding-system nil
  "*Default coding system for converting file (s).")

(defvar dired-file-coding-system 'no-conversion)

(defun dired-convert-coding-system ()
  (let ((file (dired-get-filename))
        (coding-system-for-write dired-file-coding-system)
        failure)
    (condition-case err
        (with-temp-buffer
          (insert-file file)
          (write-region (point-min) (point-max) file))
      (error (setq failure err)))
    (if (not failure)
        nil
      (dired-log "convert coding system error for %s:¥n%s¥n" file failure)
      (dired-make-relative file))))

(defun dired-do-convert-coding-system (coding-system &optional arg)
  "Convert file (s) in specified coding system."
  (interactive
   (list (let ((default (or dired-default-file-coding-system
                            buffer-file-coding-system)))
           (read-coding-system
            (format "Coding system for converting file (s) (default, %s): "
                    default)
            default))
         current-prefix-arg))
  (check-coding-system coding-system)
  (setq dired-file-coding-system coding-system)
  (dired-map-over-marks-check
   (function dired-convert-coding-system) arg 'convert-coding-system t))

;;;
; Anything
;;;
(require 'anything)
(require 'anything-config)
(require 'anything-match-plugin)
(require 'anything-show-completion)
(define-key global-map (kbd "C-l") 'anything)
(setq anything-sources
      '(anything-c-source-buffers+
        anything-c-source-recentf
        anything-c-source-man-pages
        anything-c-source-emacs-commands
        anything-c-source-emacs-functions
        anything-c-source-files-in-current-dir
        anything-c-source-kill-ring
        ))
(global-set-key "\M-y" 'anything-show-kill-ring)

;;;
; Yasnippet
;;;
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")

;;;
; Python
;;;
(load-library "init_python")
;(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
;(setq interpreter-mode-alist (cons '("python" . python-mode) interpreter-mode-alist))
;(autoload 'python-mode "python-mode" "Python editing mode." t)
;(require 'ipython)
;(require 'python-mode)
; (require 'pymacs)
; (pymacs-load "ropemacs" "rope-")
; (require 'anything-ipython)
; (add-hook 'python-mode-hook '(lambda ()
;                                (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))
; (add-hook 'ipython-shell-hook '(lambda ()
;                                (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))
; (provide 'python-programming)
; (use-anything-show-completion 'anything-ipython-complete
;                               '(length initial-pattern))

;;;
; Textmate-mode
;;;
;(require 'textmate)
;(textmate-mode)

;;;
; automatically generated by emacs
;;;
(put 'set-goal-column 'disabled nil)
;EOF
