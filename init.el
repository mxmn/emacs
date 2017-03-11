;;; init.el --- Emacs configuration
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

;; Timing emacs startup
(defvar time-start (current-time))

;;;; Early user interface setup


;; Initial window setup, to be done right at the beginning
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
;(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(setq inhibit-startup-screen t) ;; No splash screen please... jeez



;; Window size
(when window-system
  (set-frame-size (selected-frame) 100 71))
(setq default-frame-alist '((width . 100)(height . 71)))



;;;; Package management

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

;; For fast automatic installation on a new system:
;; - use the mxn-install-packages command function, as defined below
;; - if elpa/melpa complains, try to run pacakge-refresh-contents
(defvar my-packages-to-be-installed
  '( use-package
     default-text-scale
     magit
     helm
     projectile
     helm-projectile
     helm-descbinds
     flycheck
     markdown-mode
     company
     auctex
     undo-tree
     cdlatex
     writeroom-mode
     ))
(defun install-my-packages ()
  "Install only the sweetest of packages."
  (interactive)
  (package-refresh-contents)
  (mapc #'(lambda (package)
            (unless (package-installed-p package)
              (package-install package)))
        my-packages-to-be-installed))


;;;; Other configuration files

(add-to-list 'load-path "~/conf/emacs")

;;; personal/private setup (identity, local directories)
(load-library "emacs_personal")

(load-library "emacs_abc")
(load-library "emacs_org.el")
(load-library "emacs_pyconda.el")
(load-library "emacs_idl.el")
(load-library "emacs_latex.el")


(message (format-time-string "Emacs startup time: %S s and %3N ms"
                             (time-subtract (current-time) time-start)))

;;; Other manually downloaded packages
;; e.g. the undo-tree that I was not able to install via melpa on 01/28/17
;; - However, if not able to find package in melpa, do a package-refresh-contents!
;; (add-to-list 'load-path "~/conf/emacs/lisp/")


;;;; Theme setup
;; (load-theme 'deeper-blue) ;;; set the color theme early on
;; (load-theme 'dracula t)
;; (load-theme 'zenburn t)
;; (load-theme 'sanityinc-tomorrow-day t)  ;; light
;; (load-theme 'sanityinc-tomorrow-night t)
;; (load-theme 'solarized-dark t)
;; (load-theme 'solarized-light t)    ;; ++ light + easy on eyes
(load-theme 'monokai t)     ;; ++ medium


;;; init.el ends here
