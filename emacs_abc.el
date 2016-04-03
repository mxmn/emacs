;;; emacs_abs.el --- basic configuration
;;
;;; Commentary:
;;
;; Patched/stolen from many different sources in the time frame 1998-now.
;;
;; Incomplete list of sources:
;; - http://milkbox.net/note/single-file-master-emacs-configuration/
;; - http://sachachua.com/blog/
;; - https://github.com/seanirby/dotfiles
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Code:

;;;; helm


(require 'helm-config)
(helm-mode 1)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

;; Switch TAB and C-z
;; Now, TAB (and C-j) is persistent action, and C-z is action selection
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i")   'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z")   'helm-select-action)

;; show minibuffer history
(define-key minibuffer-local-map (kbd "C-c C-l") 'helm-minibuffer-history)


(setq
 ;; open helm buffer inside current window, not occupy whole other window
 helm-split-window-in-side-p           t
 ;; move to end or beginning of source when reaching top or bottom of source.
 helm-move-to-line-cycle-in-source     t
 ;; search for library in `require' and `declare-function' sexp.
 ;;   helm-ff-search-library-in-sexp        t
 ;; show recently opened files in find-file
 helm-ff-file-name-history-use-recentf t )


;; fuzzy matching
(setq helm-M-x-fuzzy-match t
      helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t
      helm-apropos-fuzzy-match    t
      helm-semantic-fuzzy-match   t    ;; with semantic
      helm-imenu-fuzzy-match      t)   ;; with semantic


(global-set-key (kbd "M-x") 'helm-M-x) ;; M-x  !!!
(global-set-key (kbd "M-y") 'helm-show-kill-ring) ;; kill-ring  !!!
(global-set-key (kbd "C-x b") 'helm-mini) ;; C-x b
(global-set-key (kbd "C-x C-b") #'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-r") #'helm-recentf) ;; +++ looks very useful +++
(global-set-key (kbd "C-c i") 'helm-semantic-or-imenu) ;; +++ imenu or semantic
(global-set-key (kbd "C-c o") 'helm-occur) ;; +++ occur/grep
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings) ;; +++ local global Mark Ring.
(global-set-key (kbd "C-c h x") 'helm-register) ;; View registers
(global-set-key (kbd "C-x r l") #'helm-filtered-bookmarks) ;; ?? bookmarks ??
(global-set-key (kbd "C-c g") 'helm-google-suggest) ;; +++ get suggestions by google
(when (executable-find "curl") (setq helm-google-suggest-use-curl-p t))

;; other cool helm stuff, with a helm-prefix (C-c h):
;;  find     /
;;  locate   l
;;  apropos  a
;;  top      t
;;  calc     C-,
;;  descbind C-h


;;;; helm related packages

;; Semantic - language-aware editing commands based on 'source code parsers.
;; Combines well with helm and available for e.g. C/C++, Java, Python.
(semantic-mode 1)


;; C-c h C-h - get more information on available commands with C-c h prefix
(require 'helm-descbinds)
(helm-descbinds-mode)


(require 'helm-eshell)
(add-hook 'eshell-mode-hook
          #'(lambda () (define-key eshell-mode-map (kbd "TAB")
                         #'helm-esh-pcomplete)
              (define-key eshell-mode-map (kbd "C-c C-l")  'helm-eshell-history)))


;;;; Imenu

(require 'imenu)
(setq imenu-auto-rescan t) ;; auto update of functions in buffer

;;; inserts sections into emacs imenu, lines that start with 4 semicolons ";;;;".
(defun imenu-elisp-sections ()
  (setq imenu-prev-index-position-function nil)
  (add-to-list 'imenu-generic-expression '("Sections" "^;;;; \\(.+\\)$" 1) t))
(add-hook 'emacs-lisp-mode-hook 'imenu-elisp-sections)


;;;; magit

(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)


;;;; Basic ABC setup


(blink-cursor-mode 0) ;; Prevent the cursor from blinking
(setq initial-scratch-message "") ;; Don't use messages that you don't read
(setq redisplay-dont-pause t) ;; says, it's best rendering of the buffer
(setq ring-bell-function 'ignore) ;; disable bell
;;(setq visible-bell t) ;; Prevent the annoying beep on errors
(show-paren-mode 1) ;; enable emphasis of content between {}, [], ()
(setq show-paren-style 'expression) ;; show in color the content between paren's
(delete-selection-mode t) ;; Enable killing of a whole region
(set-language-environment 'UTF-8) ;; coding-system settings
(setq line-number-mode    t)  ;; Display line and column numbers
(setq column-number-mode  t)  ;; Display line and column numbers
;;(fset 'yes-or-no-p 'y-or-n-p)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(defalias 'yes-or-no-p 'y-or-n-p) ;; "y or n" instead of "yes or no"
(global-set-key "\C-c\C-l" 'goto-line) ;; goto-line keybinding
(setq fill-column 79)  ;; Python style recommends limiting line lengths to 79 chars.
(global-set-key (kbd "C-S-b") 'bookmark-jump) ;; jump to bookmark


;; Electric mode settings
(electric-pair-mode 1) ;; automatic closure of {},[],() and going inside
(electric-indent-mode 1)

;; scrolling borders to top/bottom
(setq scroll-step 1) ;; go up/down by 1 line
(setq scroll-margin 3) ;; move n lines away from border
(setq scroll-conservatively 10000)
;;(setq scroll-conservatively 50)
;;(setq scroll-preserve-screen-position 't) ; no jumps at bottom/top

;; Display file size/time in mode-line
;; (setq display-time-24hr-format t) ;; 24-hour format
;; (display-time-mode t) ;; show time in mode-line
(size-indication-mode t) ;; file size in percent

;; Line wrapping
(setq word-wrap t) ;; wrap by words
;; (global-visual-line-mode t)

;; Trailing whitespace is unnecessary
(add-hook 'before-save-hook
          (lambda () (delete-trailing-whitespace)))
;; Replace tabs by whitespaces at save:
;; Files with tabs should set indent-tabs-mode to t
;; (makefile-mode does this automatically):
;; modes that really need tabs should enable
;; indent-tabs-mode explicitly. makefile-mode already does that, for
;; example.
(setq-default indent-tabs-mode nil)
;; if indent-tabs-mode is off, untabify before saving
(add-hook 'write-file-hooks
          (lambda () (if (not indent-tabs-mode)
                         (untabify (point-min) (point-max))) nil ))



;;;; Text scaling

(global-set-key (kbd "C-M-=")         'default-text-scale-increase)
(global-set-key (kbd "C-M--")         'default-text-scale-decrease)


;;;; Fringe settings

(fringe-mode '(5 . 5)) ;; constraining text to the left
;; (setq-default indicate-buffer-boundaries 'left) ;; only show on the left
(setq-default indicate-empty-lines t) ;; Explicitly show the end of a buffer


;;;; Window navigation: M-arrow-keys

;; except in the org mode (which uses the keybindings as well)
(if (equal nil (equal major-mode 'org-mode))
    (windmove-default-keybindings 'meta))
;; mapping them as well to Alt-Cmd (same as in iTerm)
(global-set-key (kbd "M-s-<left>")  'windmove-left)
(global-set-key (kbd "M-s-<right>") 'windmove-right)
(global-set-key (kbd "M-s-<up>")    'windmove-up)
(global-set-key (kbd "M-s-<down>")  'windmove-down)


;; Make window splitting more useful
;; Copied from http://www.reddit.com/r/emacs/comments/25v0eo/you_emacs_tips_and_tricks/chldury
(defun sacha/vsplit-last-buffer (prefix)
  "Split the window vertically and display the previous buffer."
  (interactive "p")
  (split-window-vertically)
  (other-window 1 nil)
  (if (= prefix 1)
      (switch-to-next-buffer)))
(defun sacha/hsplit-last-buffer (prefix)
  "Split the window horizontally and display the previous buffer."
  (interactive "p")
  (split-window-horizontally)
  (other-window 1 nil)
  (if (= prefix 1) (switch-to-next-buffer)))
(bind-key "C-x 2" 'sacha/vsplit-last-buffer)
(bind-key "C-x 3" 'sacha/hsplit-last-buffer)


;;;; use-package

(require 'use-package)


;;;; Winner
;; use C-c <left> C-c <right> to undo and redo *window configuration.
(use-package winner
  :ensure winner
  :init (winner-mode 1))


;; Bookmark settings
;;; just use (move to somewhere else, and learn):
;;; C-x r m   - Mark bookmark
;;; C-x r b   - goto Bookmark
;;; C-x r l   - List bookmarks


;;;; Flyspell

;; with M-\t (M-TAB), Flyspell replaces current miss-spelled word with a
;; possible correction. Use again, to cycle through suggestions.
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(autoload 'flyspell-delay-command "flyspell" "Delay on command." t)
(autoload 'tex-mode-flyspell-verify "flyspell" "" t)
(setq flyspell-sort-corrections nil)
;; (setq flyspell-doublon-as-error-flag nil)  ; double word is an error ?
(add-hook 'LaTeX-mode-hook 'flyspell-mode)  ; automatic start of flyspell


;;;; Custom functions

;;; Count words in a region
(defun count-words-region (beginning end)
  "Print number of words in the region."
  (interactive "r")
  (message "Counting words in region ... ")
;;; 1. Set up appropriate conditions.
  (save-excursion
    (let ((count 0))
      (goto-char beginning)
;;; 2. Run the while loop.
      (while (and (< (point) end)
                  (re-search-forward "\\w+\\W*" end t))
        (setq count (1+ count)))
;;; 3. Send a message to the user.
      (cond ((zerop count)
             (message
              "The region does NOT have any words."))
            ((= 1 count)
             (message
              "The region has 1 word."))
            (t
             (message
              "The region has %d words." count))))))


;;;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
;(global-flycheck-mode)
(setq flycheck-checker-error-threshold 1000) ;; or switch back to default 400
(setq flycheck-pylintrc ".pylintrc")
(setq flycheck-keymap-prefix (kbd "C-c *")) ;; changing the flycheck prefix to C-c *



;;;; Major modes


;; set octave-mode the default for .m files
(setq auto-mode-alist (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; set python-mode the default for cython .pyx / .pxd files
(setq auto-mode-alist (cons '("\\.pyx$" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pxd$" . python-mode) auto-mode-alist))

;; markdown-mode
(setq auto-mode-alist (cons '("\\.md$" . markdown-mode) auto-mode-alist))


;;;; Testing modes/packages

;; from J.Smith emacs/latex/auctex page
;;Bind shift mouse-3 to the imenu, and meta shift mouse-3 to alphabetical imenu
;; it works, mn, 3/11/12
(when window-system
  (define-key global-map [S-down-mouse-3] 'imenu)
  (define-key global-map [M-S-down-mouse-3]
    (lambda ()
      (interactive)
      (let ((imenu-sort-function
        'imenu--sort-by-name))
   (call-interactively 'imenu)))))
;; and, additionally with C-S-mouse-1
(when window-system
  (define-key global-map [C-S-down-mouse-1] 'imenu)
  (define-key global-map [M-C-S-down-mouse-1]
    (lambda ()
      (interactive)
      (let ((imenu-sort-function
        'imenu--sort-by-name))
   (call-interactively 'imenu)))))



;;; emacs_abc.el ends here
