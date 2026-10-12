hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1",
})

-- local terminal    = "kitty"
local terminal         = "alacritty"
local fileManager      = "nautilus"
local browser          = "/opt/zen-browser-bin/zen-bin"
-- local fileManager = "dolphin"
-- local menu        = "wofi --show drun"
local menu             = "rofi -show drun -show-icons"
local clipboardHistory = "cliphist list | rofi -dmenu -p 'Clipboard' | cliphist decode | wl-copy"


--
hl.on("hyprland.start", function()
    hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("dunst")
    hl.exec_cmd("sh -c 'cliphist wipe && wl-paste --watch cliphist store'")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("hypridle")
end)


-- ─── Environment Variables ───────────────────────────────────────────────────

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-- ─── Look and Feel ───────────────────────────────────────────────────────────

--  Color palette (warm stone + forest accent)
--    active border  : soft warm stone  #a89984  (Gruvbox stone)
--    inactive border: near-black       #1d2021
--    glow accent    : deep forest      #689d6a  (muted sage green)

hl.config({
    general = {
        gaps_in          = 2,
        gaps_out         = 5,
        border_size      = 1,

        col              = {
            active_border   = "rgba(a6adc888)", -- subtle, soft muted border
            inactive_border = "rgba(31324444)", -- very faint dark border
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding         = 10,
        active_opacity   = 1.0,
        inactive_opacity = 0.96,

        shadow           = {
            enabled      = false,
            range        = 20,
            render_power = 3,
            color        = "rgba(1a1a1a55)", -- very soft shadow, barely visible
        },

        blur             = {
            enabled           = false,
            size              = 6,
            passes            = 2,
            new_optimizations = true,
        },
    },

    animations = {
        enabled = false,
    },
})


-- ─── Animations ──────────────────────────────────────────────────────────────

-- Smooth and deliberate.  Nothing jumpy.  Like pages turning, not phone games.

hl.curve("mountain", { type = "bezier", points = { { 0.25, 0.1 }, { 0.25, 1.0 } } })
hl.curve("settle", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 6, bezier = "mountain" })
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "settle" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "settle", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "quick", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 4, bezier = "mountain" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "mountain" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2.5, bezier = "mountain" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "settle" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "settle", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "quick", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2.5, bezier = "mountain" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 2, bezier = "quick" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "settle", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3, bezier = "settle", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2.5, bezier = "quick", style = "slide" })


-- ─── Layout ──────────────────────────────────────────────────────────────────

hl.config({
    dwindle = {
        preserve_split = true,
        smart_split    = false,
        force_split    = 2,
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})


-- ─── Misc ────────────────────────────────────────────────────────────────────

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms  = true,
    },
})


-- ─── Input ───────────────────────────────────────────────────────────────────

hl.config({
    input = {
        kb_layout    = "us",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "",
        kb_rules     = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad     = {
            natural_scroll = true, -- feels more natural on a laptop
            tap_to_click   = true,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})


-- ─── Keybindings ─────────────────────────────────────────────────────────────

local mainMod = "SUPER"

-- Core
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
-- hl.bind(mainMod .. " + V",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(clipboardHistory))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + L",
    hl.dsp.exec_cmd("sh -c \"hyprlock & sleep 0.5 && hyprctl dispatch \\\"hl.dsp.dpms('off')\\\"\""))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian"))
-- hl.bind(mainMod .. " + M",         hl.dsp.exec_cmd(
--    "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
-- ))

-- Screenshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh area"))
hl.bind("Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh screen"))

-- Focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Workspaces
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.move({ workspace = "special:magic" }))

-- Mouse workspace scrolling
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse drag / resize
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media / brightness keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"),
    { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })


-- ─── Window Rules ────────────────────────────────────────────────────────────

-- Suppress maximize requests globally
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix XWayland drag issues
hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- hyprland-run popup placement
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})
