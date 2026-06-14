local wezterm = require("wezterm")

local config = wezterm.config_builder()
-- Force modern key protocol
config.enable_kitty_keyboard = true

config.keys = {
	{
		key = "Backspace",
    action = wezterm.action.SendString("\u{7f}"),
	},
}

config.font_size = 14
config.font = wezterm.font("SauceCodePro Nerd Font")
config.color_scheme = "nord"
config.window_background_opacity = 0.9

return config
