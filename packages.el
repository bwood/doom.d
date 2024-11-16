;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)

;; https://github.com/stig/ox-jira.el
;; Provides export to jira functionality
(package! ox-jira)

;; My fork of org-mode to provide clocktable-flat functionality
;; We can't just use :recpie(:local-repo) because Doom needs to do some post-install compilation for
;; org-mode.  See: https://github.com/doomemacs/doomemacs/blob/develop/modules/lang/org/packages.el#L17-L29
;; (package! org-mode
;;   :recipe (:host github
;;            :repo "bwood/org-mode"
;;            :branch "9.6-bed47b437"
;;            :build t
;;            :pre-build
;;            (with-temp-file "org-version.el"
;;              (let ((version
;;                     (with-temp-buffer
;;                       (insert-file-contents (doom-path "lisp/org.el") nil 0 1024)
;;                       (if (re-search-forward "^;; Version: \\([^\n-]+\\)" nil t)
;;                           (match-string-no-properties 1)
;;                         "Unknown"))))
;;                (insert (format "(defun org-release () %S)\n" version)
;;                        (format "(defun org-git-version (&rest _) \"%s-??-%s\")\n"
;;                                version (cdr (doom-call-process "git" "rev-parse" "--short" "HEAD")))
;;                        "(provide 'org-version)\n")))))


;; Fix magit
;; https://github.com/doomemacs/doomemacs/issues/5435
;;(package! magit-section)
;;(package! magit-base)

;; OpenSCAD
(package! scad-mode)

;; imenu-list. A sidebar for function navigation.
(package! imenu-list)
;; imenu-anywhere an extension to search across multiple buffers.
(package! imenu-anywhere)
