# Arch Linux dotfiles

Current X11 setup: LightDM, i3, Alacritty, keyd, and IBus Unikey.

`.Xmodmap` and `awesome/` are retained as historical references. They are not
part of the current setup.

## Packages

```bash
sudo pacman -S --needed $(<packages.txt)
```

## User configuration

Link or copy these files to their matching locations:

| Repository | Destination |
| --- | --- |
| `.bash_profile` | `~/.bash_profile` |
| `.bashrc` | `~/.bashrc` |
| `.xprofile` | `~/.xprofile` |
| `.xinitrc` | `~/.xinitrc` |
| `alacritty/alacritty.toml` | `~/.config/alacritty/alacritty.toml` |
| `i3/config` | `~/.config/i3/config` |
| `bin/ibus-toggle-vn` | `~/.local/bin/ibus-toggle-vn` |

Restore IBus settings:

```bash
dconf load /desktop/ibus/ < ibus/settings.dconf
```

## keyd

Copy `keyd/*.conf` and `keyd/common.map` to `/etc/keyd/`, then validate and
restart the service:

```bash
sudo keyd check
sudo systemctl enable --now keyd
sudo systemctl restart keyd
```

keyd replaces the active Caps Lock/Escape and Tab/Left Control remapping.
Xmodmap is not loaded by the current setup.

## Machine-local configuration

Keep host-specific environment variables in `~/.bashrc.local`. The tracked
`.bashrc` loads it when present.

Keep SSH hosts in `~/.ssh/config` instead of shell aliases:

```sshconfig
Host example
    HostName host.example.com
    User username
```
