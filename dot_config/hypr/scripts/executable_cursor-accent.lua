#!/usr/bin/env lua
-- Catppuccin Mocha cursor accent picker.
--   Module API:  local A = dofile("cursor-accent.lua"); A.from_hex("89b4fa")
--   CLI debug:   lua cursor-accent.lua 89b4fa            -> prints accent name
--   CLI apply:   lua cursor-accent.lua                  -> reads .matugen-primary
--                                                            and runs hyprctl setcursor
--                                                         (this is the matugen post_hook)

local home = os.getenv("HOME")
local cfg_dir = (os.getenv("XDG_CONFIG_HOME") or (home .. "/.config")) .. "/hypr"

local A = {
	cfg_dir = cfg_dir,
	primary_path = cfg_dir .. "/.matugen-primary",
	size = "24",
	default = "catppuccin-mocha-yellow-cursors",
	prefix = "catppuccin-mocha-",
	suffix = "-cursors",
}

-- Catppuccin Mocha accent palette (sRGB).
A.accents = {
	{ "rosewater", 245, 224, 220 },
	{ "flamingo", 242, 205, 205 },
	{ "pink", 245, 194, 231 },
	{ "mauve", 203, 166, 247 },
	{ "red", 243, 139, 168 },
	{ "maroon", 235, 160, 172 },
	{ "peach", 250, 179, 135 },
	{ "yellow", 249, 226, 175 },
	{ "green", 166, 227, 161 },
	{ "teal", 148, 226, 213 },
	{ "sky", 137, 220, 235 },
	{ "sapphire", 116, 199, 236 },
	{ "blue", 137, 180, 250 },
	{ "lavender", 180, 190, 254 },
}

function A.parse_hex(hex)
	hex = hex:lower():gsub("[%s#{}]", "")
	local r, g, b = hex:match("^(%x%x)(%x%x)(%x%x)$")
	if not r then
		error("invalid hex: " .. hex, 0)
	end
	return tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
end

-- Weighted squared Euclidean distance (ITU-R BT.601 luma weights).
function A.nearest(r, g, b)
	local best_name, best_dist
	for _, a in ipairs(A.accents) do
		local dr, dg, db = r - a[2], g - a[3], b - a[4]
		local dist = 299 * dr * dr + 587 * dg * dg + 114 * db * db
		if not best_dist or dist < best_dist then
			best_dist, best_name = dist, a[1]
		end
	end
	return best_name
end

function A.from_hex(hex)
	local r, g, b = A.parse_hex(hex)
	return A.nearest(r, g, b)
end

function A.theme_for_hex(hex)
	return A.prefix .. A.from_hex(hex) .. A.suffix
end

-- Read primary hex written by matugen; returns nil if file is missing.
function A.read_primary()
	local f = io.open(A.primary_path, "r")
	if not f then
		return nil
	end
	local hex = f:read("*a")
	f:close()
	return hex
end

-- Force-set cursor env vars in the running compositor.
function A.apply_env(theme)
	local size = A.size
	for _, e in ipairs({
		{ "HYPRCURSOR_THEME", theme },
		{ "XCURSOR_THEME", theme },
		{ "HYPRCURSOR_SIZE", size },
		{ "XCURSOR_SIZE", size },
	}) do
		os.execute(([[hyprctl eval 'hl.env("%s", "%s")' >/dev/null 2>&1]]):format(e[1], e[2]))
	end
end

-- Apply cursor live: `hyprctl setcursor <theme> <size>`.
function A.apply(hex)
	local theme = A.theme_for_hex(hex)
	os.execute(("hyprctl setcursor %s %s >/dev/null 2>&1"):format(theme, A.size))
	A.apply_env(theme)
	return theme
end

-- Entry point: only when run as a script (not via dofile/require).
if arg and arg[0] and arg[0]:match("cursor%-accent%.lua$") then
	if arg[1] then
		print(A.from_hex(arg[1])) -- debug: hex -> accent name
	else
		local hex = A.read_primary() -- post_hook mode
		if not hex then
			os.exit(1)
		end
		local ok, err = pcall(A.apply, hex)
		if not ok then
			io.stderr:write(err, "\n")
			os.exit(1)
		end
	end
end

return A
