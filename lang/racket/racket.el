;;; private/mdssjc/lang/racket/racket.el -*- lexical-binding: t; -*-

(def-package! racket-mode
  :mode "\\.rkt$"
  :interpreter "racket"
  :config
  (require 'racket-unicode-input-method)
  (add-hook! racket-mode
    #'(;; Internals
       racket-unicode-input-method-enable
       ;; 3rd-party functionality
       lispy-mode
       ;; fontification
       rainbow-delimiters-mode
       highlight-quoted-mode
       highlight-numbers-mode
       flycheck-mode))

  (add-hook! racket-mode
    (setq-local racket-smart-open-bracket-enable t))

  (add-hook! racket-mode
    (setq-local company-frontends `(company-pseudo-tooltip-unless-just-one-frontend
                                    company-preview-if-just-one-frontend
                                    company-preview-common-frontend
                                    ,(when company-quickhelp-mode
                                       'company-quickhelp-frontend))))

  (add-hook! racket-mode
    (setq-local company-backends '((company-capf
                                    company-abbrev
                                    company-dabbrev-code
                                    company-dabbrev
                                    company-files))))

  (set! :popup  "^\\*racket-repl" nil '((quit) (select)))
  (set! :repl   'racket-mode #'racket-repl)
  (set! :eval   'racket-mode #'racket-send-region)
  (set! :lookup 'racket-mode
    :definition    #'racket-describe
    :documentation #'racket-doc)
  ;; (set! :company-backend 'racket-mode '(company-capf
  ;;                                       company-abbrev
  ;;                                       company-dabbrev-code
  ;;                                       company-dabbrev
  ;;                                       company-files))
  (set! :docset '(racket-mode racket-mode) "Racket")
  (set! :rotate 'racket-mode
    :symbols '(("#true" "#false")))

  (map! :map racket-mode-map
        :localleader
        :n "C-c C-c"     #'racket-run
        :n "C-c C-k"     #'racket-run
        :n "C-c C-z"     #'racket-repl
        :n "<f5>"        #'racket-run-and-switch-to-repl
        :n "M-C-<f5>"    #'racket-racket
        :n "C-<f5>"      #'racket-test
        :n "C-c C-t"     #'racket-test
        :n "C-c C-l"     #'racket-logger
        :n "C-c C-o"     #'racket-profile
        :n "M-C-x"       #'racket-send-definition
        :n "C-x C-e"     #'racket-send-last-sexp
        :n "C-c C-r"     #'racket-send-region
        :n "C-c C-e x"   #'racket-expand-definition
        :n "C-c C-e e"   #'racket-expand-last-sexp
        :n "C-c C-e r"   #'racket-expand-region
        :n "C-c C-e a"   #'racket-expand-again
        :n "C-c C-x C-f" #'racket-open-require-path
        :n "TAB"         #'indent-for-tab-command
        :n "M-C-u"       #'racket-backward-up-list
        :n "["           #'racket-smart-open-bracket
        :n ")"           #'racket-insert-closing
        :n "]"           #'racket-insert-closing
        :n "}"           #'racket-insert-closing
        :n "C-c C-p"     #'racket-cycle-paren-shapes
        :n "M-C-y"       #'racket-insert-lambda
        :n "C-c C-d"     #'racket-doc
        :n "C-c C-."     #'racket-describe
        :n "M-."         #'racket-visit-definition
        :n "M-C-."       #'racket-visit-module
        :n "M-,"         #'racket-unvisit
        :n "C-c C-f"     #'racket-fold-all-tests
        :n "C-c C-u"     #'racket-unfold-all-tests
        :n "a"           #'racket-align
        :n "A"           #'racket-unalign))
