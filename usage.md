## Selected Emacs Shortcuts/Commands to Master

### Top Non-Standard commands

Keybinding    | Description
--------------|-------------
M-o         | `other-window`, to replace C-x o
C-c C-l     | `goto-line`
C-M-=       | Increase font size
C-M--       | Decrease font size


#### Helm - Projectile - Company - Magit

Keybinding  | Action
------------|------------------------
C-c p h     | Helm projectile find file / project
C-c p r     | Projectile replace in all project files
C-c p p     | Projectile switch projects
C-i         | Helm I-Menu [rebinded]
C-o         | Helm occur (in file) [rebinded]


#### Flyckeck (including pylint)

Keybinding  | Action
------------|------------------------
C-c n n     | Flycheck goto next error [custom rebinded]
C-c n p     | Flycheck goto previous error [custom rebinded]
C-c n l     | Flycheck list errors



### Projectile Default Interactive Commands


Keybinding  | Action
------------|------------------------
C-c p f     | Find a file in the project
C-c p p     | Switch project
C-c p g     | Run grep on all files in the project
C-c p b     | Switch between buffers for the project
C-c p r     | Run query-replace for all files in the project (for refactoring)
C-c p k     | Kill all open buffers for the project


Here's a list of the interactive Emacs Lisp functions, provided by Projectile:

