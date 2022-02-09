#!/usr/bin/env sh
[ $# -ne 1 ] && echo "usage: $0 <sink|source>" && exit 1
WOBSOCK=${WOBSOCK:-"$XDG_RUNTIME_DIR/wob.sock"}
TARGET=$1  # sink | source
ID=$(pactl get-default-$TARGET)
MUTE_MLT=$(pactl get-$TARGET-mute $ID | awk "/yes/{ print 0 } /no/{ print 1 }")
pactl get-$TARGET-volume $ID | awk '/^Volume:/{ print ($5 + $12) / 2 * '$MUTE_MLT'}' > "$WOBSOCK"
