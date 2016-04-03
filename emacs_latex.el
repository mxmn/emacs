;;; emacs_latex.el --- basic configuration
;;
;;; Commentary:
;;
;; Emacs LaTeX / auctex support configuration.
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;           LLLLLL  AAAAAA  TTTTTT  EEEEEE  XXXXXX         ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; Code:

;;; 18.04.05
;;------------------------ LaTex Options --------------------------
(add-hook 'TeX-mode-hook
      '(lambda ()
         (auto-fill-mode 1)
         (turn-on-font-lock)))


;; Cogito, 6-9-93 -- creation du mode LaTeX (different de celui par defaut)
(defvar LaTeX-font-lock-keywords
  (list
   ;; LaTeX-emphasized, italic, slanted en italique
   '("{\\\\em\\([^}]+\\)}" 1 'italic t)
   '("{\\\\it\\([^}]+\\)}" 1 'italic t)
   '("{\\\\sl\\([^}]+\\)}" 1 'italic t)
   '("\\\\emph{\\([^}]+\\)}" 1 'italic t)
   '("\\\\textit{\\([^}]+\\)}" 1 'italic t)
   '("\\\\textsl{\\([^}]+\\)}" 1 'italic t)
   ;; LaTeX-bold-face, small-caps, sans-serif en gras
   '("{\\\\bf\\([^}]+\\)}" 1 'bold t)
   '("{\\\\sf\\([^}]+\\)}" 1 'bold t)
   '("{\\\\sc\\([^}]+\\)}" 1 'bold t)
   '("{\\\\tt\\([^}]+\\)}" 1 'bold t)
   '("\\\\textbf{\\([^}]+\\)}" 1 'bold t)
   '("\\\\textsf{\\([^}]+\\)}" 1 'bold t)
   '("\\\\textsc{\\([^}]+\\)}" 1 'bold t)
   '("\\\\texttt{\\([^}]+\\)}" 1 'bold t)
   ;; LaTeX-underline en souligne
   '("\\\\underline{\\([^}]+\\)}" 1 'underline t)
   ;; commandes LaTeX --> fonctions
   '("\\(\\\\[A-Za-z@]+\\)" 1 font-lock-function-name-face t)
   ;; parametres optionnels aux commandes
   '("\\\\[a-z@]+\\[\\([^]]+\\)\\]" 1 font-lock-string-face t)
   ;; commentaires traites ici pour ne pas fontifier les commandes commentees
   '("^%+\\([^\n]+\\)$"     1 font-lock-comment-face t)
   '("[^\\]%+\\([^\n]+\\)$" 1 font-lock-comment-face t)
   ))


;; trying to get auctex to work on snow leopard with emacs 23.3.1
(setenv "PATH" (concat "/usr/texbin:/usr/local/bin:" (getenv "PATH")))
(setq exec-path (append '("/usr/texbin" "/usr/local/bin") exec-path))
(load "auctex.el" nil t t)


(add-hook 'LaTeX-mode-hook '(lambda ()
                 (TeX-fold-mode 1)
                 (outline-minor-mode 1)
                   ))

(defun LaTeX-custom-hook ()
  "LaTeX mode customizations (for AUC TeX)."
  (setq indent-tabs-mode nil)
  (auto-fill-mode 1)
  (setq ;; fill-column 80  -- removed -- mn, 12/16/14
   TeX-parse-self t
   ;;TeX-auto-save t - no effect - mn, 11/25/14
   ))

(add-hook 'LaTeX-mode-hook 'LaTeX-custom-hook)

;;; from http://www.emacswiki.org/AUCTeX - mn, 11/25/14
;;(setq TeX-auto-save t) - no effect - mn, 11/25/14
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
;;(setq TeX-PDF-mode t) - no effect - mn, 11/25/14


; BibTeX auto files
(defun BibTeX-custom-hook ()
  "BibTeX mode customizations (for AUC TeX)."
  (setq TeX-auto-save t))

(add-hook 'bibtex-mode-hook 'BibTeX-custom-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;           LLLLLL  AAAAAA  TTTTTT  EEEEEE  XXXXXX         ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; emacs_latex.el ends here
