export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CURRENT_DESKTOP=wayfire # Needed in xdg_desktop_portal_wlr for screensharing
export QT_QPA_PLATFORM=wayland
export CLUTTER_BACKEND=wayland
export SDL_VIDEODRIVER=wayland # Arch wiki says it may break old games
# xi glfw-wayland
export WLR_NO_HARDWARE_CURSORS=1 # Suppresses a warning in wayfire output
export MOZ_ENABLE_WAYLAND=1 # For Firefox

dbus-launch --exit-with-session wayfire
pkill -9 xdg-document-po
pkill pipewire
pkill pipewire-pulse
