#!/usr/bin/env sh
WOBSOCK=${WOBSOCK:-"$XDG_RUNTIME_DIR/wob.sock"}
mkfifo "$WOBSOCK" || exit 1
trap 'rm "$WOBSOCK"' EXIT
exec tail --follow=name "$WOBSOCK" | wob \
    --anchor bottom \
    --width 600 \
    --height 30 \
    --offset 0 \
    --border 1 \
    --padding 2 \
    --margin 200 \
    --border-color \#0496FFFF \
    --background-color \#000000EE \
    --bar-color \#C5C8C6FF
