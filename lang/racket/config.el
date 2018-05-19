;;; lang/racket/config.el -*- lexical-binding: t; -*-

(def-package! racket-mode
  :mode "\\.rkt$"
  :interpreter "racket"
  :config
  (require 'racket-unicode-input-method)

  (set! :popup  "*Racket REPL*"
    '((size . 10))
    '((select . t) (modeline . nil) (quit . t) (transient . 3)))
  (set! :repl   'racket-mode #'+racket/repl)
  (set! :eval   'racket-mode "racket")
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
       doom|enable-delete-trailing-whitespace
       flycheck-mode
       ;; fontification
       rainbow-delimiters-mode
       highlight-quoted-mode
       highlight-numbers-mode))

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
                                    company-files
                                    company-yasnippet))))

  (map! :map racket-mode-map
        :localleader
        :n "c"   #'racket-run
        :n "z"   #'racket-repl
        :n "C"   #'racket-run-and-switch-to-repl
        :n "x"   #'racket-racket
        :n "t"   #'racket-test
        :n "l"   #'racket-logger
        :n "o"   #'racket-profile
        :n "sd"  #'racket-send-definition
        :n "sl"  #'racket-send-last-sexp
        :n "sr"  #'racket-send-region
        :n "ed"  #'racket-expand-definition
        :n "el"  #'racket-expand-last-sexp
        :n "er"  #'racket-expand-region
        :n "ea"  #'racket-expand-again
        :n "r"   #'racket-open-require-path
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


;;
;; Plugins
;;

(def-package! highlight-quoted
  :commands highlight-quoted-mode)
