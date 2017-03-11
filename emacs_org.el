;;; emacs_org.el --- Emacs configuration
;;
;;; Commentary:
;;
;; org-mode configuration.
;;
;; Author: Maxim Neumann
;;
;;; Changelog:
;;
;; 02/2016 - major rewrite of the org configuration
;; ...
;; 10/2009 - started
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


;;;; Init

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\)$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-log-done t)

;; my-org-path is defined in emacs_personal.el
(setq org-directory my-org-path)

(setq org-agenda-files (list (concat my-org-path "folders.org")
                             (concat my-org-path "projects.org")
                             (concat my-org-path "amzn.org")
;;                           (concat my-org-path "someday.org")
                             (concat my-org-path "journal.org")
))
(setq org-default-notes-file (concat my-org-path "folders.org"))

;from http://www.newartisans.com/2007/08/using-org-mode-as-a-day-planner.html
(custom-set-variables
 '(org-agenda-ndays 7)
 '(org-deadline-warning-days 14)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-reverse-note-order t))


;;; Refiling!
; Use IDO for target completion
(setq org-completion-use-ido t)
; Targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5))))
; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))
; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)



;;;; Agenda

(setq org-agenda-todo-ignore-deadlines t)
(setq org-agenda-todo-ignore-scheduled t)
(setq org-agenda-todo-ignore-with-date t)


(setq org-agenda-custom-commands
      (quote
       (("S" "Started Tasks" todo "STARTED" ((org-agenda-todo-ignore-with-date nil)))
        ("D" "Done Tasks" todo "DONE|CANCELLED|DEFERRED")
        ; ("w" "Tasks waiting on something" tags "WAITING/!" ((org-use-tag-inheritance nil)))
        ("R" "Refile Tasks" tags "LEVEL=2+refile" ((org-agenda-todo-ignore-with-date nil)))
        ; ("n" "Next" tags "NEXT-WAITING-CANCELLED/!" nil)
        ("P" "All Projects" tags "+project"
         ((org-agenda-todo-ignore-with-date nil)
          (org-agenda-todo-ignore-deadlines nil)
          (org-agenda-todo-ignore-scheduled nil)))
        ("p" "Work Projects" tags-todo "+project+work"
         ((org-agenda-todo-ignore-with-date nil)
          (org-agenda-todo-ignore-deadlines nil)
          (org-agenda-todo-ignore-scheduled nil)))
        ("s" "Scheduling: Work and Home Lists"
         ((agenda "" ((org-deadline-warning-days 10)))
          ;;                                       (tags-todo "NEXT")
          (todo "NEXT"
                ((org-agenda-todo-ignore-with-date 1)
                 (org-agenda-todo-ignore-deadlines 1)
                 (org-agenda-todo-ignore-scheduled 1)))
          (todo "STARTED"
                ((org-agenda-todo-ignore-with-date nil)
                 (org-agenda-todo-ignore-deadlines nil)
                 (org-agenda-todo-ignore-scheduled nil)))
          (tags-todo "+work-project")
          (tags-todo "project")
          (tags-todo "general")
          (tags-todo "home|finance"
                     ((org-agenda-todo-ignore-with-date t)))
          (tags-todo "-work-project-home-general-finance")
          (tags-todo "someday")
          (todo "DEFERRED"
                ((org-agenda-todo-ignore-with-date nil)
                 (org-agenda-todo-ignore-deadlines nil)
                 (org-agenda-todo-ignore-scheduled nil)))
          ))
        ("d" "Daily Action List"
         ((agenda "" ((org-agenda-ndays 1)
                      (org-agenda-sorting-strategy
                       (quote ((agenda time-up priority-down tag-up) )))
                      (org-deadline-warning-days 0)
                      ))))
        ))
      )


;;;; org-capture

