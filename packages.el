;; -*- no-byte-compile: t; -*-
;;; private/mdssjc/packages.el

(package! rg)
(package! ripgrep)
(package! lispy)
(package! lispyville)
(package! evil-string-inflection)
(package! highlight-thing)
(package! multiple-cursors)
(package! org-pomodoro)
(package! move-dup)
(package! google-this)
(package! google-translate)
(package! clojure-snippets)
(package! ialign)
(package! cakecrumbs)
(package! emacs-snippets
  :recipe (:fetcher github
                    :repo "hlissner/emacs-snippets"
                    :files ("*")))
(package! prescient
  :recipe (:fetcher github
                    :repo "raxod502/prescient.el"
                    :files ("*")))