Keybinding         | Description
-------------------|------------------------------------------------------------
<kbd>C-c p f</kbd> | Display a list of all files in the project. With a prefix argument it will clear the cache first.
<kbd>C-c p F</kbd> | Display a list of all files in all known projects.
<kbd>C-c p g</kbd> | Display a list of all files at point in the project. With a prefix argument it will clear the cache first.
<kbd>C-c p 4 f</kbd> | Jump to a project's file using completion and show it in another window.
<kbd>C-c p 4 g</kbd> | Jump to a project's file based on context at point and show it in another window.
<kbd>C-c p d</kbd> | Display a list of all directories in the project. With a prefix argument it will clear the cache first.
<kbd>C-c p 4 d</kbd> | Switch to a project directory and show it in another window.
<kbd>C-c p 4 a</kbd> | Switch between files with the same name but different extensions in other window.
<kbd>C-c p T</kbd> | Display a list of all test files(specs, features, etc) in the project.
<kbd>C-c p l</kbd> | Display a list of all files in a directory (that's not necessarily a project)
<kbd>C-c p s g</kbd> | Run grep on the files in the project.
<kbd>M-- C-c p s g</kbd> | Run grep on `projectile-grep-default-files` in the project.
<kbd>C-c p v</kbd> | Run `vc-dir` on the root directory of the project.
<kbd>C-c p b</kbd> | Display a list of all project buffers currently open.
<kbd>C-c p 4 b</kbd> | Switch to a project buffer and show it in another window.
<kbd>C-c p 4 C-o</kbd> | Display a project buffer in another window without selecting it.
<kbd>C-c p a</kbd> | Switch between files with the same name but different extensions.
<kbd>C-c p o</kbd> | Runs `multi-occur` on all project buffers currently open.
<kbd>C-c p r</kbd> | Runs interactive query-replace on all files in the projects.
<kbd>C-c p i</kbd> | Invalidates the project cache (if existing).
<kbd>C-c p R</kbd> | Regenerates the projects `TAGS` file.
<kbd>C-c p j</kbd> | Find tag in project's `TAGS` file.
<kbd>C-c p k</kbd> | Kills all project buffers.
<kbd>C-c p D</kbd> | Opens the root of the project in `dired`.
<kbd>C-c p e</kbd> | Shows a list of recently visited project files.
<kbd>C-c p E</kbd> | Opens the `.dirs-local.el` file of the project.
<kbd>C-c p s s</kbd> | Runs `ag` on the project. Requires the presence of `ag.el`.
<kbd>C-c p !</kbd> | Runs `shell-command` in the root directory of the project.
<kbd>C-c p &</kbd> | Runs `async-shell-command` in the root directory of the project.
<kbd>C-c p c</kbd> | Runs a standard compilation command for your type of project.
<kbd>C-c p P</kbd> | Runs a standard test command for your type of project.
<kbd>C-c p t</kbd> | Toggle between an implementation file and its test file.
<kbd>C-c p 4 t</kbd> | Jump to implementation or test file in other window.
<kbd>C-c p z</kbd> | Adds the currently visited file to the cache.
<kbd>C-c p p</kbd> | Display a list of known projects you can switch to.
<kbd>C-c p S</kbd> | Save all project buffers.
<kbd>C-c p m</kbd> | Run the commander (an interface to run commands with a single key).
<kbd>C-c p ESC</kbd> | Switch to the most recently selected Projectile buffer.

If you ever forget any of Projectile's keybindings just do a:

<kbd>C-c p C-h</kbd>

You can change the default keymap prefix `C-c p` like this:

```el
(setq projectile-keymap-prefix (kbd "C-c C-p"))
```

It is also possible to add additional commands to
`projectile-command-map` referenced by the prefix key in
`projectile-mode-map`. You can even add an alternative prefix for all
commands. Here's an example that adds `super-p` as the extra prefix:

```el
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
```

You can also bind the `projectile-command-map` to any other map you'd
like (including the global keymap).  Prelude does this for its
[prelude-mode-map](https://github.com/bbatsov/prelude/blob/master/core/prelude-mode.el#L68).

For some common commands you might want to take a little shortcut and
leverage the fairly unused `Super` key (by default `Command` on Mac
keyboards and `Windows` on Win keyboards). Here's something you can
add to your Emacs config:

```el
(define-key projectile-mode-map [?\s-d] 'projectile-find-dir)
(define-key projectile-mode-map [?\s-p] 'projectile-switch-project)
(define-key projectile-mode-map [?\s-f] 'projectile-find-file)
(define-key projectile-mode-map [?\s-g] 'projectile-grep)
```

Note that the `Super` keybindings are not usable in Windows. Emacs
Prelude already adds those extra keybindings.


### Emacs Key Bindings
Based on the
[article])(https://www.masteringemacs.org/article/mastering-key-bindings-emacs)
by Mickey Petersen.

*Keymap* is an internal data structure to store keys and their
 associated actions. Every buffer and most major and minor modes have
 a keymap.

*Keys* can be divided into three categories: *undefined*, *prefix
 key*, and *complete key*.

To learn more about key bindings use `C-h m` to get all defined keys
bindings in the current buffer. Or, type a *prefix key*, followed by
`C-h` to get a list of all keys that belong to that
prefix. Alternatively, type first `C-h k` followed by your *complete
key* to get to know what it does.

Useful commands:

`(define-key KEYMAP KEY COMMAND)`: Define a key against a keymap of a major/minor mode. Keymap example: `python-mode-map`.

`(global-set-key KEY COMMAND)`: Binds a key to the global keymap.

`(global-unset-key KEY)`: removes KEY from the global keymap.

There are different ways to represent keys in code. Recommended (and
used by me) is using the built-in macro `kbd` that translates a human
readable key into a format Emacs can understand. Functions and
navigation keys have to be surrounded by `<` and `>`.

Examples: `(kbd "C-c p")`, or `(kbd "<f12>")`; `(kbd "C-<left>")`.

Modifier keys: Control: `C-`; Shift: `S-`; Meta: `M-`; Hyper: `H-`;
super: `s-` (lower-case-s).



#### Ideas for selected key rebindings from
[Mickey](https://www.masteringemacs.org/article/my-emacs-keybindings):

Key binding | Description
------------|-------------
`C-<return>`  | custom Helm command
`M-``        | Jump around in the mark ring
`C-=`         | bind to `cssh-term-remote-open` to open a remote host via ssh using `M-x ansi-term`
`M-n / M-p`   | smart scan next/previous commands
`S-C-<left/right/down/up>` | shrink/enlarge window horizontally/vertically
`F2`          | `M-x rgrep` -- very useful
 | `multi-occur-in-this-mode` - run `M-x occur` but against *all buffers* of the same major mode. Very useful.
 | `magit-status`
