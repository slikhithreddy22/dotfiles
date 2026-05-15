;;; init.el -*- lexical-binding: t; -*-

(doom! :input

       :completion
       (corfu +orderless)
       vertico

       :ui
       doom
       dashboard
       hl-todo
       modeline
       ophints
       (popup +defaults)
       (vc-gutter +pretty)
       vi-tilde-fringe
       workspaces

       :editor
       (evil +everywhere)
       file-templates
       fold
       (format +onsave)
       snippets
       (whitespace +guess +trim)

       :emacs
       dired
       electric
       tramp
       undo
       vc

       :term
       vterm

       :checkers
       syntax

       :tools
       (eval +overlay)
       lookup
       (lsp +eglot)
       magit
       pdf
       tree-sitter

       :os
       tty

       :lang
       (cc +lsp +treesitter)
       emacs-lisp
       (go +lsp +treesitter)
       (java +lsp)
       markdown
       org
       (python +lsp +treesitter)
       (rust +lsp +treesitter)
       sh

       :config
       (default +bindings +smartparens))
