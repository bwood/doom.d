;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Brian Wood"
      user-mail-address "bwood@berkeley.edu")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one-light)

;;;;;;;;;;;;;;;;;
;;;; Orgmode ;;;;
;;;;;;;;;;;;;;;;;
(setq org-directory "~/Documents/orgmode2")

;; Capture templates
(setq org-capture-templates
       `(("i" "Inbox" entry  (file "inbox.org")
        ,(concat "* TODO %?\n"
                 "/Entered on/ %U"))))

(map! :leader
      :desc "Org capture"
      "c" #'org-capture)

;;;; Agenda
(after! org
  (setq org-agenda-files (append (file-expand-wildcards "~/Documents/orgmode2/*.org")))
  (setq org-todo-keywords
       '((sequence "TODO(t)" "INPROG(i)" "TESTING(s)" "WAITING(w)" "BLOCKED(b)" "|" "DONE(d)" "WONTFIX(x)" ))))


;;;; Clocktable
(load! "bdw/clocktable-flat.el")

;;
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Make option keys act as meta.
;; https://github.com/hlissner/doom-emacs/issues/3952#issuecomment-718393737
(cond (IS-MAC
       (setq mac-option-modifier       'meta
             mac-right-option-modifier 'meta)))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; Time tracking codes for WPS
(load! "bdw/wps-time-tracking.el")

;; Projectile
;;
(setq projectile-project-search-path '("~/code/" "~/Sites" "~/.doom.d"))

;; Exporters
(use-package! ox-jira
  :after org)

;;;; Deft ;;;;
;; https://jblevins.org/projects/deft
(use-package deft
;TODO this bind yeilds a syntax error
;  :bind (("C-c d" . deft)
;         ("C-c D" . deft-new-file-named))
  :commands (deft)
  :config (setq deft-directory "/Volumes/GoogleDrive/My Drive/Documents/orgmode/deft"
                deft-extensions '("org" "md")
                deft-default-extension "org"))

;; load personal modules
;; (load! "+ejira")
