;;; config.el -*- lexical-binding: t; -*-

;; Identity
(setq user-full-name "Likhith Reddy"
      user-mail-address "slikhithreddy22@gmail.com")

;; Theme + UI
(setq doom-theme 'doom-one)
(setq display-line-numbers-type 'relative)
(setq doom-font (font-spec :family "Mononoki Nerd Font" :size 14))

;; Cursor shape in terminal
(add-hook 'evil-insert-state-entry-hook
          (lambda () (send-string-to-terminal "\e[5 q")))
(add-hook 'evil-insert-state-exit-hook
          (lambda () (send-string-to-terminal "\e[2 q")))

;; Corfu auto-completion
(after! corfu
  (setq corfu-auto t
        corfu-auto-delay 0.2
        corfu-auto-prefix 1))

;; Eglot language servers
(after! eglot
  (add-to-list 'eglot-server-programs
               '(python-mode . ("pyright-langserver" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(python-ts-mode . ("pyright-langserver" "--stdio"))))

;; ──────────────────────────────────────────
;; ORG MODE
;; ──────────────────────────────────────────
(setq org-directory "~/org/")

(after! org
  (setq org-agenda-files
        (directory-files-recursively "~/org/" "\\.org$"))
  (setq org-archive-location "~/org/archive/%s_archive::datetree/")
  (setq org-todo-keywords
        '((sequence "TODO(t)" "IN-PROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
  (setq org-capture-templates
        '(("t" "Task" entry
           (file "~/org/tasks.org")
           "* TODO %?\nCREATED: %U\n")
          ("p" "Project Idea" entry
           (file "~/org/projects/startup-ideas.org")
           "* %?\nCREATED: %U\n")
          ("j" "Journal" entry
           (file+olp+datetree "~/org/journal/journal.org")
           "* %?\n%U\n")))
  (setq org-ellipsis " ▾"
        org-hide-emphasis-markers t
        org-src-fontify-natively t
        org-src-tab-acts-natively t))

;; Priority
(setq org-priority-highest ?A
      org-priority-lowest ?C
      org-priority-faces
      '((?A . (:foreground "red"    :weight bold))
        (?B . (:foreground "orange" :weight bold))
        (?C . (:foreground "yellow" :weight bold))))

;; Org bullets
(add-hook 'org-mode-hook #'org-bullets-mode)
(setq org-bullets-bullet-list '("◉" "○" "✸" "✿"))

;; Fancy priorities
(use-package! org-fancy-priorities
  :hook (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("🔥" "⬆" "⬇")))

;; ──────────────────────────────────────────
;; GIT
;; ──────────────────────────────────────────
(after! magit
  (setq magit-display-buffer-function
        #'magit-display-buffer-same-window-except-diff-v1))

;; ──────────────────────────────────────────
;; GO
;; ──────────────────────────────────────────
(after! go-mode
  (add-hook 'go-mode-hook
            (lambda ()
              (add-hook 'before-save-hook #'eglot-format-buffer t t))))

;; ──────────────────────────────────────────
;; EVIL
;; ──────────────────────────────────────────
(after! evil
  (setq evil-escape-key-sequence "jk"
        evil-escape-delay 0.3))

;; ──────────────────────────────────────────
;; KEYBINDS
;; ──────────────────────────────────────────
(map! :leader
      :desc "Agenda"        "o a" #'org-agenda
      :desc "Capture"       "o c" #'org-capture
      :desc "Journal"       "o j" #'(lambda () (interactive)
                                      (find-file "~/org/journal/journal.org"))
      :desc "Tasks"         "o t" #'(lambda () (interactive)
                                      (find-file "~/org/tasks.org"))
      :desc "Open terminal" "o e" #'vterm)

(global-set-key (kbd "C-a") #'mark-whole-buffer)

(setq markdown-command "pandoc")
