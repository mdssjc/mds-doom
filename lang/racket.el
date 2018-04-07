;;; ~/.config/doom/mdssjc/lang/racket.el -*- lexical-binding: t; -*-

(def-package! racket-mode
  :mode "\\.rkt$"
  :interpreter "racket"
  :config
  (add-hook! 'racket-mode-hook
    (setq company-frontends `(company-pseudo-tooltip-unless-just-one-frontend
                              company-preview-if-just-one-frontend
                              company-preview-common-frontend
                              ,(when company-quickhelp-mode
                                 'company-quickhelp-frontend))))
  (add-hook! 'racket-mode-hook
    #'(;; 3rd-party functionality
       lispy-mode
       ;; fontification
       rainbow-delimiters-mode
       highlight-quoted-mode
       highlight-numbers-mode))
  (add-hook 'racket-mode-hook
            (lambda ()
              (setq-local racket-smart-open-bracket-enable t)
              (setq-local company-backends '((company-capf
                                              company-abbrev
                                              company-dabbrev-code
                                              company-dabbrev
                                              company-files))))))
