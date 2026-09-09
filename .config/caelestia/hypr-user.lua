-- Monitor: 3440x1440 ultrawide at full 180Hz refresh rate
hl.monitor({
    output   = "DP-5",
    mode     = "3440x1440@180",
    position = "0x0",
    scale    = 1,
})

-- NVIDIA env vars for smooth compositing
hl.env("NVD_BACKEND", "direct")
hl.env("QT_FFMPEG_DECODING_HW_DEVICE_TYPES", "none")

-- Performance and smoothness
hl.config({
    misc = {
        vrr                          = 0,
        animate_manual_resizes       = false,
        animate_mouse_windowdragging = false,
    },

    render = {
        direct_scanout = false,
    },

    cursor = {
        no_hardware_cursors = false,
    },

    general = {
        allow_tearing = true,
    },

    opengl = {
        nvidia_anti_flicker = true,
    },
})

-- Use hyprlock instead of Caelestia's built-in lock
hl.unbind("SUPER + L")
hl.bind("SUPER + L", hl.dsp.exec_cmd("pidof hyprlock || hyprlock"))

-- HyprDots animations
hl.curve("menu_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("menu_accel", { type = "bezier", points = { { 0.52, 0.03 }, { 0.72, 0.08 } } })
hl.curve("standardDecel", { type = "bezier", points = { { 0, 0 }, { 0, 1 } } })
hl.curve("stall", { type = "bezier", points = { { 1, -0.1 }, { 0.7, 0.85 } } })

hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "emphasizedDecel", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "emphasizedDecel", style = "popin 90%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, bezier = "emphasizedDecel", style = "slide" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 3, bezier = "emphasizedDecel" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "emphasizedDecel" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "emphasizedDecel" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 2.7, bezier = "emphasizedDecel", style = "popin 93%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2.4, bezier = "menu_accel", style = "popin 94%" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 0.5, bezier = "menu_decel" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 2.7, bezier = "stall" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 2.8, bezier = "emphasizedDecel", style = "slidevert" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 1.2, bezier = "emphasizedAccel", style = "slidevert" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 3, bezier = "standardDecel" })

-- Blur on shell layers for translucent glass effect
hl.layer_rule({ match = { namespace = "caelestia-drawers" }, blur = true })
hl.layer_rule({ match = { namespace = "quickshell" }, blur = true })

-- Super+Tab window overview (hyprexpose daemon)
hl.exec_cmd("pidof hyprexpose || hyprexpose --allow-mouse &")
hl.bind("SUPER + Tab", hl.dsp.exec_cmd("pkill -USR1 hyprexpose"))
hl.layer_rule({ match = { namespace = "hyprexpose" }, blur = true })
hl.layer_rule({ match = { namespace = "hyprexpose" }, ignore_alpha = 0.3 })

-- Disable special workspaces for Discord and Spotify
hl.unbind("SUPER + D")
hl.unbind("SUPER + M")
hl.window_rule({ match = { class = "discord|equibop|vesktop" }, workspace = "" })
hl.window_rule({ match = { class = "Spotify" }, workspace = "" })
hl.window_rule({ match = { initial_title = "Spotify( %(?Free%)?)?" }, workspace = "" })
