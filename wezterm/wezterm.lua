local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Keybinding Settings

config.enable_kitty_keyboard = true

-- Leader Key
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- Pane splitting
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
	-- Fix for backspace in zshell
	{
		key = "Backspace",
		action = wezterm.action.SendString("\u{7f}"),
	},
	-- Fix for numpads
	{
		key = "Numpad3",
		mods = "CTRL",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "!",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			pane:move_to_new_window()
		end),
	},
	-- Brute-force catch-all for Numpad PageUp (Previous Tab)
	{ key = "PageUp", mods = "CTRL", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "PageUp", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "Numpad9", mods = "CTRL", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "Numpad9", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },

	-- Brute-force catch-all for Numpad PageDown (Next Tab)
	{ key = "PageDown", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "PageDown", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "Numpad3", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "Numpad3", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
}

-- Work around WezTerm's Kitty encoder lowercasing shifted non-ASCII keys.
local russian_uppercase = "ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮЁ"
for _, codepoint in utf8.codes(russian_uppercase) do
	local upper = utf8.char(codepoint)
	table.insert(config.keys, {
		key = "mapped:" .. upper,
		mods = "SHIFT",
		action = wezterm.action.SendString(upper),
	})
end

-- Appearance Settings

config.font_size = 14
config.font = wezterm.font("SauceCodePro Nerd Font")
config.color_scheme = "nord"
-- Tow-Layered background
config.background = {
  {
    source = {
      Color = "#2e3440"
    },
    width = "100%",
    height = "100%",
    opacity = 1.0,
  },
	{
		source = {
			File = "/home/jeskay/Pictures/wallpapers/current.png",
		},
		vertical_align = "Middle",
		horizontal_align = "Center",
		height = "Cover",
		width = "Cover",
		opacity = 0.1,
		hsb = {
			brightness = 0.2,
			saturation = 0.5,
		},
	},
}
-- SSH Settings
config.ssh_domains = {
  {
    name = 'lenovo-laptop',
    remote_address = '10.133.0.76',
    username = 'khrolenko',
    multiplexing = "WezTerm",
    remote_wezterm_path = '/usr/bin/wezterm',
  }
}

return config
