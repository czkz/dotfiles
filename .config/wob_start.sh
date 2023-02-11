#!/usr/bin/env sh
WOBSOCK=${WOBSOCK:-"$XDG_RUNTIME_DIR/wob.sock"}
[ -r "$WOBSOCK" ] && rm "$WOBSOCK"
mkfifo "$WOBSOCK" || exit 1
trap 'rm "$WOBSOCK"' EXIT
exec tail -f "$WOBSOCK" | wob
