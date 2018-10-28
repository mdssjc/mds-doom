;;; private/mdssjc/init.el -*- lexical-binding: t; -*-


(setq-default tab-always-indent 'complete
              indent-tabs-mode nil
              standard-indent 2
              tab-width       2
              c-basic-offset  2
              tab-stop-list '(2 4 6 8 10 12 14)

              indicate-buffer-boundaries 'right
              indicate-empty-lines       'indicate-buffer-boundaries)

;; Semantic
(def-package-hook! langtool
  :pre-config
  (setq langtool-default-language  "pt-BR"
        langtool-mother-tongue     "pt-BR"
        langtool-language-tool-jar "~/Documents/Git/languagetool/languagetool-standalone/target/LanguageTool-4.4-SNAPSHOT/LanguageTool-4.4-SNAPSHOT/languagetool-commandline.jar"
        langtool-autoshow-message-function (lambda (overlays)
                                             (when (require 'popup nil t)
                                               (unless (or popup-instances
                                                           (memq last-command '(keyboard-quit)))
                                                 (let ((msg (langtool-details-error-message overlays)))
                                                   (popup-tip msg))))))
  nil)
;; ---