(setq org-capture-templates
      '(("r" "Refile" entry (file+headline org-default-notes-file "Refile")
         "* TODO %?\n  %U" :prepend t)
        ("t" "Task" entry (file+headline org-default-notes-file "Tasks")
         "* TODO %? %^g\n  %U" :prepend t)
        ("x" "Next" entry (file+headline org-default-notes-file "Tasks")
         "* NEXT %? %^g\n  %U" :prepend t)
        ("c" "Calendar" entry (file+headline org-default-notes-file "Calendar")
         "* %?\n  %U" :prepend t)
        ("j" "Journal" entry (file+headline (concat my-org-path "journal.org") "Journal")
         "* %U %?\n" :prepend t)
        ("d" "Dnevnik" entry (file+headline (concat my-org-path "journal.org") "Dnevnik") "* %U %?\n" :prepend t)
        ("i" "Idea" entry (file+headline (concat my-org-path "research.org") "Ideas") "* %U %?\n" :prepend t)
        ("s" "Someday" entry (file+headline org-default-notes-file "Someday") "* TODO %?\n  %U" :prepend t)
        ("w" "Work" entry (file+headline org-default-notes-file "Tasks") "* TODO %? :work:\n  %U" :prepend t)
        ("h" "Home" entry (file+headline org-default-notes-file "Tasks") "* TODO %? :home:\n  %U" :prepend t)
        ("g" "General" entry (file+headline org-default-notes-file "Tasks") "* TODO %? :general:\n  %U" :prepend t)
        ("q" "Quote" entry (file+headline (concat my-org-path "journal.org") "Quotations") "* %?\n %U" :prepend t)
        ))

