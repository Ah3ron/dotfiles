-- Cursor theme derived from matugen primary color.
-- At config load: read .matugen-primary and set env vars so freshly spawned
-- apps inherit the correct cursor theme. Live updates are applied by the
-- matugen post_hook (scripts/cursor-accent.lua -> hyprctl setcursor).

local vars = require("modules/vars")
local accent = dofile(vars.config_dir .. "/scripts/cursor-accent.lua")

local theme = accent.default
local hex = accent.read_primary()
if hex then
	local ok, t = pcall(accent.theme_for_hex, hex)
	if ok and t then
		theme = t
	end
end

local size = accent.size
local env = hl.env

env("HYPRCURSOR_THEME", theme)
env("XCURSOR_THEME", theme)
env("HYPRCURSOR_SIZE", size)
env("XCURSOR_SIZE", size)

hl.config({
	cursor = {
		inactive_timeout = 1,
	},
})
