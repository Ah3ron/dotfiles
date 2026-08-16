local vars = require("modules/vars")
local exec = hl.exec_cmd

hl.on("hyprland.start", function()
	exec("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	-- exec("systemctl --user start hyprpolkitagent")
	exec("xrdb ~/.Xresources")
	exec(vars.config_dir .. "/scripts/portal.sh")

	exec("noctalia")
	exec(vars.terminal, { workspace = "1 silent" })
	exec(vars.browser, { workspace = "2 silent" })
end)
