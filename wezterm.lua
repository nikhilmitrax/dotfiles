local wezterm = require("wezterm")
local mux = wezterm.mux

local config = {}
local pane_arches = {}

-- Configurable variables
local default_arch = "x86_64" -- Set to "arm64" or "x86_64"
local alternate_arch = "arm64" -- The other architecture
local fish_paths = {
	["arm64"] = "/opt/homebrew/bin/fish",
	["x86_64"] = "/usr/local/bin/fish",
}

config.default_prog = { fish_paths[default_arch] }
config.front_end = "WebGpu"
config.color_scheme = "Adventure"
config.font_size = 14

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.inactive_pane_hsb = {
	saturation = 0.3,
	brightness = 0.5,
}

-- Function to spawn a new tab with a given architecture
local function spawn_tab_with_arch(window, arch)
	local fish_path = fish_paths[arch]
	if not fish_path then
		wezterm.log_error("Unsupported architecture: " .. tostring(arch))
		window:toast_notification("Error", "Unsupported architecture: " .. tostring(arch), nil, 5000)
		return
	end

	local cmd = {}
	if arch == "arm64" then
		cmd = { fish_path } -- ARM Fish
	elseif arch == "x86_64" then
		cmd = { fish_path } -- x86 Fish
	else
		wezterm.log_error("Unsupported architecture: " .. tostring(arch))
		window:toast_notification("Error", "Unsupported architecture: " .. tostring(arch), nil, 5000)
		return
	end

	local tab, pane, pane_window = window:mux_window():spawn_tab({
		args = cmd,
	})

	-- Store the architecture using the new pane's ID
	pane_arches[pane:pane_id()] = arch
end

-- Function to split pane with the same architecture
local function split_pane_with_same_arch(window, pane, direction)
	local arch = pane_arches[pane:pane_id()]
	if not arch then
		wezterm.log_error("Architecture not set for current pane.")
		window:toast_notification("Error", "Architecture not set for current pane.", nil, 5000)

		arch = default_arch
	end
	local fish_path = fish_paths[arch]
	if not fish_path then
		wezterm.log_error("Unsupported architecture: " .. tostring(arch))
		window:toast_notification("Error", "Unsupported architecture: " .. tostring(arch), nil, 5000)
		return
	end

	local cmd = {}
	if arch == "arm64" then
		cmd = { fish_path } -- ARM Fish
	elseif arch == "x86_64" then
		cmd = { fish_path } -- x86 Fish
	else
		window:toast_notification("Error", "Unsupported architecture: " .. tostring(arch), nil, 5000)
		return
	end

	local new_pane = pane:split({
		direction = direction,
		size = 0.5,
		args = cmd,
	})

	-- Store the architecture for the new pane
	pane_arches[new_pane:pane_id()] = arch
end

-- Clean up pane_arches when panes are closed
wezterm.on("pane-will-destroy", function(pane)
	local pane_id = pane:pane_id()
	pane_arches[pane_id] = nil
end)

-- Spawn the initial window with the default architecture
local function spawn_initial_window()
	local arch = default_arch
	local fish_path = fish_paths[arch]
	wezterm.log_info("Fish path: " .. tostring(fish_path))
	if not fish_path then
		wezterm.log_error("Unsupported architecture: " .. tostring(arch))
		return
	end

	local cmd = {}
	if arch == "arm64" then
		cmd = { fish_path } -- ARM Fish
	elseif arch == "x86_64" then
		cmd = { fish_path } -- x86 Fish
	else
		wezterm.log_error("Unsupported architecture: " .. tostring(arch))
		return
	end

	local tab, pane, window = mux.spawn_window({
		args = cmd,
	})

	-- Store the architecture using the pane's ID
	pane_arches[pane:pane_id()] = arch
end

-- Use the 'mux-startup' event to create the initial window
wezterm.on("mux-startup", function()
	-- Spawn the initial window with the default architecture
	wezterm.log_info("starting mux ")
	spawn_initial_window()
end)

config.keys = {
	-- Open new tab with default architecture Fish shell (CMD+T)
	{
		key = "t",
		mods = "CMD",
		action = wezterm.action_callback(function(window, pane)
			spawn_tab_with_arch(window, default_arch)
		end),
	},
	-- Open new tab with alternate architecture Fish shell (CMD+SHIFT+T)
	{
		key = "t",
		mods = "CMD|SHIFT",
		action = wezterm.action_callback(function(window, pane)
			spawn_tab_with_arch(window, alternate_arch)
		end),
	},
	-- Split pane to the right with the same architecture (CMD+D)
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action_callback(function(window, pane)
			split_pane_with_same_arch(window, pane, "Right")
		end),
	},
	-- Split pane downward with the same architecture (CMD+SHIFT+D)
	{
		key = "d",
		mods = "CMD|SHIFT",
		action = wezterm.action_callback(function(window, pane)
			split_pane_with_same_arch(window, pane, "Bottom")
		end),
	},
	-- Other key bindings (navigation, closing panes, etc.)
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "h",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "b",
		mods = "CMD",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "P",
		mods = "CMD",
		action = wezterm.action.ActivateCommandPalette,
	},
}

return config
