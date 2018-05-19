;;; private/mdssjc/ui/modeline.el -*- lexical-binding: t; -*-


;; Modeline

(def-modeline-segment! langtool
  (when (boundp 'langtool-mode-line-message)
    langtool-mode-line-message))

(def-modeline-segment! org-pomodoro
  (when (boundp 'org-pomodoro-mode-line)
    org-pomodoro-mode-line))

(def-modeline! main
  (bar matches " " buffer-info "  %l:%c %p  " org-pomodoro langtool selection-info)
  (buffer-encoding major-mode vcs flycheck))



;; ---



;; Headerline

;; (defun timer-info ()
;;   '(:propertize
;;     (:eval (format-time-string "%H:%M"))
;;     help-echo (concat (format-time-string "%c; ")
;;                       (emacs-uptime "Uptime:%hh"))))

;; (defun header-line-show ()
;;   (setq header-line-format
;;         '(" "
;;           (:eval (propertize " " 'display
;;                              `((space :align-to (-  (+ ,(window-width) 2)
;;                                                     ,(+ 1 (string-width "##:## ")))))))
;;           (:eval (timer-info)))))

;; (run-with-timer 10 60 'header-line-show)
