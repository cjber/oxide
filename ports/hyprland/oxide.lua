-- Oxide palette for Hyprland 0.55+ (Lua config).
-- Usage: require this module and reference the colors in hl.config calls.
--
--   local oxide = require("oxide")  -- if dropped at ~/.config/hypr/oxide.lua
--   hl.config({ general = { col = { active_border = oxide.primary } } })
--
-- Hyprland color strings need rgb()/rgba() wrapping, so each value is
-- pre-formatted as `rgb(rrggbb)`.

return {
    background       = "rgb(121113)",
    background_alt   = "rgb(0a0a0a)",
    surface          = "rgb(1a1a1c)",
    surface_alt      = "rgb(222222)",
    border           = "rgb(333333)",
    foreground       = "rgb(c1c1c1)",
    foreground_dim   = "rgb(777777)",
    primary          = "rgb(e78a53)",
    primary_dim      = "rgb(d77a43)",
    secondary        = "rgb(5f8787)",
    secondary_bright = "rgb(6f9797)",
    accent           = "rgb(fbcb97)",
    destructive      = "rgb(c75a5a)",
    success          = "rgb(6a9955)",
}
