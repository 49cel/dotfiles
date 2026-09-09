#!/bin/bash
STATEDIR="/tmp/hypr-transparency"
mkdir -p "$STATEDIR"

WINDOW_JSON=$(hyprctl activewindow -j)
CLASS=$(echo "$WINDOW_JSON" | jq -r '.class')

[ "$CLASS" != "org.pwmt.zathura" ] && exit 0

ADDR=$(echo "$WINDOW_JSON" | jq -r '.address')
[ "$ADDR" = "null" ] || [ -z "$ADDR" ] && exit 1

STATEFILE="$STATEDIR/$ADDR"

if [ -f "$STATEFILE" ]; then
    hyprctl eval "hl.dsp.window.set_prop({prop = 'alpha', value = 1.0, window = 'address:$ADDR'})"
    rm "$STATEFILE"
else
    hyprctl eval "hl.dsp.window.set_prop({prop = 'alpha', value = 0.75, window = 'address:$ADDR'})"
    touch "$STATEFILE"
fi
