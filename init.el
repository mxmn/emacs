;;; init.el --- Emacs configuration
;;
;; Author: Maxim Neumann
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


;; Timing emacs startup
(defvar time-start (current-time))



;;;; Identity and early user interface setup

;; Identity
(setq user-full-name "Maxim Neumann"
      user-mail-address "neumann.maxim@gmail.com")


;; Initial window setup, to be done right at the beginning
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
;(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(setq inhibit-startup-screen t) ;; No splash screen please... jeez
(load-theme 'deeper-blue) ;;; set the color theme early on

;; Window size
(when window-system
  (set-frame-size (selected-frame) 86 71))
(setq default-frame-alist '((width . 86)(height . 71)))



;;;; Package management


(require 'package)
;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

;; For fast automatic installation on a new system
(defvar packages-to-be-installed
  '( use-package
     default-text-scale
     magit
     helm
     ;;helm-projectile
     helm-descbinds
     flycheck
     markdown-mode
     ))

(defun mxn-install-packages ()
  "Install only the sweetest of packages."
  (interactive)
  (package-refresh-contents)
  (mapc #'(lambda (package)
            (unless (package-installed-p package)
              (package-install package)))
        packages-to-be-installed))



;;;; Other configuration files

(add-to-list 'load-path "~/conf/emacs")
(load-library "emacs_abc")

;;;; final ones
(add-to-list 'load-path "~/conf/emacs24")
(load-library "emacs_org2.el")
(load-library "emacs_idl.el")
;;(load-library "emacs_python4.el")
(load-library "emacs_pyconda.el")

(load-library "emacs_latex.el")

(load-library "tobesorted.el")
(load-library "experimental.el")


(message (format-time-string "Emacs startup time: %S s and %3N ms"
                             (time-subtract (current-time) time-start)))

;;; init.el ends here
