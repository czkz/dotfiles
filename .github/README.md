# Installation
No installation scripts; just get all this to be in ~.

See `Dotfiles management` in .bashrc on how
to do it using a bare git repository.

# What to expect
- [vimrc](/.vimrc)
  - Written from scratch
  - Thoroughly documented
  - Few breaking changes
  - Simple installation (see [vimrc](/.vimrc))
  - Linting + completion
  - Build-and-Run key
- [bashrc](/.bashrc)
  - Minimalistic PS1
  - Better Ctrl+R
  - Colors
- [mpv.conf](/.config/mpv/mpv.conf)
  - Configured to also work as an image viewer
  - Battery saving mode (default)
    - 6 times less CPU usage than default mpv / browser
    - Needs vaapi for hardware acceleration
  - High quality "slow" profile (disabled by default)
    - Mostly used to hide compression artifacts on 1080p youtube videos
    - Additional sharpening on Ctrl+7 and Ctrl+0

# Used on:
- Void Linux + GNOME + X11/Wayland + Desktop/Laptop

# Running Wayfire version
Although mostly used on GNOME, there are enough config files
for running WayfireWM on top of seatd and pipewire.
1. Install Void Linux musl
2. Install packages from .config/xbps-packages/wayfire
   - `xargs -a ~/.config/xbps-packages/wayfire sudo xbps-install`
3. Add seatd to /var/service
   - `ln -s /etc/sv/seatd /var/service`
   - Minimal `/var/service` would then be `agetty-tty1 dhcpcd udevd seatd`
4. Add user to groups `audio`, `video`, `_seatd`
   - auxillary groups will then be `wheel audio video _seatd`
5. Copy or symlink a wallpaper to ~/.config/wallpaper
6. `ln -s /usr/bin/yt-dlp /usr/local/bin/youtube-dl`
7. Start wayfire with `~/.config/wayfire_start.sh`


# License

The BSD Zero Clause License (0BSD)

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
