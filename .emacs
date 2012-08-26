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
(column-number-mode t)

; remove splash screen
(setq inhibit-splash-screen t)

; font
(set-default-font "Inconsolata-11")
(setq default-frame-alist '((font . "Inconsolata-11")))

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
(global-unset-key (kbd "<left>"))
(global-unset-key (kbd "<right>"))
(global-unset-key (kbd "<up>"))
(global-unset-key (kbd "<down>"))

(global-unset-key (kbd "C-<left>"))
(global-unset-key (kbd "C-<right>"))
(global-unset-key (kbd "C-<up>"))
(global-unset-key (kbd "C-<down>"))

(global-unset-key (kbd "M-<left>"))
(global-unset-key (kbd "M-<right>"))
(global-unset-key (kbd "M-<up>"))
(global-unset-key (kbd "M-<down>"))

; rebind C-a to 'back-to-indentation'
(global-set-key "\C-a" 'back-to-indentation)

; don't let next-line add new lines at end of file
(setq next-line-add-newlines nil)

; make edited files end with a carriage return
(setq require-final-newline t)

; remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; ido mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

; any key deletes selection
(delete-selection-mode)

; highlight matching parens
(show-paren-mode 1)
(setq show-paren-delay 0)

; kill-ring length
(setq kill-ring-max 500)
