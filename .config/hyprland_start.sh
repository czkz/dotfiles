export XDG_CONFIG_HOME="$HOME/.config"
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=wayfire
export XDG_CURRENT_DESKTOP=wayfire

export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_QPA_PLATFORM="wayland;xcb"
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

export CLUTTER_BACKEND=wayland
export SDL_VIDEODRIVER=wayland # Arch wiki says it may break old games
export _JAVA_AWT_WM_NONEREPARENTING=1 # Set to 1 until Wakefield is available
export GDK_BACKEND="wayland,x11"
# xi glfw-wayland
export WLR_NO_HARDWARE_CURSORS=1 # Suppresses a warning in wayfire output
export MOZ_ENABLE_WAYLAND=1 # For Firefox

dbus-launch --exit-with-session Hyprland
pkill -9 xdg-document-po
pkill pipewire
pkill pipewire-pulse
