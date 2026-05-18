# Oxide

A dark colour scheme with rust-orange, teal, and peach accents. Designed around a single, restrained palette — one hue family per role, no second variant.

| token              | hex       | swatch |
| ------------------ | --------- | ------ |
| `background`       | `#121113` | ![](https://img.shields.io/badge/-121113-121113?style=flat-square) |
| `background_alt`   | `#0a0a0a` | ![](https://img.shields.io/badge/-0a0a0a-0a0a0a?style=flat-square) |
| `surface`          | `#1a1a1c` | ![](https://img.shields.io/badge/-1a1a1c-1a1a1c?style=flat-square) |
| `surface_alt`      | `#222222` | ![](https://img.shields.io/badge/-222222-222222?style=flat-square) |
| `border`           | `#333333` | ![](https://img.shields.io/badge/-333333-333333?style=flat-square) |
| `foreground`       | `#c1c1c1` | ![](https://img.shields.io/badge/-c1c1c1-c1c1c1?style=flat-square) |
| `foreground_alt`   | `#b0b0b0` | ![](https://img.shields.io/badge/-b0b0b0-b0b0b0?style=flat-square) |
| `foreground_dim`   | `#777777` | ![](https://img.shields.io/badge/-777777-777777?style=flat-square) |
| `comment`          | `#555555` | ![](https://img.shields.io/badge/-555555-555555?style=flat-square) |
| `muted`            | `#999999` | ![](https://img.shields.io/badge/-999999-999999?style=flat-square) |
| `primary`          | `#e78a53` | ![](https://img.shields.io/badge/-e78a53-e78a53?style=flat-square) |
| `primary_dim`      | `#d77a43` | ![](https://img.shields.io/badge/-d77a43-d77a43?style=flat-square) |
| `secondary`        | `#5f8787` | ![](https://img.shields.io/badge/-5f8787-5f8787?style=flat-square) |
| `secondary_bright` | `#6f9797` | ![](https://img.shields.io/badge/-6f9797-6f9797?style=flat-square) |
| `accent`           | `#fbcb97` | ![](https://img.shields.io/badge/-fbcb97-fbcb97?style=flat-square) |
| `destructive`      | `#c75a5a` | ![](https://img.shields.io/badge/-c75a5a-c75a5a?style=flat-square) |
| `success`          | `#6a9955` | ![](https://img.shields.io/badge/-6a9955-6a9955?style=flat-square) |

The canonical palette lives in [`palette/oxide.json`](palette/oxide.json) (with terminal ANSI aliases) and [`palette/oxide.css`](palette/oxide.css) (CSS variables).

## Ports

| app | path | install |
| --- | --- | --- |
| Neovim | [`ports/nvim/colors/oxide.lua`](ports/nvim/colors/oxide.lua) | drop into `~/.config/nvim/colors/`, then `:colorscheme oxide` |
| Zellij | [`ports/zellij/themes/oxide.kdl`](ports/zellij/themes/oxide.kdl) | drop into `~/.config/zellij/themes/`, then `theme "oxide"` in your config |
| Hyprland | [`ports/hyprland/oxide.lua`](ports/hyprland/oxide.lua) | drop at `~/.config/hypr/oxide.lua`, `local oxide = require("oxide")` |
| Niri | [`ports/niri/oxide.kdl`](ports/niri/oxide.kdl) | merge blocks into `~/.config/niri/config.kdl` |
| Waybar | [`ports/waybar/oxide.css`](ports/waybar/oxide.css) | `@import` from your waybar `style.css` |
| Yazi | [`ports/yazi/oxide.toml`](ports/yazi/oxide.toml) | drop into `~/.config/yazi/theme.toml` |
| Rofi | [`ports/rofi/oxide.rasi`](ports/rofi/oxide.rasi) | drop into `~/.config/rofi/`, then `@theme "oxide"` |
| Kitty | [`ports/kitty/oxide.conf`](ports/kitty/oxide.conf) | `include oxide.conf` in `~/.config/kitty/kitty.conf` |
| Starship | [`ports/starship/oxide.toml`](ports/starship/oxide.toml) | `~/.config/starship.toml` (or `STARSHIP_CONFIG`) |
| Mako | [`ports/mako/config`](ports/mako/config) | drop into `~/.config/mako/config` |
| Swaylock | [`ports/swaylock/config`](ports/swaylock/config) | drop into `~/.config/swaylock/config` |
| Hyprshell | [`ports/hyprshell/styles.css`](ports/hyprshell/styles.css) | drop into `~/.config/hyprshell/styles.css` |
| Bottom | [`ports/bottom/oxide.toml`](ports/bottom/oxide.toml) | drop into `~/.config/bottom/bottom.toml` |

Every port here was extracted from a config I run day-to-day. Issues or new app ports welcome via PR.

## Adding a port

1. Add `ports/<app>/<theme-file>` using only colours from [`palette/oxide.json`](palette/oxide.json). The CI checks every hex literal under `ports/` against the palette and fails on any colour not present (case-insensitive).
2. Add a row to the table above with the install path.
3. Open a PR.

## License

[MIT](LICENSE)
