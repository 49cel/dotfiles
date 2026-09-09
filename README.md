# dotfiles

custom arch + caelestia rice

## System

- **WM:** Hyprland (via Caelestia)
- **Shell:** zsh (powerlevel10k) + fish
- **Terminal:** kitty, foot
- **Bar:** waybar
- **Widgets:** quickshell (illogical-impulse)
- **Launcher:** rofi, fuzzel
- **Notifications:** swaync, dunst
- **Editor:** neovim, micro
- **File Manager:** dolphin, thunar
- **Browser:** firefox (custom fontconfig)
- **Media:** mpv, cava, spicetify
- **Lock:** hyprlock, swaylock
- **Logout:** wlogout
- **Wallpaper:** waypaper, matugen (material-you colors)
- **Theming:** hyde wallbash, Kvantum, qt5ct/qt6ct, nwg-look
- **Fetch:** fastfetch
- **PDF:** zathura
- **Monitor:** btop

## Install

```bash
git clone https://github.com/pranavponnada/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The install script:
1. Installs all packages (pacman + AUR via yay)
2. Symlinks everything into place (backs up existing files)
3. Enables custom systemd user services

## GTK/Icon themes (not included — install separately)

### GTK Themes
Catppuccin-Latte, Catppuccin-Mocha, Decay-Green, Edge-Runner, Frosted-Glass,
Graphite-Mono, Gruvbox-Retro, Material-Sakura, Nordic-Blue, Rose-Pine,
Synth-Wave, Tokyo-Night, Wallbash-Gtk

### Icon Themes
BeautyLine, Bibata-Modern-Ice, Gruvbox-Plus-Dark, Gruvbox-Retro, Nordzy,
Tela-circle-black, Tela-circle-blue, Tela-circle-dracula, Tela-circle-green,
Tela-circle-grey, Tela-circle-pink, Tela-circle-purple, Tela-circle-yellow

## Structure

```
.config/
├── hypr/            # Hyprland + hyprlock + hypridle
├── caelestia/       # Caelestia shell config
├── waybar/          # Status bar
├── kitty/           # Terminal
├── foot/            # Terminal
├── rofi/            # App launcher
├── fuzzel/          # App launcher
├── dunst/           # Notifications
├── swaync/          # Notification center
├── quickshell/      # Desktop widgets (illogical-impulse)
├── nvim/            # Neovim
├── gtk-3.0/         # GTK3 theming
├── gtk-4.0/         # GTK4 theming
├── qt5ct/           # Qt5 theming
├── qt6ct/           # Qt6 theming
├── Kvantum/         # Qt theme engine
├── cava/            # Audio visualizer
├── btop/            # System monitor
├── fastfetch/       # System info
├── mpv/             # Media player
├── fish/            # Fish shell
├── zshrc.d/         # Zsh extra configs
├── matugen/         # Material-you color generation
├── hyde/            # HyDE theme manager
└── ...
.local/bin/          # Custom scripts
pkglist/             # Package lists (pacman + AUR)
```
