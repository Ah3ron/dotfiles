local vars = require("modules/vars")
local m = vars.mainMod
local ipc = "noctalia msg "

local bind = hl.bind
local dsp = hl.dsp

local function dir_binds(mod, handler)
	for _, dir in ipairs({ "left", "right", "up", "down" }) do
		bind(mod .. dir, handler(dir))
	end
end

local function step(delta)
	return {
		left = { -delta, 0 },
		right = { delta, 0 },
		up = { 0, -delta },
		down = { 0, delta },
	}
end

local function resize_binds(delta, flags)
	for dir, xy in pairs(step(delta)) do
		bind(dir, dsp.window.resize({ x = xy[1], y = xy[2], relative = true }), flags)
	end
end

local function ipc_cmd(cmd)
	return dsp.exec_cmd(ipc .. cmd)
end

local function panel_toggle(key, panel)
	bind(m .. " + " .. key, ipc_cmd("panel-toggle " .. panel))
end

local step20 = step(20)

local lr = { locked = true, repeating = true }
local l = { locked = true }

bind(m .. " + Return", dsp.exec_cmd(vars.terminal))
bind(m .. " + C", dsp.window.close())
bind(m .. " + E", dsp.exec_cmd(vars.fileManager, { float = true, move = { 70, 40 } }))
bind(m .. " + P", dsp.window.pseudo())
bind(m .. " + F", dsp.window.fullscreen())
bind(m .. " + V", dsp.window.float({ action = "toggle" }))
bind(m .. " + apostrophe", dsp.focus({ window = "floating" }))
bind(m .. " + semicolon", dsp.focus({ window = "tiled" }))

dir_binds(m .. " + ", function(dir)
	return dsp.focus({ direction = dir })
end)

dir_binds(m .. " + SHIFT + ", function(dir)
	return dsp.window.move({ direction = dir })
end)

dir_binds(m .. " + ALT + ", function(dir)
	return dsp.window.move({ x = step20[dir][1], y = step20[dir][2], relative = true })
end)

dir_binds(m .. " + CTRL + ", function(dir)
	return dsp.window.resize({ x = step20[dir][1], y = step20[dir][2], relative = true })
end)

bind(m .. " + R", dsp.submap("resize"))
hl.define_submap("resize", function()
	resize_binds(10, { repeating = true })
	bind("escape", dsp.submap("reset"))
end)

for i = 1, 10 do
	local key = i % 10
	bind(m .. " + " .. key, dsp.focus({ workspace = i }))
	bind(m .. " + SHIFT + " .. key, dsp.window.move({ workspace = i, follow = false }))
end

-- bind(m .. " + grave", dsp.workspace.toggle_special("magic"))
-- bind(m .. " + SHIFT + grave", dsp.window.move({ workspace = "special:magic" }))
bind("SUPER + grave", function()
	hl.dispatch(dsp.workspace.toggle_special("minimize"))
	hl.dispatch(dsp.window.move({ workspace = "+0" }))
	hl.dispatch(dsp.workspace.toggle_special("minimize"))
	hl.dispatch(dsp.window.move({ workspace = "special:minimize" }))
	hl.dispatch(dsp.workspace.toggle_special("minimize"))
end)

panel_toggle("M", "session")
panel_toggle("SHIFT + C", "oldirtty/color_picker:panel")
panel_toggle("B", "clipboard")
panel_toggle("space", "launcher")

bind(m .. " + comma", ipc_cmd("settings-toggle"))
bind(m .. " + S", ipc_cmd("screenshot-fullscreen"))
bind(m .. " + SHIFT + S", ipc_cmd("screenshot-region"))
bind(m .. " + ALT + L", ipc_cmd("session lock"))
bind("ALT + Tab", ipc_cmd("window-switcher"))

bind("XF86AudioRaiseVolume", ipc_cmd("volume-up 3"), lr)
bind("XF86AudioLowerVolume", ipc_cmd("volume-down 3"), lr)
bind("XF86AudioMute", ipc_cmd("volume-mute"), l)
bind("XF86MonBrightnessUp", ipc_cmd("brightness-up current 5"), lr)
bind("XF86MonBrightnessDown", ipc_cmd("brightness-down current 5"), lr)

bind("XF86AudioNext", dsp.exec_cmd("playerctl next"), l)
bind("XF86AudioPause", dsp.exec_cmd("playerctl play-pause"), l)
bind("XF86AudioPlay", dsp.exec_cmd("playerctl play-pause"), l)
bind("XF86AudioPrev", dsp.exec_cmd("playerctl previous"), l)

bind(m .. " + mouse_down", dsp.focus({ workspace = "e+1" }))
bind(m .. " + mouse_up", dsp.focus({ workspace = "e-1" }))
bind(m .. " + mouse:272", dsp.window.drag(), { mouse = true })
bind(m .. " + mouse:273", dsp.window.resize(), { mouse = true })
