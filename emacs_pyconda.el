;;; emacs_pyconda.el --- basic configuration
;;
;;; Commentary:
;;
;; Emacs Python support configuration.
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

(require 'python)

;;; to use anaconda python

(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "I\\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "O\\[[0-9]+\\]: ")


;;; sometimes this gave me problems.
;;; now, always enforce 4 spaces, as recommended in the style guide.
;;; (can be adjusted if alien code is used)
(setq
 python-indent-offset 4
 python-indent-guess-indent-offset nil )


;;; code completion sometimes slows me down extremely....
;;; -- let's remove this for now, mxn, 2/11/16
;; (setq
;;  python-shell-completion-setup-code
;;    "from IPython.core.completerlib import module_completion"
;;  python-shell-completion-module-string-code
;;    "';'.join(module_completion('''%s'''))\n"
;;  python-shell-completion-string-code
;;    "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")


(defun mxn-python-hook()
  (setq fill-column 79)
  ;; (electric-indent-mode -1) ;; recommended to remove with "-1"
  (setq word-wrap nil) ;; wrap by words
  (visual-line-mode -1)
  ;(set-window-margins nil 0 (- (window-body-width) fill-column))
  ;(setq right-margin-width (- (window-body-width) fill-column))
  ;;(set-default 'truncate-lines t)
  ;; (local-set-key (kbd "C-S-c") python-shell-send-buffer)
  ;; (local-set-key (kbd "C-S-e") python-shell-send-region)
  ;; (local-set-key (kbd "C-S-z") python-shell-switch-to-shell)
  ;; (local-set-key (kbd "M-S-<left>") python-indent-shift-left)
  ;; (local-set-key (kbd "M-S-<right>") python-indent-shift-right)
)

(add-hook 'python-mode-hook 'mxn-python-hook)

;;; anaconda mode (code navigation, documentation lookup and completion)
(add-hook 'python-mode-hook 'anaconda-mode)

;;; document function eldoc-mode
;;; - doesn't seem to work
;;(add-hook 'python-mode-hook 'anaconda-eldoc-mode)

;;; Using company and company-anaconda for autocompletion
(require 'company)
(eval-after-load "company"
 '(progn
   (add-to-list 'company-backends 'company-anaconda)))
;; activate company in all buffers, for which a backend is available
(add-hook 'after-init-hook 'global-company-mode)
;; (add-hook 'python-mode-hook 'company-mode)


;;; emacs_pyconda.el ends here
