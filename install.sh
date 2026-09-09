#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

backup() {
    local target="$1"
    if [ -e "$target" ] || [ -L "$target" ]; then
        mkdir -p "$BACKUP_DIR/$(dirname "$target" | sed "s|$HOME/||")"
        mv "$target" "$BACKUP_DIR/$(echo "$target" | sed "s|$HOME/||")"
        echo "  backed up: $target"
    fi
}

link() {
    local src="$1" dst="$2"
    backup "$dst"
    mkdir -p "$(dirname "$dst")"
    ln -sf "$src" "$dst"
    echo "  linked: $dst -> $src"
}

echo "==> Installing packages"
if command -v pacman &>/dev/null; then
    echo "  Installing official packages..."
    sudo pacman -S --needed - < "$DOTFILES/pkglist/pacman.txt"

    if command -v yay &>/dev/null; then
        echo "  Installing AUR packages..."
        yay -S --needed - < "$DOTFILES/pkglist/aur.txt"
    else
        echo "  WARNING: yay not found, skipping AUR packages"
        echo "  Install yay first: https://github.com/Jguer/yay"
    fi
fi

echo ""
echo "==> Linking dotfiles (existing files backed up to $BACKUP_DIR)"

# Home directory dotfiles
for f in .zshrc .zprofile .bashrc .bash_profile .bash_logout .profile .p10k.zsh .gtkrc-2.0 .fonts.conf .npmrc .nvidia-settings-rc .gitconfig; do
    [ -f "$DOTFILES/$f" ] && link "$DOTFILES/$f" "$HOME/$f"
done

# .config directories
for dir in "$DOTFILES"/.config/*/; do
    dirname="$(basename "$dir")"
    link "$DOTFILES/.config/$dirname" "$HOME/.config/$dirname"
done

# .config standalone files
for f in "$DOTFILES"/.config/*; do
    [ -f "$f" ] && link "$f" "$HOME/.config/$(basename "$f")"
done

# .local/bin scripts
mkdir -p "$HOME/.local/bin"
for f in "$DOTFILES"/.local/bin/*; do
    link "$f" "$HOME/.local/bin/$(basename "$f")"
done

# .local/share/applications
mkdir -p "$HOME/.local/share/applications"
for f in "$DOTFILES"/.local/share/applications/*.desktop; do
    [ -f "$f" ] && link "$f" "$HOME/.local/share/applications/$(basename "$f")"
done

echo ""
echo "==> Enabling systemd user services"
systemctl --user daemon-reload
systemctl --user enable --now patch-caelestia-scheme.path 2>/dev/null || true
systemctl --user enable --now sddm-wallpaper-sync.service 2>/dev/null || true

echo ""
echo "==> Done!"
echo ""
echo "Post-install steps:"
echo "  1. Log out and back in (or restart Hyprland) for all changes to take effect"
echo "  2. Run 'nvim' to let lazy.nvim install plugins"
echo "  3. Install GTK/icon themes (see README.md)"
