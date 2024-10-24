-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'

----
-- font
config.font_size = 11.0
config.font = wezterm.font("DejaVu Sans Mono", {weight="Book", stretch="Normal", style="Normal"})
config.font = wezterm.font("MesloLGS NF", {weight="Regular", stretch="Normal", style="Normal"})

-- colors
config.color_scheme = "Catppuccin Mocha"

-- config.window_decorations = "RESIZE"

-- bindings
-- https://wezfurlong.org/wezterm/config/default-keys.html?h=arrow
config.keys = {

  { key = 'LeftArrow', 
    mods = 'CTRL|SHIFT', 
    action = wezterm.action.ActivateTabRelative(-1) 
  },
  { key = 'RightArrow', 
    mods = 'CTRL|SHIFT', 
    action = wezterm.action.ActivateTabRelative(1) 
  },

  { key = 'UpArrow', 
  mods = 'SHIFT', 
  action = wezterm.action.ActivatePaneDirection("Up") 
  },
  { key = 'DownArrow', 
    mods = 'SHIFT', 
    action = wezterm.action.ActivatePaneDirection("Down")
  },

  {
    key = 'F1',
    mods = '',
    action = wezterm.action.QuickSelectArgs {
      patterns = { 
        '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'
      },
    },
  },
  {
    key = 'F2',
    mods = '',
    action = wezterm.action.QuickSelectArgs {
      patterns = {
        'https?://\\S+',
      },
    },
  },

  { 
    key = 'p',
    mods = 'CTRL',
    action = wezterm.action.PaneSelect {
      alphabet = '1234567890',
    },
  },
  {
    key = 'r',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ReloadConfiguration,
  },
  {
    key = 'Enter',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  }
}

-- and finally, return the configuration to wezterm
return config
