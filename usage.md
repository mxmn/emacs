
### Projectile Default Interactive Commands

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