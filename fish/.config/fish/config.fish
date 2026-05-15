if status is-interactive
    # Commands to run in interactive sessions can go here
    # ~/.config/fish/config.fish

    # eza aliases
    alias ls="eza --icons"
    alias ll="eza -lh --icons --git"
    alias la="eza -lha --icons --git"
    alias lt="eza --tree --level=2 --icons"
    alias l.="eza -d .* --icons"

    # Better defaults
    set -gx EZA_COLORS "di=34:ln=36:ex=32"

    # Useful shortcuts
    alias cat="bat"
    alias grep="rg"

    # emacs
    alias em="emacs -nw"
end

