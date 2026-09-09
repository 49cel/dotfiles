#!/usr/bin/env bash
WALLPAPER_STATE="$HOME/.local/state/caelestia/wallpaper"
SDDM_DEST="/usr/share/sddm/themes/glass/backgrounds/wallpaper.jpg"

sync_wallpaper() {
    local src
    src=$(readlink -f "$WALLPAPER_STATE/current" 2>/dev/null)
    if [[ -f "$src" ]]; then
        sudo cp "$src" "$SDDM_DEST"
    fi
}

sync_wallpaper

inotifywait -m -e create,moved_to,attrib "$WALLPAPER_STATE" --include 'current' |
while read -r _dir _event _file; do
    sleep 0.5
    sync_wallpaper
done
