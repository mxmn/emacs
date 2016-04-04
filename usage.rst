General keybindings (default and customized)
````````````````````````````````````````````

==========  ==============================
Keybinding  Description
==========  ==============================
C-'         Indent buffer
C-c n e     Start eshell
C-c n b     Start bash
C-c n i     Open emacs' init.el
==========  ==============================


Python anaconda-mode
````````````````````

==========  ==============================
Keybinding  Description
==========  ==============================
C-M-i       anaconda-mode-complete
M-.         anaconda-mode-find-definitions
M-,         anaconda-mode-find-assignments
M-r         anaconda-mode-find-references
M-*         anaconda-mode-go-back
M-?         anaconda-mode-show-doc
==========  ==============================


Helm-projectile-mode
````````````````````

==========  ==============================
Keybinding  Description
==========  ==============================
C-c p h     Switch to file, buffer, project
C-c p p     Switch projects
C-c p f     Find file in project
C-c p s g   Grep in project. When a symbol is at point, it is used to start the search.
            Can use a region as well.
==========  ==============================

Probably in all helm find-file/switch-buffer commands:
- C-spc : mark current file(s)
- M-a   : mark all files
- C-s   : grep on all marked file(s)


=========== =========================================== ==========================
Key Binding Command                                     Description
=========== =========================================== ==========================
C-c p h     helm-projectile                             Helm interface to projectile
C-c p p     helm-projectile-switch-project              Switches to another projectile project
C-c p f     helm-projectile-find-file                   Lists all files in a project
C-c p F     helm-projectile-find-file-in-known-projects Find file in all known projects
C-c p g     helm-projectile-find-file-dwim              Find file based on context at point
C-c p d     helm-projectile-find-dir                    Lists available directories in current project
C-c p e     helm-projectile-recentf                     Lists recently opened files in current project
C-c p a     helm-projectile-find-other-file             Switch between files with same name but different extensions
C-c p i     projectile-invalidate-cache                 Invalidate cache
C-c p z     projectile-cache-current-file               Add the file of current selected buffer to cache
C-c p b     helm-projectile-switch-to-buffer            List all open buffers in current project
C-c p s g   helm-projectile-grep                        Searches for symbol starting from project root
C-c p s a   helm-projectile-ack                         Same as above but using ack
C-c p s s   helm-projectile-ag                          Same as above but using ag
=========== =========================================== ==========================




Search and Replace and Misc
```````````````````````````

Grep File(s) (C-s; add prefix C-u for recursive grep): grep current highlighted file or marked files. With prefix C-u, recursively grep parent directories of marked files. Remember, it only works on marked files, or the current file the highlight bar is on.

Zgrep (M-g z; add prefix C-u for recursive zgrep): Similar to grep but invokes grep on compressed or gzipped files.

Locate (C-x C-f, add C-u to specify locate db): Search using locate, the same as helm-locate.

Insert as org link (C-c @): Insert the current file that highlight bar is on as an Org link.

Ediff File (C-=): If only a file is marked (that is the line your Helm highlight bar is on), it prompts for another file to compare. If two files are marked, starts an Ediff session between two files. More than two files are marked, you are prompted for another file to compare again.

- helm-projectile info & tutorial: http://tuhdo.github.io/helm-projectile.html
