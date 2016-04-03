;;; emacs_idl.el --- Emacs configuration
;;
;;; Commentary:
;;
;; Configuration of IDL's emacs IDLWave mode.
;;
;;
;;
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
;;;;;;;        IIII  DDDD  LLLL   ---    WWW  AAA  VVV  EEE      ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Code:

(autoload 'idlwave-mode "idlwave" "IDLWAVE Mode" t)
(autoload 'idlwave-shell "idlw-shell" "IDLWAVE Shell" t)
(setq auto-mode-alist
      (cons '("\\.pro\\'" . idlwave-mode) auto-mode-alist))

(setq
 idlwave-abbrev-start-char "."
 ;; No frame splitting please
 idlwave-shell-use-dedicated-frame t
 )

(set-face-background my-face "GoldenRod")

;;; new (from jd's .emacs); mn 05/10
;; I'll add this little hook to both the idlwave-mode and
;; idlwave-shell-mode hooks, because I'd like the keys in both.
(defun my-common-idlwave-hook ()
  (local-set-key [C-S-mouse-2] 'idlwave-mouse-context-help)
  (local-set-key [C-kp-subtract] 'idlwave-shell-stack-up)
  (local-set-key [C-kp-add] 'idlwave-shell-stack-down))


(add-hook 'idlwave-mode-hook 'turn-on-font-lock)

(add-hook 'idlwave-mode-hook
          (lambda ()
;;; new (from jd's .emacs); mn 05/10
            ;; To complete structure tags at the Shell prompt and in files!
            (require 'idlw-complete-structtag)
            (set (make-local-variable 'minor-mode-alist)
                 (copy-sequence minor-mode-alist))
            (delq (assq 'auto-fill-function minor-mode-alist) minor-mode-alist)
            (delq (assq 'abbrev-mode minor-mode-alist) minor-mode-alist)

;;; to test; add them later to shell as well; and replace by examine commands.
                                (local-set-key [C-S-mouse-3] 'idlwave-mouse-context-help)
                                (local-set-key [C-S-mouse-1] 'idlwave-mouse-context-help)

            ;(local-set-key [tab] 'indent-relative)
            (local-set-key [return] 'idlwave-newline)
            (local-set-key [f5] 'idlwave-shell-break-here)
            (local-set-key [f6] 'idlwave-shell-clear-current-bp)
            (local-set-key [f7] 'idlwave-shell-cont)
            (local-set-key [f8] 'idlwave-shell-clear-all-bp)

            (local-unset-key "\M-s")
            ;; If my finger wanders up to Escape
            (local-set-key [?\e?\t] 'idlwave-complete)
            (setq                        ; Set Options Here
             idlwave-expand-generic-end t
             idlwave-completion-show-classes 10
             idlwave-store-inquired-class t
             font-lock-maximum-decoration 3

             ;; A little trick to help fill routine descriptions with
             ;; fancy line delimiters (like =*=*=*=*...).
             paragraph-separate "[ \t\f]*$\\|[ \t]*;+[ \t]*$\\|;+[+=-_*]+$"

             ;; These are in too many classes, so query for them.
             idlwave-query-class '((method-default . nil)
                                   (keyword-default . nil)
                                   ("INIT" . t)
                                   ("CLEANUP" . t)
                                   ("SETPROPERTY" .t)
                                   ("GETPROPERTY" .t)))

            ;; Some personal abbreviations
            (idlwave-define-abbrev "on" "obj_new()"
                                   (idlwave-keyword-abbrev 1))
            (idlwave-define-abbrev "fn1" "for i=0,n_elements()-1 do"
                                   (idlwave-keyword-abbrev 6))
;;; old ones; mn 05/10
            (local-set-key [C-S-/] 'idlwave-shell-help-expression)
            (local-set-key [C-?] 'idlwave-shell-help-expression)
            (local-set-key [f5] 'idlwave-shell-break-here)
            (local-set-key [f6] 'idlwave-shell-clear-current-bp)
            (local-set-key [f7] 'idlwave-shell-cont)
            (local-set-key [f8] 'idlwave-shell-clear-all-bp)
            (setq                        ; Set Options Here
             ;; Gotta have that smart-continue-indenting
             idlwave-max-extra-continuation-indent 20
             idlwave-expand-generic-end t
             ;; Any self-respecting programmer indents his main block
             idlwave-main-block-indent 2
             idlwave-block-indent 2
             idlwave-end-offset -2
             idlwave-init-rinfo-when-idle-after 2
             idlwave-continuation-indent 2
             idlwave-reserved-word-upcase nil ; Don't uppercase reserved words
             idlwave-shell-automatic-start t

             ;; Ahh, mixed case for nearly everything.  Only upcase keywords.
             idlwave-completion-case '((routine . preserve)
                                       (keyword . upcase)
                                       (class . preserve)
                                       (method . preserve))
             ;; A little trick to help fill routine descriptions with
             idlwave-shell-debug-modifiers '(control shift)
             )

            ;; Some personal abbreviations
            (idlwave-define-abbrev "wb" "widget_base()" (idlwave-keyword-abbrev 1))
            (idlwave-define-abbrev "rs" ".reset_session" (idlwave-keyword-abbrev 0))
            (idlwave-define-abbrev "co" "compile_opt idl2, strictArrSubs" (idlwave-keyword-abbrev 0))
            (idlwave-define-abbrev "o" "plot," (idlwave-keyword-abbrev 0))
            (idlwave-define-abbrev "hp" "histoplot," (idlwave-keyword-abbrev 0))
            (idlwave-define-abbrev "ho" "histoplot," (idlwave-keyword-abbrev 0))
                 (idlwave-define-abbrev "t" "transpose()" (idlwave-keyword-abbrev 1))
                 (idlwave-define-abbrev "tr" "transpose()" (idlwave-keyword-abbrev 1))
                 (idlwave-define-abbrev "te" "temporary()" (idlwave-keyword-abbrev 1))
                 (idlwave-define-abbrev "tm" "temporary()" (idlwave-keyword-abbrev 1))
                 (idlwave-define-abbrev "temp" "temporary()" (idlwave-keyword-abbrev 1))
            (idlwave-define-abbrev "dec" "device, decompose=0" (idlwave-keyword-abbrev 0))
            (idlwave-define-abbrev "sj" "strjoin()" (idlwave-keyword-abbrev 1))
            (idlwave-define-abbrev "fi" "for i=0,n_elements()-1 do" (idlwave-keyword-abbrev 4))
            (idlwave-define-abbrev "fun"  "" (idlwave-code-abbrev idlwave-mn-function))
            (idlwave-define-abbrev "pro"  "" (idlwave-code-abbrev idlwave-mn-procedure))
            ))

(defun idlwave-mn-procedure ()
  (interactive)
  (idlwave-template
   (idlwave-rw-case "pro")
   (idlwave-rw-case "\ncompile_opt idl2, strictArrSubs\n\nend")
   "Procedure name"))

(defun idlwave-mn-function ()
  (interactive)
  (idlwave-template
   (idlwave-rw-case "function")
   (idlwave-rw-case "\ncompile_opt idl2, strictArrSubs\n\nreturn, \nend")
   "Function name"))

(add-hook 'idlwave-shell-mode-hook
          (lambda ()
            ;; A cheat for quick function-only lookup in the shell.
            (local-set-key "\M-\t"
                           '(lambda ()
                              (interactive)
                              (idlwave-complete 3)))
            (local-set-key [f5] 'idlwave-shell-break-here)
            (local-set-key [f6] 'idlwave-shell-clear-current-bp)
            (local-set-key [f7] 'idlwave-shell-cont)
            (local-set-key [f8] 'idlwave-shell-clear-all-bp)
            (setq
             ;; The best of both worlds: arrows move up and down, or
             ;; recall history if on the command line.
             idlwave-shell-arrows-do-history 'cmdline
             idlwave-shell-overlay-arrow "=>")

            (idlwave-define-abbrev "rs" ".reset_session" (idlwave-keyword-abbrev 0))

            (define-key (current-local-map) "\C-a" 'comint-bol)
            (define-key (current-local-map) [kp-multiply]  'comint-bol)

            ;; Some custom examines and other bindings
            (idlwave-shell-define-key-both
             [s-down-mouse-2]
             (idlwave-shell-mouse-examine "print, size(___,/DIMENSIONS)"))
            (idlwave-shell-define-key-both
             [f9] (idlwave-shell-examine "print, size(___,/DIMENSIONS)"))
            (idlwave-shell-define-key-both
             [f10] (idlwave-shell-examine "print,size(___,/TNAME)"))
            (idlwave-shell-define-key-both
             [f11] (idlwave-shell-examine "help,___,/STRUCTURE"))
            (idlwave-shell-define-key-both
             [f4] 'idlwave-shell-retall)
            (idlwave-shell-define-key-both
             [f3] (lambda () (interactive)
                    (idlwave-shell-send-command
                     "__wa=widget_info(/managed) & for i=0,n_elements(__wa)-1 do widget_control,__wa[i], /clear_events" nil 'hide)
                    (idlwave-shell-retall)))
            (local-set-key
             [f5]
             '(lambda () (interactive)
                (insert "n_elements()") (backward-char)))
            (define-key (current-local-map)
              [f6]
                        '(lambda () (interactive)
                           (insert "size()") (backward-char)))
            (define-key (current-local-map)
              [f8]
              '(lambda () (interactive)
                 (insert "__define"))))
          )


(defun idlwave-default-insert-timestamp ()
  "Default timestamp insertion function."
  (insert (current-time-string))
  (insert ", USER: " (user-full-name))
  ;; Remove extra spaces from line
  (idlwave-fill-paragraph)
  ;; Insert a blank line comment to separate from the date entry -
  ;; will keep the entry from flowing onto date line if re-filled.
  (insert "\n;\n;\t\t")
)

;;(defvar user-mail-address "me@machine")
(setq user-mail-address "...")
(setq user-full-name "Maxim Neumann")
(setq user-full-name "mn")

(defvar idlwave-file-header
  (list nil
        ";+
; NAME:
;
; PURPOSE:
;
; CATEGORY:
; CALLING SEQUENCE:
;
; INPUTS:
; OPTIONAL INPUTS:
; KEYWORD PARAMETERS:
; OUTPUTS:
; OPTIONAL OUTPUTS:
; COMMON BLOCKS:
; SIDE EFFECTS:
; PROCEDURE:
; EXAMPLE:
; MODIFICATION HISTORY:
;
;-
")
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;        IIII  DDDD  LLLL   ---    WWW  AAA  VVV  EEE      ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; emacs_idl.el ends here
