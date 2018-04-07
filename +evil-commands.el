;;; private/mdssjc/+evil-commands.el -*- lexical-binding: t; -*-

(defalias 'ex! 'evil-ex-define-cmd)

(ex! "qr" #'restart-emacs)
