; backup files
(setq
   backup-by-copying t ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacs.d/backups")) ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t) ; use versioned backups

; autosave
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/autosaves/\\1" t)))

; spaces for indentation
(setq-default indent-tabs-mode nil
              tab-width 4)

; auto indentation
(define-key global-map (kbd "RET") 'newline-and-indent)

; line numbers
(global-linum-mode 1)

; column number in status bar
(setq column-number-mode t)

; remove splash screen
(setq inhibit-splash-screen t)

; font
(set-default-font "Inconsolata-12")

; packages archives
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

; load external packages
(package-initialize)

; load theme
(load-theme 'solarized-dark t)

; system copy and paste
(setq x-select-enable-clipboard t)

; hide toolbar
(tool-bar-mode -1)

; hide scroll bars
(scroll-bar-mode -1)

; disable arrow keys
(defun  disabled-key ()
  "Assign this to disable a key"
  (interactive)
  (print "All your arrow keys are belong to me. Have a nice day!"))

(global-set-key (kbd "<up>")      'disabled-key)
(global-set-key (kbd "<down>")    'disabled-key)
(global-set-key (kbd "<left>")    'disabled-key)
(global-set-key (kbd "<right>")   'disabled-key)
(global-set-key (kbd "<C-up>")      'disabled-key)
(global-set-key (kbd "<C-down>")    'disabled-key)
(global-set-key (kbd "<C-left>")    'disabled-key)
(global-set-key (kbd "<C-right>")   'disabled-key)
