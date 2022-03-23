# Installation
No installation scripts; just get all this to be in ~.

See `Dotfiles management` in .bashrc on how
to do it using a bare git repository.

# What to have/expect
- Linux
- Bash
  - Simple bashrc
  - Minimalistic PS1
  - Better Ctrl+R
  - Colors
- Vim
  - Thoroughly documented vimrc
  - Few breaking changes
  - Simple installation (see vimrc)
  - Linting + completion
  - Simple Build-and-Run key

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
