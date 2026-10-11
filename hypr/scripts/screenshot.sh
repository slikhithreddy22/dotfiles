#!/usr/bin/env bash

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

FILENAME="$DIR/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png"

case "$1" in
    area)
        GEOM=$(slurp)
        [ -z "$GEOM" ] && exit 0
        grim -g "$GEOM" "$FILENAME"
        ;;
    screen)
        grim "$FILENAME"
        ;;
    *)
        echo "Usage: $0 [area|screen]"
        exit 1
        ;;
esac

if [ -f "$FILENAME" ]; then
    wl-copy < "$FILENAME"
    notify-send -i "$FILENAME" "Screenshot Saved" "Saved to Pictures/Screenshots and copied to clipboard"
fi
