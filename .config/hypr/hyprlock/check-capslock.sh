#!/bin/bash
if grep -q 1 /sys/class/leds/input*::capslock/brightness 2>/dev/null; then
    echo "CAPS LOCK ON"
fi
