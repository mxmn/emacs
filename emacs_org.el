;;; emacs_org.el --- Summary
;;;
;;; Commentary:
;;;
;;; org-mode configuration.
;;;
;;; Changelog:
;;;
;;; 02/2016 - major rewrite of the org configuration
;;; ...
;;; 10/2009 - started
;;;

;; ;;
;; ;; mnx, 2/18/16 -- removed!
;; ;;
;; ;; provide org-mode path & load org-checklist
;; (add-to-list 'load-path "~/conf/emacs_old/org/lisp")
;; (load "~/conf/emacs_old/org/contrib/lisp/org-checklist")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;              org mode (mn 16.09.09)                ;;;
;;;              org mode (mn  1/11/10)                ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Code:


;;;; Init

;(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\)$" . org-mode))
;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
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

;; Turn on flyspell mode
;(add-hook 'org-mode-hook
;          (lambda ()
;            (flyspell-mode 1)))
;from http://www.newartisans.com/2007/08/using-org-mode-as-a-day-planner.html
(custom-set-variables
 '(org-agenda-ndays 7)
 '(org-deadline-warning-days 14)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-reverse-note-order t))
; '(org-fast-tag-selection-single-key (quote expert))


;;; Refiling!
; Use IDO for target completion
(setq org-completion-use-ido t)
; Targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5))))
;(setq org-refile-targets (quote (("~/documents/org/planner.org") (nil :maxlevel . 5))))
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
        ; ("X" "Xtest" todo  "DONE" ((org-agenda-todo-ignore-with-date t)))
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
;;;                                      (tags-todo "+project+work")
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
;; (global-set-key (kbd "C-M-r") 'org-remember)
(global-set-key (kbd "C-M-r") 'org-capture)
(define-key global-map "\C-cc" 'org-capture)

;; C-c C-c stores the note immediately
;; (setq org-remember-store-without-prompt t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;      REMEMBER       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(add-to-list 'load-path "~/LibraryPreferences/Aquamacs Emacs/remember-2.0")
;(require 'remember)

;(org-remember-insinuate)
;; (setq remember-annotation-functions '(org-remember-annotation))
;; (setq remember-handler-functions '(org-remember-handler))
;; (add-hook 'remember-mode-hook 'org-remember-apply-template)







;; Start clock if a remember buffer includes :CLOCK-IN:
;; (add-hook 'remember-mode-hook 'my-start-clock-if-needed 'append)
;; (defun my-start-clock-if-needed ()
;;   (save-excursion
;;     (goto-char (point-min))
;;     (when (re-search-forward " *:CLOCK-IN: *" nil t)
;;       (replace-match "")
;;       (org-clock-in))))
;; I use C-M-r to start org-remember
;; (global-set-key (kbd "C-M-r") 'org-remember)
;; (define-key global-map "\C-cr" 'org-remember)
;; (global-set-key (kbd "<f12>") 'org-agenda)
;; Keep clocks running
;; (setq org-remember-clock-out-on-exit nil)
;; C-c C-c stores the note immediately
;; (setq org-remember-store-without-prompt t)
;; (setq org-remember-templates
;;   '(
;;          ("Refile" ?r "* TODO %?\n  %U" org-default-notes-file "Refile")
;;          ("Task" ?t "* TODO %? %^g\n  %U" org-default-notes-file "Tasks")
;;          ("Next" ?x "* NEXT %? %^g\n  %U" org-default-notes-file "Tasks")
;;          ("Calendar" ?c "* %?\n  %U" org-default-notes-file "Calendar")
;;          ("Journal" ?j "* %U %?\n" (concat my-org-path "journal.org" "Journal")
;;          ("Dnevnik" ?d "* %U %?\n" (concat my-org-path "journal.org" "Dnevnik")
;;          ("Idea" ?i "* %U %?\n" (concat my-org-path "research.org" "Ideas")
;;          ("Someday" ?s "* TODO %?\n  %U" org-default-notes-file "Someday")
;;          ("Work" ?w "* TODO %? :work:\n  %U" org-default-notes-file "Tasks")
;;          ("Home" ?h "* TODO %? :home:\n  %U" org-default-notes-file "Tasks")
;;          ("General" ?g "* TODO %? :general:\n  %U" org-default-notes-file "Tasks")
;;          ("Quote" ?q "* %?\n %U" (concat my-org-path "journal.org" "Quotations")
;;          ))

;;;;;;;;;;;;;;;;;;;;  finish  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;              org mode (mn 16.09.09)                ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;; Misc


;;; recent additions (1/11/10)
;;; from http://members.optusnet.com.au/~charles57/GTD/mydotemacs.txt
(setq org-use-fast-todo-selection t)

;;; custom functions
(defun gtd-folders ()
    (interactive)
    (find-file (concat my-org-path "folders.org"))
)
(global-set-key (kbd "C-c f") 'gtd-folders)
(defun gtd-projects ()
    (interactive)
    (find-file (concat my-org-path "projects.org"))
)
(global-set-key (kbd "C-c p") 'gtd-projects)
(defun gtd-amzn ()
    (interactive)
    (find-file (concat my-org-path "amzn.org"))
)
(global-set-key (kbd "C-c m") 'gtd-amzn)
(defun gtd-research ()
    (interactive)
    (find-file (concat my-org-path "research.org"))
)
(global-set-key (kbd "C-c r") 'gtd-research)
(defun gtd-journal ()
    (interactive)
    (find-file (concat my-org-path "journal.org"))
)
(global-set-key (kbd "C-c j") 'gtd-journal)
;;(defun gtd-someday ()
;;    (interactive)
;;    (find-file (concat my-org-path "someday.org")
;;)
;;(global-set-key (kbd "C-c s") 'gtd-someday)

;;;Highlight the agenda line under cursor
(add-hook 'org-agenda-mode-hook  '(lambda () (hl-line-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; recent additions (1/16/10)
;;; from file:///Users/mneumann/Dropbox/docs/sites/08org-mode.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;clocking
;; Change task state to STARTED from TODO when clocking in
(defun bh/clock-in-to-started (kw)
  "Switch task from TODO to STARTED when clocking in"
  (if (and (string-equal kw "TODO")
           (not (string-equal (buffer-name) "*Remember*")))
      "STARTED"
    nil))
(setq org-clock-in-switch-to-state (quote bh/clock-in-to-started))

;;;;;;;remember
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

;;;;;;;refile  -- i'm not really using this feature anymore, mn, 5/10/12
; Use IDO for target completion
(setq org-completion-use-ido t)

; Targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets
                (quote(
                                 (org-agenda-files :maxlevel . 5)
;;;                      ("~/Documents/docs/org/someday.org" :maxlevel . 5)
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


;;; mn, 5/10/12
;(setq org-startup-folded t)
;org-completion-use-ido
; org-return-follows-link
; org-todo-keywords
; org-todo-keyword-faces
; org-enforce-todo-dependencies
; org-enforce-todo-checkbox-dependencies

;;(setq org-todo-keywords
;;              '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED")))
(setq org-todo-keywords
                '((sequence "TODO(t)" "PROJ(p)" "STARTED(s)" "NEXT(x)" "|" "DONE(d)" "CANCELLED(c)" "DEFERRED(f)")))

;; mn, 5/18/12
;; use speed-commands in all .org files (as in the agenda), type ? in front of *
(setq org-use-speed-commands t)




;;;; latex

(require 'ox-latex)
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))


;;; addtional latex classes - mn, 5/14/12
;; My custom LaTeX class for Org-mode export. require is needed for it to work.
;; (require 'org-latex)


;; (require 'org-latex)
;; (unless (boundp 'org-export-latex-classes)
;;   (setq org-export-latex-classes nil))




(add-to-list 'org-latex-classes
             '("notes"
"\\documentclass[letter,9pt]{article}
\\usepackage[utf8]{inputenc}
\\usepackage{lmodern}
\\usepackage[T1]{fontenc}
\\usepackage{fixltx2e}
\\usepackage{cite}
\\usepackage{amsmath,amsthm}
\\usepackage{amssymb}
\\usepackage{daytime}
\\usepackage[scale={0.9}]{geometry}

\\input{mathdefs}
\\author{mxn}
\\newcommand\\foo{bar}"
;;               [DEFAULT-PACKAGES]
;;               [NO-PACKAGES]
;;               [EXTRA]"

;;               [NO-DEFAULT-PACKAGES]
;;               [NO-PACKAGES]
;;               [EXTRA]"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; Somebodys custom  class for Org-mode export.
(add-to-list 'org-latex-classes
             '("mybeamer"
               "\\documentclass[presentation]{beamer}
               \\usepackage{...}
               [NO-DEFAULT-PACKAGES]
               [NO-PACKAGES]
               [EXTRA]
               [BEAMER-HEADER-EXTRA]"
               org-beamer-sectioning))

;; Somebodys letter class, for formal letters
(add-to-list 'org-latex-classes
                                 '("letter"
     "\\documentclass[9pt]{letter}\n
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage[scale={0.9}]{geometry}\n
      \\usepackage{color}
      \\author{mxn2}
"

     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))




;;;; web-sites


;; web-sites with org ;; mn, 5/18/12
;; (require 'org-publish)

(setq org-publish-project-alist
      '(
;;; dynamics - process to html
        ("jorg-notes"
         :base-directory "~/docs/sites/jorg/org/"
;;                      :base-directory (file-truename
;;                                                                (expand-file-name "~/docs/sites/jorg/org/"))
         :publishing-directory "~/docs/sites/jorg/public_html/"
         :base-extension "org"
         :exclude "org_hdr_level*"
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         )
;;; static - just copy
        ("jorg-static"
         :base-directory "~/docs/sites/jorg/org/"
;;                      :base-directory (file-truename
;;                                                                (expand-file-name "~/docs/sites/jorg/org/"))
         :publishing-directory "~/Dropbox/docs/sites/jorg/public_html/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :recursive t
         :publishing-function org-publish-attachment
         )
;;; publish both (dynamic org-notes, and static org-static)
        ("jorg" :components ("jorg-notes" "jorg-static"))
        ))

;; C-x C-e  -- executes the last list statement (in emacs conf files)

;; Now M-x org-publish-project RET org RET publishes everything
;; recursively to ~/public_html/.
;; Target directories are created, if they don't yet exist.

;;(setq x  (file-truename (expand-file-name "~/docs/sites/jorg/org/")))

;;; emacs_org.el ends here
