;; -*- lexical-binding: t; no-byte-compile: t; -*-
;;; lang/racket/doctor.el

;; FIXME: corrigir as mensagens...

(unless (executable-find "drracket")
  (warn! "Could not find drracket executable; code-completion, syntax checking and jump-to-definition functionality will be disabled."))

(unless (executable-find "racket")
  (warn! "Could not find racket executable; build commands will be disabled."))

(unless (executable-find "raco")
  (warn! "Could not find raco executable; build commands will be disabled."))
