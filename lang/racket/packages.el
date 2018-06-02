;; -*- no-byte-compile: t; -*-
;;; lang/racket/packages.el

;;; requires racket drracket raco

(package! racket-mode)
(package! highlight-quoted)
(package! rainbow-delimiters)
(package! ob-racket
  :recipe (:fetcher github
                    :repo "DEADB17/ob-racket"
                    :files ("*")))
