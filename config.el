;;; ~/.config/doom/mdssjc/config.el -*- lexical-binding: t; -*-


;;
;; Plugins
;;
(def-package! restart-emacs
  :commands restart-emacs)

(def-package! ivy
  :config
  (setq ivy-count-format "(%d/%d) "))

(def-package! ivy-rich
  :after ivy
  :config
  (setq ivy-use-virtual-buffers t
        ivy-rich-path-style 'abbrev))

(def-package! avy
  :commands (avy-goto-char-2
             avy-goto-line
             avy-goto-char-timer
             avy-goto-line-above
             avy-goto-line-below
             avy-goto-char-in-line
             avy-goto-char-in-line-left
             avy-goto-char-in-line-right)
  :config
  (setq avy-all-windows nil
        avy-background  t))

(def-package! rg
  :commands (rg-dwim rg-kill-saved-searches rg-list-searches rg-project
                     rg rg-save-search rg-save-search-as-name rg-literal)
  :config
  (setq rg-group-result t
        rg-show-columns t))

(def-package! ripgrep
  :commands (ripgrep-regexp))

(def-package! lispy
  :commands (lispy-mode)
  :init
  (add-hook 'minibuffer-setup-hook
            (lambda () (when (eq this-command 'eval-expression)
                    (lispy-mode 1)))))

(def-package! lispyville
  :commands (lispyville-mode)
  :config
  (add-hook! 'lispy-mode-hook 'lispyville-mode))

(def-package! evil-string-inflection)

(def-package! highlight-thing
  :commands (highlight-thing-mode)
  :init
  (add-hook! 'prog-mode-hook 'highlight-thing-mode)
  :config
  (setq highlight-thing-delay-seconds 0
        highlight-thing-exclude-thing-under-point t
        highlight-thing-case-sensitive-p t)
  (set-face-attribute 'highlight-thing nil
                      :foreground "gold"
                      ;:background (doom-color 'bg)
                      :background "#282c34"))

(def-package! multiple-cursors
  :commands (multiple-cursors-mode mc/add-cursor-on-click mc/mark-next-like-this
             mc/mark-previous-like-this mc/mark-next-like-this-symbol
             mc/mark-previous-like-this-symbol mc/mark-all-dwim mc/mark-all-in-region-regexp)
  :config
  (multiple-cursors-mode))

(def-package! ialign
  :commands ialign)

(def-package! org-pomodoro
  :commands org-pomodoro)

(def-package! move-dup
  :commands md/move-lines-up md/move-lines-down md/duplicate-up md/duplicate-down)

; Clojure
(after! cider
  (setq nrepl-log-messages t
        cider-repl-display-in-current-window t
        cider-repl-use-clojure-font-lock t
        cider-repl-pop-to-buffer-on-connect nil
        cider-repl-history-file (concat user-emacs-directory ".local/cache/cider/history-repl")
        cider-prompt-save-file-on-load 'always-save
        cider-font-lock-dynamically '(macro core function var)
        nrepl-hide-special-buffers t
        cider-overlays-use-font-lock t
        cider-eval-result-prefix ";; => "
        cider-lein-command "~/.sdkman/candidates/leiningen/current/bin/lein")
  (cider-repl-toggle-pretty-printing)
  ;; (set! :env "LEIN_HOME")
  )

(def-package! clojure-snippets
  :after clojure-mode)

(def-package! cakecrumbs
  :config
  (cakecrumbs-auto-setup))

;; ---



;;
;; Config
;;

;; General
(load! lang/racket)
;; (load! ui/modeline)
(load! +bindings)
(load! +evil-commands)

;; Syntatic
(add-hook! company-mode
  (setq company-idle-delay 0
        company-minimum-prefix-length 1
        company-show-numbers t
        company-selection-wrap-around t

        ;; company quickhelp
        company-quickhelp-delay     0.25
        company-quickhelp-max-lines 30))

(def-package! ispell
  ;; :commands (company-ispell)
  :config
  (cond ((executable-find "hunspell")
         (setq ispell-program-name "hunspell"
               ispell-really-hunspell t))
        ((executable-find "aspell")
         (setq ispell-program-name "aspell"
               ispell-really-aspell t
               ispell-extra-args '("--sug-mode=ultra"))))
  (setq ispell-list-command "--list"
        ispell-look-p nil
        ispell-grep-command "rg"
        ispell-grep-options "-i"
        ispell-dictionary   "pt_BR"
        ispell-choices-win-default-height 5
        ispell-lazy-highlight nil)
  (ispell-pt-br))
;; ---

;; Semantic
(def-package! google-this
  :commands (google-this-mode
             google-this-search
             google-this-region
             google-this
             google-this-noconfirm
             google-this-lucky-search
             google-this-lucky-and-insert-url
             google-this-word
             google-this-symbol
             google-this-line
             google-this-error
             google-this-forecast
             google-this-cpp-reference
             google-this-maps
             google-this-ray
             google-maps
             google-this-translate-query-or-region))

(def-package! google-translate
  :commands (google-translate-at-point
             google-translate-smooth-translate
             google-translate-query-translate)
  :config
  (setq google-translate-show-phonetic t))
;; ---

(add-hook! 'rg-mode-hook         'wgrep-setup)
(add-hook! 'emacs-lisp-mode-hook 'lispy-mode)
(add-hook! 'clojure-mode-hook    'lispy-mode)

(after! magit
  (setq magit-diff-refine-hunk 'all))

;; TODO: melhorar o emacs-lisp

(after! org
  (progn
    (setq org-todo-keywords '((sequence "TODO(t)" "DOING(d)" "BLOCKED(b)" "REVIEW(r)"
                                        "|" "DONE(e)" "ARCHIVED(a)" "CANCELED(c)"))
          org-todo-keyword-faces '(("TODO"     . org-warning)
                                   ("DOING"    . "yellow")
                                   ("BLOCKED"  . "red")
                                   ("REVIEW"   . "orange")
                                   ("DONE"     . "green")
                                   ("ARCHIVED" . "blue")
                                   ("CANCELED" . "red1"))
          org-pretty-entities t
          org-hide-emphasis-markers t
          ;; Agenda
          org-agenda-files (list "~/Documents/GTD/someday-maybe.org"
                                 "~/Documents/GTD/calendar.org"
                                 "~/Documents/GTD/projects.org")
          org-agenda-custom-commands '(("W" "Weekly Review"
                                        ((agenda "" ((org-agenda-ndays 7)))
                                         (stuck "")
                                         (todo "DOING")
                                         (org-agenda-entry-types '(:deadline))
                                         (org-deadline-warning-days 30))))
          ;; Refile
          org-refile-use-outline-path 'file
          org-outline-path-complete-in-steps nil
          org-refile-allow-creating-parent-nodes 'confirm
          completing-read-function 'ivy-completing-read
          org-refile-targets '(("~/Documents/GTD/trash.org"         :maxlevel . 1)
                               ("~/Documents/GTD/someday-maybe.org" :maxlevel . 1)
                               ("~/Documents/GTD/reference.org"     :maxlevel . 1)
                               ("~/Documents/GTD/projects.org"      :maxlevel . 3)
                               ("~/Documents/GTD/next-action.org"   :maxlevel . 2)
                               ("~/Documents/GTD/waiting-for.org"   :maxlevel . 1))
          ;; Templates - Capture
          org-capture-templates '(("n" "Notes" entry
                                   (file+headline +org-default-notes-file "Notes")
                                   "* %i%?"
                                   :prepend t :kill-buffer t)
                                  ("t" "Inbox" entry
                                   (file+headline "~/Documents/GTD/inbox.org" "Things")
                                   "* %i%?\nCreate in %U"
                                   :prepend t :kill-buffer t)))
    ;; Encrypt all entries before saving
    ;; (org-crypt-use-before-save-magic)
    ;; (setq org-tags-exclude-from-inheritance '("crypt"))
    ;; (let ((secrets-path "~/.config/doom/modules/private/mdssjc/secrets/secrets.el"))
    ;;   (if (file-exists-p secrets-path)
    ;;       (progn (load secrets-path)
    ;;              ;; GPG key to use for encryption
    ;;              (setq org-crypt-key user-password))
    ;;     (message "Use mds-secrets-template.el as the basis for the secrets.el file.")))
    ))