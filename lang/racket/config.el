;;; lang/racket/config.el -*- lexical-binding: t; -*-

(def-package! racket-mode
  :mode "\\.rkt$"
  :interpreter "racket"
  :config
  (set-popup-rule! "*Racket REPL*"
    '((size . 10))
    '((select . t) (modeline . nil) (quit . t) (transient . 3)))
  (set-repl-handler! 'racket-mode #'+racket/repl)
  (set-eval-handler! 'racket-mode "racket")
  (set-lookup-handlers! 'racket-mode
                        :definition    #'racket-describe
                        :documentation #'racket-doc)
  (set-docset! 'racket-mode "Racket")
  (set-pretty-symbols!  'racket-mode :lambda "lambda")
  (set-rotate-patterns! 'racket-mode
    :symbols '(("#true" "#false")))
  (set-company-backend! 'racket-mode '(company-abbrev
                                       company-dabbrev-code
                                       company-dabbrev
                                       company-files))

  (add-hook! racket-mode
    #'(;; Internals
       racket-unicode-input-method-enable
       ;; 3rd-party functionality
       doom|enable-delete-trailing-whitespace
       ;; fontification
       rainbow-delimiters-mode
       highlight-quoted-mode
       highlight-numbers-mode
       ;; initialization
       flycheck-mode))

  ;; (add-hook racket-repl-mode-hook #'racket-unicode-input-method-enable)

  (add-hook! racket-mode
    (setq-local racket-smart-open-bracket-enable t)
    (setq-local company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
                                    company-preview-if-just-one-frontend
                                    company-preview-common-frontend)))

  (map! :map racket-mode-map
        :localleader
        :n "c"   #'racket-run
        :n "z"   #'racket-repl
        :n "C"   #'racket-run-and-switch-to-repl
        :n "x"   #'racket-racket
        :n "t"   #'racket-test
        :n "l"   #'racket-logger
        :n "o"   #'racket-profile
        (:desc "eval" :prefix "s"
          :n "d" #'racket-send-definition
          :n "l" #'racket-send-last-sexp
          :n "r" #'racket-send-region)
        (:desc "macro expand" :prefix "e"
          :n "d" #'racket-expand-definition
          :n "l" #'racket-expand-last-sexp
          :n "r" #'racket-expand-region
          :n "a" #'racket-expand-again)
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
        :n "A"   #'racket-unalign
        :nv ";"  #'comment-dwim
        :nv "\\" #'indent-region))


;;
;; Plugins
;;

(def-package! highlight-quoted
  :commands highlight-quoted-mode)

(after! org
    (org-babel-do-load-languages
     'org-babel-load-languages
     (append org-babel-load-languages
             '((racket   . t)
               ;; (scribble . t)
               ))))
