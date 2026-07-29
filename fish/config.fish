if status is-interactive
    # Commands to run in interactive sessions can go here
    #eza 
    alias ls="eza --icons=auto --group-directories-first"
    alias ll="eza -lh --icons=auto --git --group-directories-first"
    alias la="eza -lah --icons=auto --git --group-directories-first"
    alias lt="eza --tree --level=2 --icons=auto"
end

set -gx ANDROID_HOME $HOME/Android/Sdk
set -gx ANDROID_SDK_ROOT $ANDROID_HOME

fish_add_path $ANDROID_HOME/platform-tools
fish_add_path $ANDROID_HOME/emulator

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"
