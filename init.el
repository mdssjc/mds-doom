;;; ~/.config/doom/modules/private/mdssjc/init.el -*- lexical-binding: t; -*-


(setq-default tab-always-indent 'complete
              indent-tabs-mode nil
              standard-indent 2
              tab-width       2
              c-basic-offset  2
              tab-stop-list '(2 4 6 8 10 12 14)

              ;; FIXME: em testes
              indicate-buffer-boundaries 'right
              indicate-empty-lines       'indicate-buffer-boundaries)


;; FIXME: falhas no ivy-switch-buffer
;; (def-package-hook! ivy-rich
;;   :pre-config
;;   ;; (dolist (cmd '(+ivy/switch-workspace-buffer
;;   ;;                counsel-projectile-switch-to-buffer))
;;   ;;   (ivy-set-display-transformer cmd '+ivy-buffer-transformer))
;;   (ivy-set-display-transformer 'ivy-switch-buffer 'ivy-rich-switch-buffer-transformer)
;;   nil)



;; Syntatic
(def-package-hook! company
  :pre-init
  (global-company-mode)
  nil)
;; ---

;; Semantic
(def-package-hook! langtool
  :pre-config
  (setq langtool-language-tool-jar "~/Documents/Git/languagetool/languagetool-standalone/target/LanguageTool-4.2-SNAPSHOT/LanguageTool-4.2-SNAPSHOT/languagetool.jar"
        langtool-default-language  "pt-BR"
        langtool-mother-tongue     "pt-BR"
        langtool-autoshow-message-function
        (lambda (overlays)
          (when (require 'popup nil t)
            (unless (or popup-instances
                        (memq last-command '(keyboard-quit)))
              (let ((msg (langtool-details-error-message overlays)))
                (popup-tip msg))))))
  nil)
;; ---
