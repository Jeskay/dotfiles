local wezterm = require("wezterm")

local config = wezterm.config_builder()
-- Force modern key protocol
config.enable_kitty_keyboard = true

config.keys = {
  {
    key = "Backspace",
    action = wezterm.action.SendString("\u{7f}"),
  },
  -- Fix for numpads
  {
    key = 'Numpad3',
    mods = 'CTRL',
    action = wezterm.action.ActivateTabRelative(1)
  },
  -- Brute-force catch-all for Numpad PageUp (Previous Tab)
  { key = 'PageUp',   mods = 'CTRL',       action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'PageUp',   mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'Numpad9',  mods = 'CTRL',       action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'Numpad9',  mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },

  -- Brute-force catch-all for Numpad PageDown (Next Tab)
  { key = 'PageDown', mods = 'CTRL',       action = wezterm.action.ActivateTabRelative(1) },
  { key = 'PageDown', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'Numpad3',  mods = 'CTRL',       action = wezterm.action.ActivateTabRelative(1) },
  { key = 'Numpad3',  mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(1) }
}

config.font_size = 14
config.font = wezterm.font("SauceCodePro Nerd Font")
config.color_scheme = "nord"
config.window_background_opacity = 0.9

return config