(setq org-default-notes-file (concat org-directory "/notes.org"))
(global-set-key (kbd "C-M-r") 'org-capture)
(define-key global-map "\C-cc" 'org-capture)



;;;; Misc

;;; from http://members.optusnet.com.au/~charles57/GTD/mydotemacs.txt
(setq org-use-fast-todo-selection t)

;;; custom functions
(defun gtd-folders ()
    (interactive)
    (find-file (concat my-org-path "folders.org")))
(global-set-key (kbd "C-c f") 'gtd-folders)

(defun gtd-projects ()
    (interactive)
    (find-file (concat my-org-path "projects.org")))
;;(global-set-key (kbd "C-c p") 'gtd-projects) - used as projectile prefix
(global-set-key (kbd "C-c r") 'gtd-projects)

(defun gtd-amzn ()
    (interactive)
    (find-file (concat my-org-path "amzn.org")))
(global-set-key (kbd "C-c m") 'gtd-amzn)

;; (defun gtd-research ()
;;     (interactive)
;;     (find-file (concat my-org-path "research.org")))
;; (global-set-key (kbd "C-c r") 'gtd-research)

(defun gtd-journal ()
    (interactive)
    (find-file (concat my-org-path "journal.org")))
(global-set-key (kbd "C-c j") 'gtd-journal)


;;;Highlight the agenda line under cursor
(add-hook 'org-agenda-mode-hook  '(lambda () (hl-line-mode 1)))


;; from file:///Users/mneumann/Dropbox/docs/sites/08org-mode.html

;; clocking
;; Change task state to STARTED from TODO when clocking in
(defun bh/clock-in-to-started (kw)
  "Switch task from TODO to STARTED when clocking in"
  (if (and (string-equal kw "TODO")
           (not (string-equal (buffer-name) "*Remember*")))
      "STARTED"
    nil))
(setq org-clock-in-switch-to-state (quote bh/clock-in-to-started))

;; remember
;; Start clock in a remember buffer and switch back to previous clocking task on save
(add-hook 'remember-mode-hook 'org-clock-in 'append)
(add-hook 'org-remember-before-finalize-hook 'bh/clock-in-interrupted-task)
(defun bh/clock-in-interrupted-task ()
  "Clock in the interrupted task if there is one"
  (interactive)
  (if (and (not org-clock-resolving-clocks-due-to-idleness)
           (marker-buffer org-clock-marker)
           (marker-buffer org-clock-interrupted-task))
      (org-with-point-at org-clock-interrupted-task
        (org-clock-in nil))
    (org-clock-out)))

;; Keep clocks running
(setq org-remember-clock-out-on-exit nil)

;; refile  -- i'm not really using this feature anymore, mn, 5/10/12
;; Use IDO for target completion
(setq org-completion-use-ido t)

;; Targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets
                (quote(
                                 (org-agenda-files :maxlevel . 5)
                                 ((concat my-org-path "journal.org") :maxlevel . 5)
                                 (nil :maxlevel . 5))))

; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))

; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)


;;(setq org-todo-keywords
;;              '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED")))
(setq org-todo-keywords
                '((sequence "TODO(t)" "PROJ(p)" "STARTED(s)" "NEXT(x)" "|" "INFO(i)" "DONE(d)" "CANCELLED(c)" "DEFERRED(f)")))

;; mn, 5/18/12
;; use speed-commands in all .org files (as in the agenda), type ? in front of *
(setq org-use-speed-commands t)


;;;; latex
(require 'ox-latex)
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))

;; My custom LaTeX class for Org-mode export. require is needed for it to work.
(add-to-list 'org-latex-classes
             '("notes"
"\\documentclass[letter,9pt]{article}
[NO-DEFAULT-PACKAGES]
\\usepackage[utf8]{inputenc}
\\usepackage{lmodern}
\\usepackage[T1]{fontenc}
\\usepackage{fixltx2e}
\\usepackage{cite}
\\usepackage{amsmath,amsthm}
\\usepackage{amssymb}
\\usepackage{datetime}
\\usepackage{hyperref}
\\usepackage[scale={0.9}]{geometry}

% These lines makes lists work better:
% It eliminates whitespace before/within a list and pushes it tt the left margin
\\usepackage{enumitem}
\\setlist[enumerate,itemize]{noitemsep,nolistsep,leftmargin=*}

\\input{mathdefs}
% \\author{mn}
\\date{\\today, \\currenttime}
\\setlength{\\parindent}{0pt}
\\setlength{\\parskip}{4pt}
"
;;               [NO-EXTRA]
;;               [DEFAULT-PACKAGES]
;;               [EXTRA]"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; Somebody's custom  class for Org-mode export.
(add-to-list 'org-latex-classes
             '("mybeamer"
               "\\documentclass[presentation]{beamer}
               \\usepackage{...}
               [NO-DEFAULT-PACKAGES]
               [NO-PACKAGES]
               [EXTRA]
               [BEAMER-HEADER-EXTRA]"
               org-beamer-sectioning))

;; Somebody's letter class, for formal letters
(add-to-list 'org-latex-classes
                                 '("letter"
     "\\documentclass[9pt]{letter}\n
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage[scale={0.9}]{geometry}\n
      \\usepackage{color}
      \\author{mxn2}"
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(setq org-latex-default-class "notes")


;;;; latex updated for org-mode (3/11/17)

;;; http://www.clarkdonley.com/blog/2014-10-26-org-mode-and-writing-papers-some-tips.html
;;; http://www.draketo.de/english/emacs/writing-papers-in-org-mode-acpd
;; 1. hook flyspell into org-mode
(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'flyspell-buffer)
;; 2. Ignore message flags (every time an org file is opened)
(setq flyspell-issue-message-flag nil)
;; 3. ignore tex commands in spell checking
(add-hook 'org-mode-hook (lambda () (setq ispell-parser 'tex)))
(defun flyspell-ignore-tex ()
  (interactive)
  (set (make-variable-buffer-local 'ispell-parser) 'tex))
(add-hook 'org-mode-hook 'flyspell-ignore-tex)

;; using CD LaTeX to enter math - install cdlatex
;; https://www.gnu.org/software/emacs/manual/html_node/org/CDLaTeX-mode.html
;; C-c {  - insert environment
;; TAB    - expand latex command
;; _ or ^ - extend with braces in latex command
;; `      - math symbols/macros
;; '      - after a latex symbol, modifies font or accent
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

;;;http://www.draketo.de/english/emacs/writing-papers-in-org-mode-acpd
(require 'reftex-cite)
(setq reftex-default-bibliography '("/Users/maximn/sar/doc/bib/polinsar.bib"))
(defun org-mode-reftex-setup ()
  (interactive)
  (and (buffer-file-name) (file-exists-p (buffer-file-name))
       (progn
        ; Reftex should use the org file as master file. See C-h v TeX-master for infos.
        (setq TeX-master t)
        (turn-on-reftex)
        ; enable auto-revert-mode to update reftex when bibtex file changes on disk
        (global-auto-revert-mode t) ; careful: this can kill the undo
                                    ; history when you change the file
                                    ; on-disk.
        (reftex-parse-all)
        ; add a custom reftex cite format to insert links
        ; This also changes any call to org-citation!
        (reftex-set-cite-format
         '((?c . "\\citet{%l}") ; natbib inline text
           (?i . "\\citep{%l}") ; natbib with parens
           ))))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  (define-key org-mode-map (kbd "C-c (") 'org-mode-reftex-search))
(add-hook 'org-mode-hook 'org-mode-reftex-setup)


;;;; html

(setq my-org-html-path (concat my-org-path "html/"))

;;; emacs_org.el ends here
