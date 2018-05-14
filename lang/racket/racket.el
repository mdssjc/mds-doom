;;; lang/racket/racket.el -*- lexical-binding: t; -*-

(def-package! racket-mode
  :mode "\\.rkt$"
  :interpreter "racket"
  :config
  (require 'racket-unicode-input-method)

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

  (add-hook! racket-mode
    #'(;; Internals
       racket-unicode-input-method-enable
       ;; 3rd-party functionality
       lispy-mode
       doom|enable-delete-trailing-whitespace
       ;; fontification
       rainbow-delimiters-mode
       highlight-quoted-mode
       highlight-numbers-mode
       flycheck-mode))

  (add-hook! racket-mode
    (setq-local racket-smart-open-bracket-enable t))

  (add-hook! racket-mode
    (progn
      (setq-local company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
                                      company-preview-if-just-one-frontend
                                      company-preview-common-frontend))
      (when (fboundp 'company-quickhelp-mode)
        (progn
          (company-quickhelp-local-mode)
          (setq-local company-quickhelp-delay     0.25)
          (setq-local company-quickhelp-max-lines 30)))))

  (add-hook! racket-mode
    (setq-local company-backends '((company-capf
                                    company-abbrev
                                    company-dabbrev-code
                                    company-dabbrev
                                    company-files))))

  (map! :map racket-mode-map
        :localleader
        :n "c"   #'racket-run
        :n "z"   #'racket-repl
        :n "r"   #'racket-run-and-switch-to-repl
        :n "R"   #'racket-racket
        :n "t"   #'racket-test
        :n "l"   #'racket-logger
        :n "o"   #'racket-profile
        :n "s d" #'racket-send-definition
        :n "s l" #'racket-send-last-sexp
        :n "s r" #'racket-send-region
        :n "e d" #'racket-expand-definition
        :n "e l" #'racket-expand-last-sexp
        :n "e r" #'racket-expand-region
        :n "e a" #'racket-expand-again
        :n "P"   #'racket-open-require-path
        :n "TAB" #'indent-for-tab-command
        :n "u"   #'racket-backward-up-list
        :n "["   #'racket-smart-open-bracket
        :n ")"   #'racket-insert-closing
        :n "]"   #'racket-insert-closing
        :n "}"   #'racket-insert-closing
        :n "p"   #'racket-cycle-paren-shapes
        :n "y"   #'racket-insert-lambda
        :n "d"   #'racket-doc
        :n "."   #'racket-describe
        :n "M-." #'racket-visit-definition
        :n "C-." #'racket-visit-module
        :n ","   #'racket-unvisit
        :n "f"   #'racket-fold-all-tests
        :n "F"   #'racket-unfold-all-tests
        :n "a"   #'racket-align
        :n "A"   #'racket-unalign))
